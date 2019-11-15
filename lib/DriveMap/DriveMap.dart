



import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canna_drive_main/Model/DirectionModel/DirectionJson.dart';
import 'package:canna_drive_main/Widgets/OrderAlert/OrderAlert.dart';
import 'package:canna_drive_main/Screen/ReportPage/ReportPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';



 // bool isAccepted = false;

class DriveMap extends StatefulWidget {
  @override
  _DriveMapState createState() => _DriveMapState();
}

class _DriveMapState extends State<DriveMap> {



  var _updatedOption = [
    'Choose Any One',
    'Accept order',
    'Driver En Route',
    'Driver picked up order',
    'Driver is outside',
    'Driver has dropped off order'
  ];
  var _currentupdatedOption = 'Choose Any One';
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  double latitude;
  double longitude;
  double searchLat = 0;
  double searchLong = 0;
  double distanceInMeters = 0;
  double distanceInKm = 0;
  var distance;
  var duration;
  var addresses;
  var first;
  String myAddress;
  String newAddress;
  var path;
  var searchAddress;
  String searchAddr;

  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void initState() {
     bottomNavIndex = 1;
       store.dispatch(ConnectionCheck(true));
    //_myMovement();
    _myLocation();
    //_distanceList
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: TextField(
                    controller: serchController,
                    decoration: InputDecoration(
                        hintText: 'Enter Address',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.deepOrangeAccent,
                            onPressed: _searchLocation,
                            iconSize: 30.0)),
                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.notifications,
                    //     size: 40,
                    //     color: Colors.deepOrangeAccent,
                    //   ),
                    //   onPressed: _showDialog,

                    // ),
                     

                  
                      IconButton(
                      icon: Icon(
                        
                        Icons.location_searching,
                        size: 40,
                        color: Colors.red,
                      ),
                      onPressed:_myLocation,

                    ),

                      IconButton(
                      icon: Icon(
                        Icons.local_taxi,
                        size: 40,
                        color: Colors.redAccent[700],
                      ),
                      onPressed:_draw,

                    ),
                   
                  
                  ],
                ),
               // RaisedButton(_draw();
                    //  child: Text(
                     //   "My Movement",
                      //  style: TextStyle(color: Colors.white),
                     // ),
                     // color: Colors.deepOrangeAccent,
                     // onPressed: _myMovement,
                   // ),

                                                              ////////  update///////////
                                
                           
              ],
            ),
          ),

          //  Column(
          //    mainAxisAlignment: MainAxisAlignment.end,
           
          //    children: <Widget>[
          //      Center(
          //        child: Container(
          //                       decoration: BoxDecoration(
          //                         color: Colors.green,
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(20.0)),
          //                       ),
                              
          //                       height: 45,
          //                       margin: EdgeInsets.only(top: 25, bottom: 15),
          //                       child: OutlineButton(
          //                         padding: EdgeInsets.only(left: 40, right: 40),
          //                           color: Colors.green,
          //                           child: new Text("Report an Issue", style: TextStyle(color: Colors.white),),
          //                           onPressed: () {

                                      
          //                             Navigator.push(
          //                                 context,
          //                                 new MaterialPageRoute(
          //                                     builder: (context) => ReportPage()));
          //                           },
          //                           borderSide:
          //                               BorderSide(color: Colors.green, width: 0.5),
          //                           shape: new RoundedRectangleBorder(
          //                               borderRadius:
          //                                   new BorderRadius.circular(20.0)))),
          //      ),
          //    ],
          //  )
        ],
      ),
    );
  }

  // void _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //      return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //         contentPadding: EdgeInsets.all(5),
  //         title: Container(
  //             height: 30.00,
  //             width: 350.00,
  //             decoration: BoxDecoration(
  //                 border: Border(
  //                     bottom: BorderSide(
  //                         width: 3, color: Colors.grey.withOpacity(0.2)))),
  //             child: Row(children: [
  //               Text(
  //                 "Distance ",
  //                 style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.w500),
  //                 textAlign: TextAlign.center,
  //               ),
  //               Container(
  //                   alignment: Alignment.centerRight,
  //                   margin: EdgeInsets.only(bottom: 4),
  //                   width: 100,
  //                   height: 10,
  //                   child: Text(
  //                     '4 km',
  //                     style:
  //                         TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
  //                   )),
  //             ])),
  //         content: Container(
  //           margin: EdgeInsets.only(top: 5, right: 5, left: 20),
  //           height: 40,
  //           width: 300.00,
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             Container(
  //                 child: Text('Total distance to you of your package',
  //                     style: TextStyle(color: Colors.black87, fontSize: 11))),
  //             Container(
  //               alignment: Alignment.centerLeft,
  //               child: Text('4 km from your location',
  //                   textAlign: TextAlign.left,
  //                   style: TextStyle(color: Colors.black87, fontSize: 11)),
  //             )
  //           ]),
  //         ),
  //         actions: <Widget>[
  //           Container(
  //               height: 70,
  //               width: 250,
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Container(
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius:
  //                               BorderRadius.all(Radius.circular(20.0)),
  //                         ),
  //                         width: 110,
  //                         height: 45,
  //                         margin: EdgeInsets.only(
  //                           top: 25,
  //                           bottom: 15,
  //                         ),
  //                         child: OutlineButton(
  //                           child: new Text(
  //                             "Decline",
  //                             style: TextStyle(color: Colors.black),
  //                           ),
  //                           color: Colors.white,
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           borderSide:
  //                               BorderSide(color: Colors.black, width: 0.5),
  //                           shape: new RoundedRectangleBorder(
  //                               borderRadius: new BorderRadius.circular(20.0)),
  //                         )),
  //                     Container(
  //                         decoration: BoxDecoration(
  //                           color: Colors.green,
  //                           borderRadius:
  //                               BorderRadius.all(Radius.circular(20.0)),
  //                         ),
  //                         width: 110,
  //                         height: 45,
  //                         margin: EdgeInsets.only(top: 25, bottom: 15),
  //                         child: OutlineButton(
  //                             color: Colors.green,
  //                             child: new Text("Accept", style: TextStyle(color: Colors.white),),
  //                             onPressed: () {
                               

                               
  //                                Navigator.of(context).pop();
  //                               // Navigator.push(
  //                               //     context,
  //                               //     new MaterialPageRoute(
  //                               //         builder: (context) => MapPage()));
  //                             },
  //                             borderSide:
  //                                 BorderSide(color: Colors.green, width: 0.5),
  //                             shape: new RoundedRectangleBorder(
  //                                 borderRadius:
  //                                     new BorderRadius.circular(20.0))))
  //                   ]))
  //         ],
  //       );
  //     },
  //   );
  // }

  void _myLocation() async {
     GoogleMapController controller = await _controller.future;
    // LocationData currentLocation;
    // var location = Location();
    // try {
    //   currentLocation = await location.getLocation();
    // } on Exception {
    //   currentLocation = null;
    // }

    // latitude = currentLocation.latitude;
    // longitude = currentLocation.longitude;

    latitude = 24.9112939;
    longitude = 91.8499754;
   
    // var coordinates = new Coordinates(latitude, longitude);
    // addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // first = addresses.first;

    controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 17)); //19
    setState(() {
    //  myAddress = first.addressLine;
      //_markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('locationId'),
          position: LatLng(latitude, longitude),
         // infoWindow: InfoWindow(title: "$myAddress"),
        ),
      );
    });
  }

  void _myMovement() async {
    GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = Location();

    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;

    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   latitude = latitude + 0.1;
    //   longitude = longitude + 0.1;
    // });

    var coordinates = new Coordinates(latitude, longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    newAddress = first.addressLine;

    location.onLocationChanged().listen((LocationData currentLocation) {
      controller.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 17)); //22
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId('MovementId'),
            position: LatLng(latitude, longitude),
            infoWindow:
                InfoWindow(title: latitude.toString() + " , " + newAddress),
          ),
        );
      });
    });
  }

    Future<void> _searchLocation() async {


    if(serchController.text.isEmpty){
       return _showMsg("Enter Address");
    }
    else{
    try {
      addresses = await Geocoder.local.findAddressesFromQuery(searchAddr);
       //print(addresses);
     } on Exception {
      addresses = null;
    }
    if(addresses.length<1){
     // print("object");
    return _showMsg("Address is not found");
    }
    else if(addresses== null){
      return _showMsg("Address is not found");
    }
    else{
        first = addresses.first;
    }
    }
    // try {
    //   first = addresses.first;
    // } on Exception {
    //   first = null;
    //   return _showMsg("Address is not found");
    // }

    searchLat = first.coordinates.latitude;
    searchLong = first.coordinates.longitude;

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(searchLat, searchLong),
        zoom: 17.0,
      ),
    ));
    setState(() {
      _markers.clear();
      _polylines.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('searchId'),
          position: LatLng(searchLat, searchLong),
          infoWindow: InfoWindow(
            title: '$searchAddr',
          ),
        ),
      );
    });

    serchController.text = "";
  }

  // Future<void> searchLocation() async {
  //   try {
  //     addresses = await Geocoder.local.findAddressesFromQuery(searchAddr);
  //   } on Exception {
  //     addresses = null;
  //   }
  //   //  try {

  //   //   else {
  //   //   return _showMsg("Address is not found");
  //   // }

  //   if (addresses==null) {
  //     return _showMsg("Address is not found");
  //   }
  //   else{
  //     first = addresses.first;
  //   }

  //     // } on Exception {
  //     //   first = null;
  //     // }

  //     searchLat = first.coordinates.latitude;
  //     searchLong = first.coordinates.longitude;

  //   //   var coordinates = new Coordinates(latitude, longitude);
  //   // addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   // first = addresses.first;
  //    //searchAddress = first.addressLine;


  //     distanceInMeters = await Geolocator()
  //         .distanceBetween(latitude, longitude, searchLat, searchLong);
  //     distanceInKm = (distanceInMeters / 1000).roundToDouble();
  //     GoogleMapController controller = await _controller.future;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(searchLat, searchLong),
  //         zoom: 17,//19.0,
  //       ),
  //     ));
  //     setState(() {
  //       _markers.clear();
  //       _polylines.clear();
  //       _markers.add(
  //         Marker(
  //             markerId: MarkerId('searchId'),
  //             position: LatLng(searchLat, searchLong),
  //             infoWindow: InfoWindow(title: '$searchAddr'),
  //             // onTap: () {
  //             //   dialog();
  //             // }
  //             ),
  //       );
  //     });

  //    // _draw();

  //   //  serchController.text = "";
    
  // }
  

  Future _distanceList() async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latitude,$longitude&destination=$searchLat,$searchLong&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    var status = data.status;

    if (status == 'OK') {
      for (var d in data.routes) {
        path = d.overview_polyline.points;
      }
    } else {
      path = "";
    }

    for (var d in data.routes) {
      for (var dd in d.legs) {
        distance = dd.distance.text;
        duration = dd.duration.text;
      }
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = new List<LatLng>();

    int index = 0, len = encoded.length;
    if (len == 0) {
      points = [];
    }

    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng(lat / 1E5, lng / 1E5);
      points.add(p);
    }
    return points;
  }

  Future<void> _draw() async {
    _distanceList();

    LocationData currentPolylineLocation;
    var location = Location();
    try {
      currentPolylineLocation = await location.getLocation();
    } on Exception {
      currentPolylineLocation = null;
    }

    distanceInMeters = await Geolocator()
        .distanceBetween(latitude, longitude, searchLat, searchLong);
    distanceInKm = (distanceInMeters / 1000).roundToDouble();

    var drawPoints = decodePolyline(path);

    // <LatLng>[
    //        LatLng(latitude,longitude),
    //        LatLng(searchLat, searchLong),
    //     ];

    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
          visible: true,
          color: Colors.red,
          polylineId: PolylineId("polyLineId"),
          points: drawPoints));
    });
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Column(
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 5, color: Colors.blue[100]),
                        top: BorderSide(width: 5, color: Colors.blue[100]),
                        left: BorderSide(width: 5, color: Colors.blue[100]),
                        right: BorderSide(width: 5, color: Colors.blue[100]),
                      ),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/images/nen.jpg'),
                      ))),
            ],
          ),
          content: Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 180,
            margin: EdgeInsets.only(right: 15),
            child: Column(
              children: <Widget>[
                Text(
                  "Shop Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Text(
                  "Distance: "+ distance,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Text(
                  "Duration: " + duration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          actions: <Widget>[],
        );
        //return SearchAlert(duration);
      },
    );
  }

   void _updatedOptionDropDownSelected(String newValueSelected) {
    setState(() {
      this._currentupdatedOption = newValueSelected;
    });
  }
}
