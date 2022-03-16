import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FARMHELP/main.dart';
import 'package:FARMHELP/screens/Imagescreen.dart';
import 'package:FARMHELP/screens/splash.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({Key? key}) : super(key: key);
  final usernamecontroller = TextEditingController();
  final passswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernamecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'USERNAME'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passswordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'PASSWORD'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                checklogin(context);
              },
              icon: Icon(Icons.check),
              label: Text('Login'),
            )
          ],
        ),
      ),
    ));
  }

  void checklogin(BuildContext ctx) async {
    final username = usernamecontroller.text;
    final password = passswordcontroller.text;
    if (username == 'user' && password== 'password' ) {
      final sharedprefs= await SharedPreferences.getInstance();
      await sharedprefs.setBool(SAVEKEY, true);
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return mainscreen();
      }));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20.0),
          content: Text('Username and Password doesnot match')));
    }
  }
}
