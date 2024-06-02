import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796, -122.085),
      zoom: 2

  );

  // Use a flag to track whether the map is initialized
  bool isMapInitialized = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          Positioned(
            top: 20.0,
            left: 20.0,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page
                Navigator.pop(context);
              },
              child: Text('Go Back', style: TextStyle(
                color: Colors.pink, fontSize: 25,
              ),),
            ),
          );

        },
      ),


    );
  }
}