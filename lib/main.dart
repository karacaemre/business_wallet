import 'package:flutter/material.dart';
import 'model/user.dart';
import 'screens/loginScreen.dart';
import 'controller/router.dart';
import 'screens/event.dart';
import 'screens/qr.dart';
import 'screens/contacts.dart';
import 'screens/profile.dart';

void main() async {
  runApp(const BusinessWallet());
}

class BusinessWallet extends StatefulWidget {
  const BusinessWallet({Key? key}) : super(key: key);

  @override
  State<BusinessWallet> createState() => _BusinessWalletState();
}

class _BusinessWalletState extends State<BusinessWallet> {
  bool loggedIn() {
    //TODO Implement me!
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Wallet',
      onGenerateRoute: PageRouter.generateRoute,
      home: loggedIn() ? const Base() : LoginScreen(),
    );
  }
}

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int selectedTab = 0;

  // TODO
  late User currentUser;

  setIndex(int i) {
    setState(() {
      selectedTab = i;
    });
  }

  getSelectedTab() {
    var screens = [
      const Event(),
      const Contacts(),
      const Center(
        child: Text("find"),
      ),
      Profile(currentUser: currentUser,),
    ];

    return screens[selectedTab];
  }

  @override
  void initState() {
    super.initState();
    currentUser = User("Ahmet", "Şenharputlu", "1099981240124");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {
          Navigator.pushNamed(context, "/qr",
              arguments: currentUser.toJson().toString());
        },
      ),
      body: getSelectedTab(),
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        //shape of notch
        notchMargin: 5,
        //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                setIndex(0);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setIndex(1);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Colors.black,
              ),
              onPressed: () {
                setIndex(2);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Colors.black,
              ),
              onPressed: () {
                setIndex(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
