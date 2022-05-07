import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = const FlutterSecureStorage();
  String tokenKey = "_token";

  void save(String value) async {
    await storage.write(key: tokenKey, value: value);
  }

  Future<String?> get() async {
    return await storage.read(key: tokenKey);
  }

  void delete() async {
    await storage.delete(key: tokenKey);
  }
}
