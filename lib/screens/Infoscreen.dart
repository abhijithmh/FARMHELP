import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:FARMHELP/main.dart';

class infoscreen extends StatelessWidget {
  final String name;
  infoscreen({Key? key, required this.name}) : super(key: key);

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
                    int picindex = index+1;
                    int altitude =
                        snapshot.data!.docs.elementAt(index).get("altitude");
                    int ripecount =
                        snapshot.data!.docs.elementAt(index).get("ripe_count");
                    int unripecount =
                    snapshot.data!.docs.elementAt(index).get("unripe_count");
                    return ListBody(

                      children: [
                        Text("Altitude = $altitude"),
                        Text("Ripe Count = $ripecount"),
                        Text("Unripe Count = $unripecount")
                      ],
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              }
            }),
        appBar: AppBar(
          title: Text(name),
        ));
  }
}
