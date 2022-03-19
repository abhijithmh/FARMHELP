import 'package:FARMHELP/storageservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class picturescreen extends StatelessWidget {
  picturescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      body : FutureBuilder(

        future: storage.downloadURL('image_1.jpg'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(snapshot.connectionState== ConnectionState.done){
            return Container(
              width: 300,
                height: 250,
              child: Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
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

