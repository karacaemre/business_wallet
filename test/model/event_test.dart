
import 'dart:convert';

import 'package:business_wallet/model/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
    test('event class test',()
    {
        String eventJson = '{"id":1,"name":"test event","description":"first event for test","organizers":[3],"attendees":[1,2,3,4]}';

        Event e = Event.fromJson(json.decode(eventJson));

        expect( e.name, "test event");
        List<int> expectedAttendees = [1,2,3,4];
        expect(e.attendees, expectedAttendees);
        expect(json.encode(e), eventJson);
    });
}