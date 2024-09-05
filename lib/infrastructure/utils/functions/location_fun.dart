import 'dart:async';

import 'package:flutter_map/infrastructure/utils/Services/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationFun{
//getMyLocation
 static Future<void> getMyLocation(Completer<GoogleMapController> _controller) async {
    LocationData myLocation = await LocationService().getLocation();
    animateCamera(LatLng(myLocation.latitude!, myLocation.longitude!),_controller);
  }
 static Future<void> animateCamera(LatLng location, Completer<GoogleMapController> _controller ) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
      target: location,
      zoom: 19.00,
    );
    print("animating camera to (lat: ${location.latitude}, long: ${location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}