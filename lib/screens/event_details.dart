import 'dart:ui';

import 'package:business_wallet/controller/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../http/remote.dart';
import '../model/event.dart';
import '../model/user.dart';

class EventDetails extends StatefulWidget {
  Event event;
  EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Remote remote = Remote();
  User organizerInfo = User("", "", "");
  List<int> commonAttendees = [];
  List<User> commonAttendeesInfo = [];
  // List<String> attendees = [];
  late bool isAttending;
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();

    isAttending = checkIfAttending();

    getContactInfo(widget.event.organizer).then((value) => setState(() {
          organizerInfo = value.data;
        }));

    for (var contact in Remote.user.contacts!) {
      if (widget.event.attendees!.contains(contact)) {
        commonAttendees.add(contact);
      }
    }

    for (var contactId in commonAttendees) {
      getContactInfo(contactId).then((value) => setState(() {
            commonAttendeesInfo.add(value.data);
          }));
    }
  }

  getContactInfo(int id) async {
    return await remote.getContact(id);
  }

  bool checkIfAttending() {
    bool status = false;
    widget.event.attendees?.forEach((element) {
      if (element == Remote.user.id) status = true;
    });
    return status;
  }

  manageAttendingStatus(bool status, int eventId) async {
    if (status == true) {
      await remote.leaveEvent(eventId);
      setState(() {
        isAttending = false;
      });
    } else {
      await remote.attendEvent(eventId);
      setState(() {
        isAttending = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Business Wallet"),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(widget.event.name,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade500)),
                    Text(
                        "Organizer: ${organizerInfo.name} ${organizerInfo.surname}"),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(widget.event.description,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Start: ${widget.event.start.hour}:${widget.event.start.minute} - ${widget.event.start.day} ${months[widget.event.start.month]} ${weekDays[widget.event.start.weekday]}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                        "Finish: ${widget.event.finish.hour}:${widget.event.finish.minute} - ${widget.event.finish.day} ${months[widget.event.finish.month]} ${weekDays[widget.event.finish.weekday]}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary:
                              isAttending ? Colors.red.shade300 : Colors.blue,
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () {
                        manageAttendingStatus(isAttending, widget.event.id);
                      },
                      child: Text(
                        isAttending == true ? 'Katılmaktan Vazgeç' : "Katıl",
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text("Tanıdığın Katılımcılar",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade500)),
                    SizedBox(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: commonAttendeesInfo.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: ValueKey(widget.event.attendees?[index]),
                            closeOnScroll: true,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                tileColor: Colors.white,
                                leading: const Icon(Icons.account_circle,
                                    color: Colors.black87),
                                //same over here
                                title: Text(
                                  "${commonAttendeesInfo[index].name} ${commonAttendeesInfo[index].surname} ${(commonAttendeesInfo[index].position != null) ? commonAttendeesInfo[index].position : ""} ",
                                  style: const TextStyle(
                                      color: Colors.black87, fontSize: 20),
                                ),

                                trailing: IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.black87),
                                  onPressed: () {
                                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactsDetailsPage(
                              name: contactList[index].name)),
                    );
                    */
                                  },
                                ),
                              ),
                            ),
                            // endActionPane: ActionPane(
                            //   extentRatio: 0.2,
                            //   motion: const ScrollMotion(),
                            //   children: [
                            //     SlidableAction(
                            //       key: ValueKey(widget.event.attendees?[index]),
                            //       autoClose: true,
                            //       onPressed: (context) {
                            //         removeContact(index);
                            //       },
                            //       backgroundColor: Colors.red,
                            //       foregroundColor: Colors.white,
                            //       icon: Icons.delete,
                            //     ),
                            //   ],
                            // ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getListBox() {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.event.attendees?.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(widget.event.attendees?[index]),
            closeOnScroll: true,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                tileColor: Colors.black87,
                leading: const Icon(Icons.contacts, color: Colors.white),
                //same over here
                title: Text(
                  "${widget.event.attendees?[index]}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),

                trailing: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactsDetailsPage(
                              name: contactList[index].name)),
                    );
                    */
                  },
                ),
              ),
            ),
            // endActionPane: ActionPane(
            //   extentRatio: 0.2,
            //   motion: const ScrollMotion(),
            //   children: [
            //     SlidableAction(
            //       key: ValueKey(widget.event.attendees?[index]),
            //       autoClose: true,
            //       onPressed: (context) {
            //         removeContact(index);
            //       },
            //       backgroundColor: Colors.red,
            //       foregroundColor: Colors.white,
            //       icon: Icons.delete,
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
