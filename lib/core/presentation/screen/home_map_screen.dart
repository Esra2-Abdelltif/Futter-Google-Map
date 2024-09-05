import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/infrastructure/utils/Services/location_services.dart';
import 'package:flutter_map/infrastructure/utils/functions/location_fun.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialCameraPosition =CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(29.955404, 32.476655),
      tilt: 59.440717697143555,
      zoom: 16);
  LatLng currentLocation = _initialCameraPosition.target;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: ( googleMapController) {
              _controller.complete(googleMapController);
            },
            onCameraMove: (CameraPosition newsPos ) {
              setState(() {
                currentLocation = newsPos.target;
              });
            },

          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => LocationFun.getMyLocation(_controller),
            child: const Icon(Icons.gps_fixed),
          ),
        ],
      ),


      //to print Location
      bottomNavigationBar: Container(
        height: 20,
        alignment: Alignment.center,
        child: Text(
            "lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}"),
      ),
    );
  }

}
