import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage ({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;


  late Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap= 0 ;
  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition,zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }
  Set<Marker> markers ={};

  Future<Position> _determinePosition() async{
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable){
      return Future.error("location service is disable");}
    permission = await Geolocator.checkPermission();

    if(permission== LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission==LocationPermission.denied){
        return Future.error("Location premission denied");
      }
    }
    if (permission==LocationPermission.deniedForever){
      return Future.error("Location permission are");
    }
    Position position= await Geolocator.getCurrentPosition();
    return position;
  }



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///Google Map
          GoogleMap(
            // liteModeEnabled: true,
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated:( GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 320.0;
              });

              locatePosition();
            },
          ),
          Positioned(
            top: 12,
            right: 12,
              child:InkWell(
                onTap: () async {
                  Position position = await _determinePosition();
                  newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 14)));
                  markers.clear();
                  // markers.add(MarkerId: const MarkerId("Currentlocation"),position:LatLng(position.longitude, position.latitude));
                setState(() {

                });
                  },
                child: Icon(Icons.location_on_rounded
          ),
              )),
          Positioned(

              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                // color: Colors.blueAccent,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    boxShadow:[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 16,
                          spreadRadius: 0.5,
                          offset: Offset(0.7,0.7)
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12,),
                      Text("Hi there,",style: TextStyle(fontSize: 12),),
                      Text("Where to go?,",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow:[
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 16,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7,0.7)
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.black54,),
                              SizedBox(width: 10,),
                              Text("Search Drop Off")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:24,),
                      Row(
                        children: [
                          Icon(Icons.home,color: Colors.grey,),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 "ADD HOME"
                              ),
                              SizedBox(height: 4.0,),
                              Text("Your living address",style: TextStyle(color: Colors.grey[600],fontSize: 12.0),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height:10,),
                      SizedBox(height:16,),
                      Row(
                        children: [
                          Icon(Icons.work,color: Colors.grey,),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Home"),
                              SizedBox(height: 4.0,),
                              Text("Your office address",style: TextStyle(color: Colors.grey[600],fontSize: 12.0),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
