import 'dart:convert';
import '../util/pair.dart';
import 'package:http/http.dart' as http;

class BaseHttp {
  String host = "http://localhost:4242";
  final tokenKey = "_token";
  static late String token = "";

  Uri setUri(String path) {
    return Uri.parse(host + path);
  }

  Map<String, String> addHeaders(bool withToken) {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (withToken) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  Future<bool> verifyToken(String t) async {
    token = t;
    var url = setUri("/verify_token");
    final response = await http.post(url, headers: addHeaders(true));

    if (response.statusCode == 200) {
      return true;
    }

    token = "";

    return false;
  }

  Future<Result<String>> login(String email, String password) async {
    var url = setUri("/login");
    final response = await http.post(url,
        body: json.encode({"email": email, "password": password}));

    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode != 200 || data["token"] == null) {
      return Result("", Error(data["error"]));
    }

    token = data["token"];
    return Result(data["token"], null);
  }

  Future<Result<String>> register(Map<String, dynamic> registerData) async {
    var url = setUri("/register");
    final response = await http.post(url, body: json.encode(registerData));
    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode != 200 || data["token"] == null) {
      return Result("", Error(data["error"]));
    }

    token = data["token"];
    return Result(data["token"], null);
  }
}
