import 'package:business_wallet/model/event.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../http/remote.dart';
import 'event_details.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Remote remote = Remote();
  List<Event> activeEvents = [];
  List<Event> pastEvents = [];
  List<Event> currentEvents = [];

  Event newEvent = Event("", "", DateTime.now(), DateTime.now());

  @override
  void initState() {
    super.initState();

    getActiveEvents().then((value) => setState(() {
          activeEvents = value.data;
        }));

    getCurrentEvents().then((value) => setState(() {
          currentEvents = value.data;
        }));

    getPastEvents().then((value) => setState(() {
          pastEvents = value.data;
        }));
  }

  getActiveEvents() async {
    return await remote.activeEvents();
  }

  getCurrentEvents() async {
    return await remote.currentEvents();
  }

  getPastEvents() async {
    return await remote.pastEvents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Event",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.all(10),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.black,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(child: Text("active")),
              Tab(child: Text("my events")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _getListBox(activeEvents, "active"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getListBox(currentEvents, "current"),
                _getListBox(pastEvents, "past"),
              ],
            )
          ],
        ),
        floatingActionButton: _newEventButton(context),
      ),
    );
  }

  Widget _newEventButton(context) {
    return FloatingActionButton(
      heroTag: context.toString(),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: const Text('New Event'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newEvent.name = value;
                },
                decoration: const InputDecoration(hintText: "Event name"),
              ),
              TextField(
                onChanged: (value) {
                  newEvent.description = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(hintText: "Description"),
              ),
              //organizer zaten kullanıcının kendisi, texfielda gerek yok
              DateTimeField(
                format: DateFormat('dd-MM-yyyy HH:mm'),
                decoration: const InputDecoration(hintText: "Start Time"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()));
                    newEvent.start = DateTimeField.combine(date, time);
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              DateTimeField(
                format: DateFormat('dd-MM-yyyy HH:mm'),
                decoration: const InputDecoration(hintText: "Finish Time"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050));
                  if (date != null) {
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()));
                    newEvent.finish = DateTimeField.combine(date, time);
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  remote.createEvent(newEvent);

                  getActiveEvents().then((value) => setState(() {
                        activeEvents = value.data;
                      }));

                  getCurrentEvents().then((value) => setState(() {
                        currentEvents = value.data;
                      }));

                  getPastEvents().then((value) => setState(() {
                        pastEvents = value.data;
                      }));
                });
                Navigator.pop(context, 'Add');
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      // Respond to button press
      child: const Icon(Icons.add),
    );
  }

  Widget _getListBox(List<Event> e, String head) {
    if (e.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SizedBox(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: e.length,
          itemBuilder: (context, index) {
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ListTile(
                tileColor: Colors.black87,
                leading: const Icon(Icons.event, color: Colors.white),
                //same over here
                title: Text(
                  e[index].description,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  e[index].start.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),

                trailing: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EventDetails(event: e[index])));
                  },
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
