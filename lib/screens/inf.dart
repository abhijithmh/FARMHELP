import 'package:flutter/material.dart';
import 'package:FARMHELP/main.dart';

class infoscreen extends StatelessWidget {
  final String name;
  infoscreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(child: FloatingActionButton(onPressed: () {
        Navigator.of(context).pop(MaterialPageRoute(builder: (ctx) {
          return mainscreen();
        }));
      })),
    );
  }
}
