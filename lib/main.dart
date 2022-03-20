import 'package:FARMHELP/screens/Locationscreen.dart';
import 'package:FARMHELP/screens/Mapscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FARMHELP/screens/homescreeen.dart';
import 'package:FARMHELP/screens/login.dart';
import 'package:FARMHELP/screens/splash.dart';

const SAVEKEY = 'userLoggedIN';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          appId: "1:607068044575:android:bd897ea0830da69aae042a",
          projectId: "farmhelptest2",
          authDomain: 'farmhelptest2.firebaseapp.com',
          messagingSenderId: "607068044575",
          storageBucket: "farmhelptest2.appspot.com",
          apiKey: "AIzaSyAB64iSStZV9u8M-jl0ovLaSx9-EUXnF74"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          )),
      home: splashscreen(),
    );
  }
}

class mainscreen extends StatefulWidget {
  mainscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int currentSelection = 0;
  final pages = [
    Homescreen(),
    Locationscreen(),

  ];
  String Heading = 'FARM HELP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            child: Text(
              Heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: Icon(Icons.exit_to_app_rounded,
                semanticLabel: 'Sign Out',
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.white),
        currentIndex: currentSelection,
        onTap: (newIdex) {
          setState(() {
            currentSelection = newIdex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections), label: 'location'),

        ],
      ),
      body: pages[currentSelection],
    );
  }

  signout(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => Loginscreen()), (route) => false);
  }
}
