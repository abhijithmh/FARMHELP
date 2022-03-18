import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class infoscreen extends StatelessWidget {
  final int name;
  final String geohash;

  infoscreen({
    Key? key,
    required this.name,required this.geohash
  }) : super(key: key);

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
                  itemBuilder: (context, count) {
                    final int count = name - 1;
                    int altitude =
                        snapshot.data!.docs.elementAt(count).get("altitude");
                    int ripecount =
                        snapshot.data!.docs.elementAt(count).get("ripe_count");
                    int unripecount = snapshot.data!.docs
                        .elementAt(count)
                        .get("unripe_count");
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
                        )
                      ],
                    );
                  },
                  separatorBuilder: (ctx, count) {
                    return const Divider();
                  },
                  itemCount: 1,
                );
              }
            }),
        appBar: AppBar(
          title: Text("$name"),
        ));
  }
}
