import 'dart:convert';

import 'package:business_wallet/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('user from json', () {
    String userJson =
        '{"ID":1,"name":"Ahmet","surname":"Şenharputlu","phone":"00901234567890",'
        '"email":"user@example.com","linkedin":"www.linkedin.com/in/example","company":"Business Wallet"}';

    User u = User.fromJson(json.decode(userJson));

    expect(u.name, "Ahmet");
    expect(u.company, "Business Wallet");
    expect(u.linkedin, "www.linkedin.com/in/example");
  });

  test("constructor test", () {
    User u = User("Ahmet", "Şenharptulu", "00901234567890");

    expect(u.name, "Ahmet");
    expect(u.email, null);
  });

  test("add contact", () {
    User u = User("Ahmet", "Şenharptulu", "00901234567890");

    User u2 = User("second", "user", "238641741097");

    u.addContact(2);

    List<int> expectedContactList = [2];
    expect(u.contacts, expectedContactList);
  });
}
