import 'package:FARMHELP/screens/Mapscreen.dart';

import 'package:FARMHELP/screens/picturescreen.dart';
import 'package:FARMHELP/storageservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:FARMHELP/colors.dart';

class infoscreen extends StatelessWidget {
  final int name;
  final String geohash;
  final String picture;
  final LatLng lat;

  infoscreen(
      {Key? key,
      required this.name,
      required this.geohash,
      required this.picture,
      required this.lat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text("Image $name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection(geohash).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final int count = name - 1;
                    double altitude =
                        snapshot.data!.docs.elementAt(count).get("altitude");
                    int ripecount =
                        snapshot.data!.docs.elementAt(count).get("ripe_count");
                    int unripecount = snapshot.data!.docs
                        .elementAt(count)
                        .get("unripe_count");
                    String picture =
                        snapshot.data!.docs.elementAt(count).get("name");

                    return ListBody(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Altitude = $altitude"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Ripe Count = $ripecount"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Unripe Count = $unripecount"),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return MapScreen(
                                  lat: lat,
                                );
                              }));
                            },
                            icon: Icon(Icons.location_on),
                            label: Text('location'),
                        style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(appbarColor)))
                      ],
                    );
                  }
                }),
            FutureBuilder(
                future: storage.downloadURL(picture),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        height: 250,
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
