import 'package:business_wallet/screens/auth.dart';
import 'package:business_wallet/screens/event.dart';
import 'package:flutter/material.dart';
import 'controller/auth.dart';
import 'controller/router.dart';
import 'screens/contacts.dart';
import 'screens/profile.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Auth()),
  ], child: const BusinessWallet()));
}

class BusinessWallet extends StatefulWidget {
  const BusinessWallet({Key? key}) : super(key: key);

  @override
  State<BusinessWallet> createState() => _BusinessWalletState();
}

class _BusinessWalletState extends State<BusinessWallet>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<Auth>().checkLocal();

        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Wallet',
      onGenerateRoute: PageRouter.generateRoute,
      home: context.watch<Auth>().loggedIn ? const Base() : const AuthScreen(),
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

  setIndex(int i) {
    setState(() {
      selectedTab = i;
    });
  }

  getSelectedTab() {
    var screens = [
      const EventPage(),
      const Contacts(),
      const Center(
        child: Text("find"),
      ),
      const Profile()
    ];

    return screens[selectedTab];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: const Text("Business Wallet"),
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset("assets/images/logo.png"),
          )),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: () {
            Navigator.pushNamed(context, "/qr");
          }),
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
                Icons.qr_code_scanner_sharp,
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
                Icons.qr_code_scanner_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                setIndex(2);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
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
