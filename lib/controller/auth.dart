import 'package:business_wallet/controller/token_storage.dart';
import 'package:business_wallet/util/pair.dart';
import 'package:flutter/material.dart';
import '../http/remote.dart';
import '../model/user.dart';

class Auth extends ChangeNotifier {
  bool loggedIn = true;
  String token = "";
  late User user;

  Remote remote = Remote();
  TokenStorage tokenStorage = TokenStorage();

  Auth() {
    checkLocal();
  }

  checkLocal() async {
    var ret = false;
    var token = await tokenStorage.get();
    if (token != null) {
      ret = await remote.verifyToken(token);
    }
    var result = await remote.getMe();
    if (result.error != null) {
      setLoggedIn(false);
      return;
    }

    setLoggedIn(ret);
    user = result.data;
  }

  Future<Error?> login(String email, password) async {
    //email = "ahmet@test.com";
    //password = "test";
    var result = await remote.login(email, password);
    if (result.error == null) {
      token = result.data;
      tokenStorage.save(token);
      var me = await remote.getMe();
      user = me.data;
      setLoggedIn(true);
      return null;
    }

    return result.error;
  }

  Future<Error?> register(String name, surname, email, password,
      {phone, linkedin, company}) async {
    var result = await remote.register(<String, dynamic>{
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
      "phone": phone,
      "linkedin": linkedin,
      "company": company
    });

    if (result.error == null) {
      token = result.data;
      tokenStorage.save(token);
      var me = await remote.getMe();
      user = me.data;

      setLoggedIn(true);
      return null;
    }

    return result.error;
  }

  setLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }

  Future<void> logout() async {
    tokenStorage.delete();
    setLoggedIn(false);
  }
}
