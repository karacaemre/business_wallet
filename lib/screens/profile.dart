import 'package:flutter/material.dart';

import '../model/user.dart';

class Profile extends StatefulWidget {
  final User currentUser;

  const Profile({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.currentUser.toJson().toString();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(text),
    );
  }
}
