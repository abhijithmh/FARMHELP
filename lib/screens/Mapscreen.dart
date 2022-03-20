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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                compassEnabled: true,
                initialCameraPosition:
                    CameraPosition(target: widget.lat, zoom: 25)),
          ),
          Center(child: ElevatedButton(onPressed: () {}, child: Text('add'))),
        ]),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      gMapController = controller;
    });
  }
}
