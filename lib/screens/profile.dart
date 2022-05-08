import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Center(
        child: Text("this is profile page"),
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
