import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/core/presentation/constants/app_image.dart';
import 'package:flutter_map/infrastructure/env/environment_variables.dart';
import 'package:flutter_map/infrastructure/utils/Services/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//Search For Addresses
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

//
class LocationFun {

//getMyLocation
  static Future<void> getMyLocation(Completer<GoogleMapController> _controller) async {
    LocationData myLocation = await LocationService().getLocation();
    animateCamera(
        LatLng(myLocation.latitude!, myLocation.longitude!), _controller);
  }
  static Future<void> animateCamera(LatLng location, Completer<GoogleMapController> _controller) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
      target: location,
      zoom: 19.00,
    );
    print(
        "animating camera to (lat: ${location.latitude}, long: ${location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

//Search For Addresses
  static Future<void> showSearchDialog(BuildContext context, Completer<GoogleMapController> _controller) async {
    var p = await PlacesAutocomplete.show(
        context: context,
        apiKey: EnvironmentVariables.setGoogleMapApiKeyValue(),
        mode: Mode.fullscreen,
        language: "ar",
        region: "ar",
        offset: 0,
        hint: "Type here...",
        radius: 1000,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, "ar")]);
    getLocationFromPlaceId(p!.placeId!, _controller);
  }
  static Future<void> getLocationFromPlaceId(String placeId, Completer<GoogleMapController> _controller) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: EnvironmentVariables.setGoogleMapApiKeyValue(),
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(placeId);

    animateCamera(
      LatLng(detail.result.geometry!.location.lat,
          detail.result.geometry!.location.lng),
      _controller,
    );
  }

  //setMarker
  static void setMarker(LatLng location, LatLng currentLocation, Set<Marker> markers) {
    Marker newMarker = Marker(
      markerId: MarkerId(location.toString()),
      icon: BitmapDescriptor.defaultMarker,
      // icon: _locationIcon,
      position: location,
      infoWindow: InfoWindow(
          title: "Title",
          snippet: "${currentLocation.latitude}, ${currentLocation.longitude}"),
    );
    markers.add(newMarker);
  }
  static Future<void> buildMarkerFromAssets(BitmapDescriptor? locationIcon) async {
    locationIcon ??= await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        AppImagePaths.locationIconImage);
  }
}
