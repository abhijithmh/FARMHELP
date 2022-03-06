import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FARMHELP/screens/homescreeen.dart';
import 'package:FARMHELP/screens/info.dart';
import 'package:FARMHELP/screens/login.dart';
import 'package:FARMHELP/screens/splash.dart';

const SAVEKEY = 'userLoggedIN';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
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
    screenhome(),
    HomeScreen(),
    
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
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentSelection,
        onTap: (newIdex) {
          setState(() {
            currentSelection = newIdex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'menu'),
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