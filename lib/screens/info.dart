import 'package:flutter/material.dart';
import 'package:FARMHELP/screens/inf.dart';
import 'package:FARMHELP/main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  String Heading = 'FARM HELP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.separated(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text('title $index'),
            subtitle: Text('subtitle'),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://5.imimg.com/data5/AB/SP/CS/GLADMIN-93147224/capture1-500x500.PNG'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return infoscreen(name: 'title $index');
              }));
            },
          );
        },
        separatorBuilder: (ctx, index) {
          return const Divider(
            color: Colors.black,
            thickness: 1,
          );
        },
        itemCount: 50,
      )),
    );
  }
}
