import 'package:FARMHELP/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FARMHELP/main.dart';

class loginScreen extends StatelessWidget {
  loginScreen({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
        ),
        body: Stack(
          children: [
            //Container(
              //child: Image.asset(
                //"assets/images/blackpapper.jpg",
                //width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height ,
              //),
            //),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'USERNAME'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'PASSWORD'),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      checkLogin(context);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Login'),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void checkLogin(BuildContext ctx) async {
    final username = usernameController.text;
    final password = passwordController.text;
    if (username == 'user' && password == 'password') {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool(SAVEKEY, true);
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return mainscreen();
      }));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20.0),
          content: Text('Username and Password doesnot match')));
    }
  }
}
