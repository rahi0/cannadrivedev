import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canna_drive_main/Model/DirectionModel/DirectionJson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickLocation extends StatefulWidget {
  var data;
  PickLocation(this.data);
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  double latitude;
  double longitude;
  double pickLatitude;
  double pickLongitude;
  var distance;
  var duration;
  var path;
  String pickAddress;

 
 
  bool _getData = true;
  BitmapDescriptor texiIcon;
  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var allSeller;

  var latitudeJson;
  var longitudeJson;

  var locationLatitude;
  var locationLongitude;

  void initState() {

 
     _initialPosition = CameraPosition(target: LatLng(widget.data.seller.lat, widget.data.seller.lng), zoom : 14);
     BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(80, 80)), 'assets/images/taxi.png')
        .then((onValue) {
      texiIcon = onValue;
    });
   // _changeWithTime();
    //_myLocation();
    _showpickLocation();
    _locationMovement();
   // _draw();

    super.initState();
  }

   void _locationMovement() async {
    GoogleMapController controller = await _controller.future;
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      locationLatitude = currentLocation.latitude;
      locationLongitude = currentLocation.longitude;

      Marker marker = _markers.firstWhere(
          (p) => p.markerId == MarkerId('LocationPick'),
          orElse: () => null);
      if (!mounted) return;
      setState(() {
        _markers.remove(marker);
      });
      _markers.add(
        Marker(
            icon: texiIcon,
            markerId: MarkerId('LocationPick'),
            position: LatLng(locationLatitude, locationLongitude),
            // infoWindow: InfoWindow(
            //     title: locationLatitude.toString(),
            //     snippet: locationLongitude.toString())
                ),
      );

     
      //  _getSocket(socketLatitude,socketLongitude);
      _draw(locationLatitude, locationLongitude);
    });
  }

  // void _changeWithTime() {
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     _myMovement();
  //   });
  // }

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

    location.onLocationChanged().listen((LocationData currentLocation) {
      // controller.animateCamera(
      //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 15)); //22

            Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('pickLocationId'),
        orElse: () => null);
    setState(() {
      _markers.remove(marker);
    });
    //  setState(() {      
        _markers.add(
          Marker(
            icon: texiIcon,
            markerId: MarkerId('pickLocationId'),
            position: LatLng(latitude, longitude),
          ),
        );
      });
   // });
  }

  void _showpickLocation() async {
    pickLatitude = widget.data.seller.lat;
    pickLongitude = widget.data.seller.lng;

    setState(() {
      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          markerId: MarkerId("pick"),
          position: LatLng(pickLatitude, pickLongitude),
          onTap: () {
           // _distanceList();
            duration == null ? pleaseDialog() : dialog();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
          Navigator.of(context).pop();
        },
       
      );
    },
  ), 
        title: Text(
          'Pick Location',
          style: TextStyle(
          color:Color(0xFF01d56a),
           // fontSize: 21.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
       // centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // _getData
            //     ? Center(child: CircularProgressIndicator())
            //     :
             GoogleMap(
                    markers: _markers,
                    polylines: _polylines,
                    mapType: MapType.normal,
                    // myLocationEnabled: true,
                    // myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _initialPosition,
                  ),
          ],
        ),
      ),
    );
  }

//   void _myLocation() async {
//     GoogleMapController controller = await _controller.future;

//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     latitudeJson = localStorage.getString('Latitude');
//     longitudeJson = localStorage.getString('Longitude');

//     latitude = double.parse(latitudeJson); //latitudeJson;
//     longitude = double.parse(longitudeJson);

// latitude = 24.897503;
// longitude = 91.8710354;

//     controller.animateCamera(
//         CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 14)); //17
//   }

  void _distanceList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    latitudeJson = localStorage.getString('Latitude');
    longitudeJson = localStorage.getString('Longitude');

    latitude = double.parse(latitudeJson); //latitudeJson;
    longitude = double.parse(longitudeJson);

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latitude,$longitude&destination=$pickLatitude,$pickLongitude&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    var status = data.status;

    for (var d in data.routes) {
      path = d.overview_polyline.points;
    }

    for (var d in data.routes) {
      for (var dd in d.legs) {
        distance = dd.distance.text;
        duration = dd.duration.text;
      }
    }
  }

  void dialog() async {
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
                  height: 110,
                  decoration: new BoxDecoration(
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
            height: MediaQuery.of(context).size.height / 3,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 0),
            child: Column(
              children: <Widget>[
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Shop Name: ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.seller.name == null
                                  ? ""
                                  : widget.data.seller.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Shop Address : ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.seller.address == null
                                  ? ""
                                  : widget.data.seller.address,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Duration: ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: duration == null ? "" : duration,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 12),
                distance == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Distance: ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: distance == null ? "" : distance,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        height: 30,
                        // width: 90,
                        margin: EdgeInsets.only(top: 20, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Close",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void pleaseDialog() {
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
                  height: 110,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/images/neterror.png'),
                      ))),
            ],
          ),
          content: Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
            child: Column(
              children: <Widget>[
                Text(
                  "Network error...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        height: 30,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Try Again",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = new List<LatLng>();

    int index = 0;
    int len;

    len = encoded.length;

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

  Future<void> _draw( double lat, double lng) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // latitudeJson = localStorage.getString('Latitude');
    // longitudeJson = localStorage.getString('Longitude');

    //latitude = double.parse(latitudeJson); //latitudeJson;
  //  longitude = double.parse(longitudeJson);

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$lng&destination=$pickLatitude,$pickLongitude&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    // var status = data.status;

    // if (status == 'OK') {
    for (var d in data.routes) {
      path = d.overview_polyline.points;
    }

    // } else {
    //   path = "";
    // }

    for (var d in data.routes) {
      for (var dd in d.legs) {
        distance = dd.distance.text;
        duration = dd.duration.text;
      }
    }

    var drawPoints = decodePolyline(path);
 if (!mounted) return;
    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
          visible: true,
          color: Colors.red,
          polylineId: PolylineId("polyLineId"),
          points: drawPoints));

     // _getData = false;
    });
  }
}
