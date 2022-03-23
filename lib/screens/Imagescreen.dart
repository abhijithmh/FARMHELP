import 'package:FARMHELP/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FARMHELP/screens/Infoscreen.dart';
import 'package:FARMHELP/screens/picturescreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../storageservice.dart';

class ImageScreen extends StatelessWidget {
  final String geohash;
  ImageScreen({Key? key, required this.geohash}) : super(key: key);
  String Heading = 'FARM HELP';

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(geohash).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  int picindex = index + 1;
                  String picture =
                      snapshot.data!.docs.elementAt(index).get("name");
                  LatLng Lat = LatLng(snapshot.data!.docs.elementAt(index).get('location').latitude,
                      snapshot.data!.docs.elementAt(index).get("location").longitude);
                  return FutureBuilder(
                      future: storage.downloadURL(picture),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          String? piclink = snapshot.data;
                          return ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return infoscreen(
                                    name: picindex,
                                    geohash: geohash,
                                    picture: picture,lat: Lat);
                              }));
                            },
                            title: Text("Image $picindex"),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(piclink!),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container();
                      });
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
