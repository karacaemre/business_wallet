import 'package:business_wallet/screens/contacts.dart';
import 'package:business_wallet/screens/profile.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../screens/event.dart';
import '../screens/qr.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case event:
        return MaterialPageRoute(builder: (_) => const Event());
      case qr:
        final qrData = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => QR(qrData: qrData));
      case profile:
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => Profile(currentUser: user));
      case contacts:
        return MaterialPageRoute(builder: (_) => const Contacts());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Something is wrong!'),
            ),
          ),
        );
    }
  }
}

const String event = '/event';
const String qr = '/qr';
const String profile = '/profile';
const String contacts = '/contacts';
