import 'package:flutter/material.dart';
import 'package:flutter_map/infrastructure/utils/functions/share_fun.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  Set<Marker> myMarkers = <Marker>{};

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords =[] ;
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));

    Set<Polygon> polygonSet = {};
    polygonSet.add(Polygon(
        polygonId: const PolygonId('test'),
        points: polygonCoords,
        strokeWidth: 2,
        fillColor:Colors.transparent,
        strokeColor: Colors.red));
    return polygonSet;
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
                target: LatLng(37.43296265331129, -122.08832357078792),
                tilt: 59.440717697143555,
                zoom:16),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                myMarkers.add( Marker(
                  markerId:const MarkerId('1'),
                  position:const LatLng(29.955404, 32.476655),
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
            polygons: myPolygon(),
          ),
        ],
      ),
    );
  }
}
