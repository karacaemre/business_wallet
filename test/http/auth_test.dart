import 'package:business_wallet/http/remote.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login test', () async {
    Remote auth = Remote();

    var result = await auth.login("ahmet@test.com", "testk");

    expect(result.error, isNotNull);
  });
}
