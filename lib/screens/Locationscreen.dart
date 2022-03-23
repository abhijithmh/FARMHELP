import 'package:FARMHELP/colors.dart';
import 'package:FARMHELP/screens/Imagescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FARMHELP/screens/Infoscreen.dart';
import 'package:FARMHELP/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locationscreen extends StatelessWidget {
  Locationscreen({Key? key}) : super(key: key);
  String Heading = 'FARM HELP';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("geohash").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  int picindex = index + 1;
                  String location =
                  snapshot.data!.docs.elementAt(index).get("geohash");


                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ImageScreen(geohash: location);
                      }));
                    },
                    title: Center(child: Text("Location $picindex")),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          }),
    );
  }
}