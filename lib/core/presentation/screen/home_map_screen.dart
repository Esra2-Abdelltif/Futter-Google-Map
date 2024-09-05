import 'package:flutter/material.dart';
import 'package:flutter_map/core/presentation/constants/app_image.dart';
import 'package:flutter_map/infrastructure/utils/functions/share_fun.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  Set<Marker> myMarkers = <Marker>{};
 late BitmapDescriptor customMarker; //attribute

  getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, AppImagePaths.hotelImage);
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
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
            initialCameraPosition: const CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(29.955404, 32.476655),
                tilt: 59.440717697143555,
                zoom: 19.151926040649414),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                myMarkers.add( Marker(
                  markerId:const MarkerId('1'),
                  position:const LatLng(29.955404, 32.476655),
                  icon: customMarker,
                   onTap: (){
                     shareAddressLink(subject: "Home Address",lat:"29.955404",lng:"32.476655");
                },
                  infoWindow: InfoWindow(
                    title: 'Home',
                    snippet: 'ElSafa , Suez',
                    onTap: (){
                    print("Marker tabed");
                    }
                  ),


                )
                );
              });
            },
            markers: myMarkers,
          ),
        ],
      ),
    );
  }
}
