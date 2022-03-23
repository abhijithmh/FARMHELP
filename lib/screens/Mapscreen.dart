import 'package:FARMHELP/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng lat;
  const MapScreen({Key? key, required this.lat}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController gMapController;
  List<Marker> allMarkers = [];
  @override
  void initState() {
    super.initState();

    allMarkers.add(Marker(
      markerId: MarkerId('location'),
      draggable: false,
      position: widget.lat,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
      ),
      body: Stack(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
              compassEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: widget.lat, zoom: 9)),
        ),
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 120.0, right: 15.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white30),
                      ),
                      onPressed: () {
                        gMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(zoom: 30, target: widget.lat)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                        child: Icon(
                          Icons.gps_fixed_sharp,
                          color: Colors.black,
                          size: 30,
                          semanticLabel: 'Re-Center',
                        ),
                      )),
                ),
              ],
              verticalDirection: VerticalDirection.up,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ]),
    );
  }

  void mapCreated(controller) {
    setState(() {
      gMapController = controller;
    });
  }
}
