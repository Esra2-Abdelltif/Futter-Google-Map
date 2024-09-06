import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/infrastructure/utils/functions/location_fun.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  BitmapDescriptor? _locationIcon;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  @override
  void initState() {
    setState(() {
      LocationFun.buildMarkerFromAssets(_locationIcon);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        actions: [
          IconButton(onPressed: ()=>LocationFun.showSearchDialog(context,_controller), icon: const Icon(Icons.search))
        ],
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
            markers: markers,
            polylines: polyLines,

          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () { setState(() {
              LocationFun.drawPolyline(
                  const LatLng(38.52900208591146, -98.54919254779816),
                  currentLocation,polyLines,markers);
            });
            },
            child: const Icon(Icons.settings_ethernet_rounded),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                LocationFun.setMarker(currentLocation,markers);
              });
            },
            child: const Icon(Icons.location_on),
          ),
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
