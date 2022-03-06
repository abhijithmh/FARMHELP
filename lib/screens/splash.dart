import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FARMHELP/main.dart';
import 'package:FARMHELP/screens/info.dart';
import 'package:FARMHELP/screens/login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    checKUserLogin(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

          child: Image.asset(
              'assets/images/logo.jpeg'),
    ));
  }
}

Future<void> gotoLogin(BuildContext context) async {
  await Future.delayed(Duration(seconds: 5));
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return Loginscreen();
  }));
}
Future<void>checKUserLogin(BuildContext context) async{
  final sharedprefs = await SharedPreferences.getInstance();
  final userLoggedIN = sharedprefs.getBool(SAVEKEY);
  if(userLoggedIN ==null || userLoggedIN ==false ){
    gotoLogin(context);
  }
  else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return mainscreen();
    }));
  }
}
