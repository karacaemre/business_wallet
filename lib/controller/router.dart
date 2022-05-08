import 'package:business_wallet/screens/contacts.dart';
import 'package:business_wallet/screens/profile.dart';
import 'package:business_wallet/screens/auth.dart';
import 'package:flutter/material.dart';
import '../screens/event.dart';
import '../screens/qr.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case event:
        return MaterialPageRoute(builder: (_) => const EventPage());
      case qr:
        return MaterialPageRoute(builder: (_) => const QR());
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());
      case contacts:
        return MaterialPageRoute(builder: (_) => const Contacts());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
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
const String auth = '/auth';
