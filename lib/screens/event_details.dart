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
  User contactInfo = User("", "", "");
  List<String> attendees = [];
  bool isAttending = true;
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
    "Friday"
  ];

  @override
  void initState() {
    super.initState();

    getContactInfo(widget.event.organizer).then((value) => setState(() {
          contactInfo = value.data;
        }));
  }

  getContactInfo(int number) async {
    return await remote.getContact(number);
  }

  List<String> getAttendeeNames(List<int> contactNumbers) {
    List<String> nameList = [];
    List<User> users = [];
    contactNumbers.map(
      (e) => users.add(getContactInfo(e)),
    );
    return nameList;
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
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(40),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(widget.event.name,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade500)),
                    Text(
                        "Organizer: ${contactInfo.name} ${contactInfo.surname}"),
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
                        "Start Time: ${widget.event.start.hour}:${widget.event.start.minute}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                        "Start Date: ${widget.event.start.day} ${months[widget.event.start.month]} ${weekDays[widget.event.start.weekday]}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                        "End Time: ${widget.event.finish.hour}:${widget.event.finish.minute}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                        "End Date: ${widget.event.finish.day} ${months[widget.event.finish.month]} ${weekDays[widget.event.finish.weekday]}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 35,
                    ),
                    // TODO henüz fonksiyonlar eklenmedi
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () {},
                      child: Text(
                        isAttending == true ? 'Vazgeç' : "Katıl",
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text("Katılımcılar",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade500)),
                    //           ...getAttendeeNames(widget.event.attendees).map(
                    // (Event e) => ListTile(
                    //   tileColor: Colors.black87,
                    //   leading: const Icon(Icons.event, color: Colors.white),
                    //   //same over here
                    //   title: Text(
                    //     e.description,
                    //     style: const TextStyle(color: Colors.white, fontSize: 20),
                    //   ),

                    //   trailing: IconButton(
                    //     icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => EventDetails(event: e)));
                    //     },
                    //   ),
                    // ),
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
