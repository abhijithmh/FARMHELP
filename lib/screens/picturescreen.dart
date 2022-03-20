import 'package:FARMHELP/storageservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class picturescreen extends StatelessWidget {
  final String Picture;
  picturescreen({Key? key, required this.Picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(),
      body : FutureBuilder(

        future: storage.downloadURL(Picture),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(snapshot.connectionState== ConnectionState.done){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                    height: 250,
                  child: Image.network(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
            return CircularProgressIndicator();
          }
          return Container();
          }),
    );
  }

}


