import 'package:business_wallet/model/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../http/remote.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Remote remote = Remote();
  List<Event> allAttendedEvents = [];
  List<Event> a = [];
  List<Event> b = [];

  List<Event> eventsPerDay = [];

  @override
  void initState() {
    super.initState();

    getCurrentEvents().then((value) => setState(() {
          allAttendedEvents.add(value.data);
          a = value.data;
        }));

    getPastEvents().then((value) => setState(() {
          allAttendedEvents.add(value.data);
        }));
  }

  getCurrentEvents() async {
    return await remote.currentEvents();
  }

  getPastEvents() async {
    return await remote.pastEvents();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    //burada spesifik tarihteki eventler döndürülecek
    DateTime newDate = DateTime(date.year, date.month, date.day);
    eventsPerDay = allAttendedEvents
        .where((i) =>
            i.start.year == newDate.year &&
            i.start.month == newDate.month &&
            i.start.day == newDate.day)
        .toList();
    // print("eventsperday:");
    // print(eventsPerDay.length);
    // print("allattendedevents:");
    // print(allAttendedEvents.length);
    // print(date);
    // print(newDate);
    // print(a.length);
    return eventsPerDay;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: focusedDay,
          firstDay: DateTime(2010),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekVisible: true,
          //Day changed
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
            print(focusedDay);
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          //To style the calendar
          calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue.shade400,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                  color: Colors.purple.shade200, shape: BoxShape.circle)),
          headerStyle: const HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
        ),
        ..._getEventsFromDay(selectedDay).map(
          (Event e) => ListTile(
            tileColor: Colors.black87,
            leading: const Icon(Icons.event, color: Colors.white),
            //same over here
            title: Text(
              e.description,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),

            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: () {
                /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventDetailsPage(
                    );
                    */
              },
            ),
          ),
        )
      ],
    );
  }
}
