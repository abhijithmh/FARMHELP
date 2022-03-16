import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FARMHELP/screens/Infoscreen.dart';
import 'package:FARMHELP/main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  String Heading = 'FARM HELP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("t9w6x6jx9s").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  int picindex = index + 1;
                  int altitude =
                      snapshot.data!.docs.elementAt(index).get("altitude");
                  int ripecount =
                      snapshot.data!.docs.elementAt(index).get("ripe_count");
                  int unripecount =
                      snapshot.data!.docs.elementAt(index).get("unripe_count");
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return infoscreen(name: '$picindex',);
                      }));
                    },
                    title: Text("image_$picindex"),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          }),
    );
  }
}
