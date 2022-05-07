import 'package:business_wallet/http/remote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          //child: Text("this is event screen\n ${Remote().token}"),
          child: Text("this is event screen\n dlkşsnf"),
        ),
        Text("${context.read<Auth>().loggedIn}")
      ],
    );
  }
}
