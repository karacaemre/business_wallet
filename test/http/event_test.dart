import 'package:business_wallet/http/remote.dart';
import 'package:business_wallet/model/event.dart';
import 'package:business_wallet/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("event test", () {
    Remote r = Remote();
    Remote r2 = Remote();
    Event? createdEvent;
    User? user2;

    setUp(() async {
      await r.login("ahmet@test.com", "testpsw");
      await r2.login("gizem@test.com", "testpsw");

      var resp = await r2.getMe();

      user2 = resp.data;
    });

    test('create event test', () async {
      Event e = Event("test event", "this is a test event", DateTime.now(),
          DateTime.now().add(const Duration(hours: 4)));

      var resp = await r2.createEvent(e);

      debugPrint("${resp.getError?.getString}");
      debugPrint("${resp.getData}");

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      createdEvent = resp.data;
    });

    test('past event test', () async {
      await r.login("ahmet@test.com", "testpsw");
      var resp = await r.pastEvents();

      debugPrint("${resp.getError}");

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);
    });

    test('current event test', () async {
      var resp = await r.currentEvents();

      debugPrint("${resp.getError}");

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);
    });

    test('active event test', () async {
      var resp = await r.activeEvents();

      debugPrint("${resp.getError}");

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);
    });

    test(
      'get event test',
      () async {
        var resp = await r.getEvent(createdEvent!.id);
        expect(resp.data, isNotNull);
        expect(resp.error, isNull);

        debugPrint("${resp.getError}");

        expect(resp.data?.name == createdEvent?.name, true);
        expect(resp.data?.id == createdEvent?.id, true);
        expect(resp.data?.description == createdEvent?.description, true);
      },
    );

    test("test attend event", () async {
      var resp = await r.attendEvent(createdEvent!.id);
      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      debugPrint("${resp.getError}");

      expect(resp.data, true);
    });

    test("test event together", () async {
      var resp = await r.eventTogether(user2!.id);

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      debugPrint("${resp.getError}");
      debugPrint("${resp.getData}");
    });

    test("test leave event", () async {
      var resp = await r.leaveEvent(createdEvent!.id);

      expect(resp.data, isNotNull);
      expect(resp.error, isNull);

      print("${resp.getError}");
    });
  });
}
