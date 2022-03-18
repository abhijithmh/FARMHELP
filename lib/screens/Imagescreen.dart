
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FARMHELP/screens/Infoscreen.dart';
import 'package:FARMHELP/main.dart';

class ImageScreen extends StatelessWidget {
  final String geohash;
  ImageScreen({Key? key, required this.geohash}) : super(key: key);
  String Heading = 'FARM HELP';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection(geohash).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  int picindex = index + 1;

                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return infoscreen(name: picindex, geohash: geohash,);
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
