import 'package:business_wallet/http/remote.dart';
import 'package:business_wallet/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("user tests", () {
    Remote r = Remote();
    User? me;

    test("user getMe test", () async {
      await r.login("ahmet@test.com", "testpsw");

      var resp = await r.getMe();

      debugPrint("${resp.getError}");
      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      me = resp.getData;
    });

    test("add contact", () async {

      debugPrint("${me!.contacts}");

      var resp = await r.addContact(me!.id + 2);
      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      debugPrint("${resp.getError}");

      me = await r.getMe().then((me) => me.getData);

      debugPrint("${me!.contacts}");

      expect(me?.contacts?.contains(me!.id + 2), true);
    });

    test("delete contact", () async {
      var resp = await r.deleteContact(me!.id + 2);
      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      print("${resp.getError}");

      me = await r.getMe().then((me) => me.getData);

      debugPrint("${me!.contacts}");

      expect(me?.contacts?.contains(me!.id + 2), false);
    });
  });
}
