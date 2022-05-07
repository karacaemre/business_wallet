import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth.dart';
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
    text = widget.currentUser.toJsonString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Text(text),
      ),
      ElevatedButton(
        onPressed: () {
            context.read<Auth>().logout();
        },
        child: const Text("logout"),
      ),
    ]);
  }
}
