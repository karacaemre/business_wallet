import 'package:business_wallet/screens/contacts.dart';
import 'package:business_wallet/screens/profile.dart';
import 'package:flutter/material.dart';
import '../screens/event.dart';
import '../screens/qr.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case event:
        return MaterialPageRoute(builder: (_) => const Event());
      case qr:
        final qrData = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => QR(qrData:qrData));
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());
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
