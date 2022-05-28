import 'package:business_wallet/http/remote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../controller/auth.dart';
import '../model/user.dart';
import '../http/remote.dart';
import '../model/event.dart';
import 'contacts.dart';
import 'event_details.dart';

class ContactDetails extends StatefulWidget {
  int id;

  ContactDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  User? user;
  List<Event>? events;
  Remote remote = Remote();

  @override
  void initState() {
    super.initState();

    getContactInfo(widget.id).then((value) => setState(() {
          user = value.data;
        }));
    getEventsTogether(widget.id).then((value) => setState(() {
          events = value.data;
        }));
  }

  getContactInfo(int id) async {
    return await remote.getContact(id);
  }

  getEventsTogether(int id) async {
    return await remote.eventTogether(id);
  }

  addContact(String name) {
    // Contact c = Contact(name);
    //
    // for (Contact ctg in contactList) {
    //   if (ctg.name == name) {
    //     return false;
    //   }
    // }

    // TODO add remote

    // contactList.add(c);
    return true;
  }

  deleteContact(int index) {
    // Storage().deleteContact(contactList[index]);
    // Remote().deleteContact(contactList[index]);
    //
    // setState(() {
    //   contactList = List.from(contactList).removeAt(index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(
                user!.name + " " + user!.surname,
                // user?.name ?? ""user?.surname ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 1.15,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user?.position ?? "",
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Divider(
                thickness: 1.15,
                indent: MediaQuery.of(context).size.width * 0.1,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: 20,
                  ),
                  const Text(
                    'OVERVIEW',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.fromLTRB(20, 3, 1, 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        CupertinoIcons.phone,
                        color: Colors.blue.shade400,
                        size: 18,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'PHONE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.15,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                user!.phone,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            CupertinoIcons.mail,
                            color: Colors.blue.shade400,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'EMAIL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    user?.email ?? "",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1.0,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Icon(FontAwesomeIcons.linkedinIn,
                              color: Colors.blue.shade400, size: 16.0)),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'LINKEDIN',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  user?.linkedin ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1.0,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Divider(
                thickness: 1.15,
                indent: MediaQuery.of(context).size.width * 0.1,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                color: Colors.grey.shade400,
              ),
              const Text(
                'Events You Have Attended Together',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: events?.length, //events.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: ValueKey(events?[index]),
                          closeOnScroll: true,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: const Icon(Icons.event,
                                  color: Colors.black87),
                              //same over here
                              title: Text(
                                "${events?[index].name}",
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),

                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios,
                                    color: Colors.black87),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                              event: events![index])));
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.shader = LinearGradient(
            //  colors: [Color(0xff8160c7), Color(0xff8f77dc), Color(0xff8f67bc)],
            colors: [
          Colors.blue.shade500,
          Colors.blue.shade300,
          Colors.blue.shade100
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        .createShader(
      Rect.fromLTRB(
        size.width * 0.15,
        size.height * 0.15,
        size.width,
        size.height * 0.15,
      ),
    );
    var path = Path();
    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.48, size.height * 0.38, size.width, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.38, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
