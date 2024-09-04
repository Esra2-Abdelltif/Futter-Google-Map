import 'package:flutter/material.dart';
import 'package:flutter_map/core/presentation/constants/app_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapScreen extends StatelessWidget {
  const HomeMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Google Map'),
      ),
      body: Stack(
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(37.43296265331129, -122.08832357078792),
                tilt: 59.440717697143555,
                zoom: 19.151926040649414),
          ),
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   child: Image.asset(AppImagePaths.hotelImage),
          // ),
          Positioned(
            bottom: 50,
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.16,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemBuilder:(context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                       height: MediaQuery.of(context).size.height*0.16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              image:const AssetImage(AppImagePaths.hotelImage),
                               width: MediaQuery.of(context).size.width-(8),
                                height: MediaQuery.of(context).size.height*0.35,
                              fit: BoxFit.fill),


                        ],
                      ),
                    ),
                  );
                } ,
                itemCount: 5,


              ),
            ),
          ),



        ],
      ),
    );
  }
}
