import 'package:canna_drive_main/API/api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canna_drive_main/Model/DirectionModel/DirectionJson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class DropLocation extends StatefulWidget {
  var data;

  DropLocation(this.data);
  @override
  _DropLocationState createState() => _DropLocationState();
}

class _DropLocationState extends State<DropLocation> {
  double latitude;
  double longitude;
  double dropLatitude;
  double dropLongitude;
  var distance;
  var duration;
  var addresses;
  var first;
  var path;
  String dropAddress;
  String newAddress;
  BitmapDescriptor texiIcon;
  bool _getData = false;
  LatLng socketLocation;

  double socketLatitude;
  double socketLongitude;

   SocketIOManager manager;

  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition;
  // = CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var allSeller;

  var latitudeJson;
  var longitudeJson;
  var driverId;
  var orderId;
  var userData;
  var driverData;
  var status;

  void initState() {
    _initialPosition = CameraPosition(
        target: LatLng(widget.data.buyer.delLat, widget.data.buyer.delLong),
        zoom: 14);

    orderId = widget.data.id;
    status = widget.data.status;


     manager = SocketIOManager();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(80, 80)), 'assets/images/taxi.png')
        .then((onValue) {
      texiIcon = onValue;
    });
    print("id");
    print(widget.data.status);

    // print(widget.driverData['id']);
    // driverId = '${widget.driverData['id']}';
    _getUserInfo();
    _sendSocketData();
    _showDropLocation();
    //  _draw();

    //  _changeWithTime();
    //  _myLocation();

    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.data.status == 'Order is on the way' ||widget.data.status=='driver map visible' ?disconnect(orderId.toString()):null;


  // //  widget.data.status == 'Order is on the way' || widget.data.status=='driver map visible'? _backtoPrevStatus():print("");
  //   super.dispose();
  // }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver = json.decode(driverJson);

    driverId = driver['id'];
  }

  void _sendSocketData() async {
    GoogleMapController controller = await _controller.future;
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      socketLatitude = currentLocation.latitude;
      socketLongitude = currentLocation.longitude;

      Marker marker = _markers.firstWhere(
          (p) => p.markerId == MarkerId('LocationId'),
          orElse: () => null);
      if (!mounted) return;
      setState(() {
        _markers.remove(marker);
      });
    
      _markers.add(
        Marker(
            icon: texiIcon,
           
            markerId: MarkerId('LocationId'),
            position: LatLng(socketLatitude, socketLongitude),
            // infoWindow: InfoWindow(
            //     title: socketLatitude.toString(),
            //     snippet: socketLongitude.toString())
                ),
      );

      // widget.data.status == 'Order is on the way' ||
      //         widget.data.status == 'driver map visible'
      //     ? _getSocket(orderId.toString(),socketLatitude, socketLongitude)
      //     : null;
      //  _getSocket(socketLatitude,socketLongitude);
      _draw(socketLatitude, socketLongitude);
    });
  }

  void _getSocket(String order,double lat, double lng) async {

     setState(() => _isProbablyConnected[order.toString()] = true);


    SocketIO socket = await SocketIOManager().createInstance(SocketOptions(
        //Socket IO server URI
        'https://dynamyk.co/',
        nameSpace: '/driver',
        //Query params - can be used for authentication
        query: {
          'orderId': '$orderId',
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport
        ));
    socket.onConnect((data) {
      print("connected...");
     // print(data);
    //  socket.emit("message", ["Hello world!"]);
      socket.emit("driver_location_$orderId", [
        {"lat": lat, "lng": lng}
      ]);
      //print("connected end...");
    });
    // socket.on("news", (data) {
    //   //sample event
    //   print("news");
    //   print(data);
    // });
    socket.connect();

    _changeToShowMapStatus();

     sockets[orderId.toString()] = socket;
  }

  disconnect(String order) async {

     print("disconnect");
    await manager.clearInstance(sockets[order]);
     if (!mounted) return;
    setState(() => _isProbablyConnected[order] = false);

  }

  void _changeToShowMapStatus() async {
    var data = {
      'id': '${widget.data.id}',
      'status': 'driver map visible',
     
    };

    print("notun status");
    print(data);

    var res = await CallApi().postData(data, 'app/drivrOrderMapStatus');
    var body = json.decode(res.body);

  }

  void _backtoPrevStatus() async {
    var data = {
      'id': '${widget.data.id}',
      'status': 'Order is on the way',
      // 'lat': socketLatitude,
      // 'lng': socketLongitude,
      // 'driverId': '$driverId'
    };

    print("ager status");
    print(data);

    var res = await CallApi().postData(data, 'app/drivrOrderMapStatus');
    var body = json.decode(res.body);

    print(body);
  }

  void _changeWithTime() {
    if (!mounted) return;
    //Timer.periodic(Duration(seconds: 1), (timer) {
    _myMovement();
    // });
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

    /////  get drop location////

    dropLatitude = widget.data.buyer.delLat;
    dropLongitude = widget.data.buyer.delLong;

//       LatLng driverLocation = LatLng(latitude, longitude);
//     LatLng dropLocation = LatLng(dropLatitude,  dropLongitude);

//     LatLngBounds bound = LatLngBounds(southwest: driverLocation, northeast: dropLocation);
//     print("location");
// print(driverLocation);
// print("dropLocation");
// print(dropLocation);
// print("Bound");
// print(bound);

    location.onLocationChanged().listen((LocationData currentLocation) {

      //    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 70);
      //  controller.animateCamera(u2).then((void v){
      //    check(u2,controller);
      //  });

      // controller.animateCamera(
      //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 15)); //22

      //         Marker marker = _markers.firstWhere(
      //     (p) => p.markerId == MarkerId('dropLocationId'),
      //     orElse: () => null);
      //     if (!mounted) return;
      // setState(() {
      //   _markers.remove(marker);
      // });
      //     _markers.add(
      //       Marker(
      //          icon: texiIcon,
      //         markerId: MarkerId('dropLocationId'),
      //         position: LatLng(latitude, longitude),
      //       ),
      //     );
    });
  }

  void _showDropLocation() async {
    dropLatitude = widget.data.buyer.delLat;
    dropLongitude = widget.data.buyer.delLong;
    if (!mounted) return;
    setState(() {
      _markers.add(
        Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          markerId: MarkerId("drop"),
          position: LatLng(dropLatitude, dropLongitude),
          onTap: () {
         //  _distanceList();
            //  _draw();

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
          'Drop Location',
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

  // void _myLocation() async {
  // GoogleMapController controller = await _controller.future;

  // SharedPreferences localStorage = await SharedPreferences.getInstance();

  // latitudeJson = localStorage.getString('Latitude');
  // longitudeJson = localStorage.getString('Longitude');

  // latitude = double.parse(latitudeJson); //latitudeJson;
  // longitude = double.parse(longitudeJson);

// latitude = 24.897503;
// longitude = 91.8710354;

  // controller.animateCamera(
  //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 14)); //17

  //}

  void _distanceList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    latitudeJson = localStorage.getString('Latitude');
    longitudeJson = localStorage.getString('Longitude');

    latitude = double.parse(latitudeJson); //latitudeJson;
    longitude = double.parse(longitudeJson);

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latitude,$longitude&destination=$dropLatitude,$dropLongitude&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    var status = data.status;

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
                              text: 'Buyer Name: ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.buyer.name == null
                                  ? ""
                                  : widget.data.buyer.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Delivery Address : ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.buyer.delAddress == null
                                  ? ""
                                  : widget.data.buyer.delAddress,
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
                        // width: 120,
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
        //return SearchAlert(duration);
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

  Future<void> _draw(double lat, double lng) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // latitudeJson = localStorage.getString('Latitude');
    // longitudeJson = localStorage.getString('Longitude');

    // latitude = double.parse(latitudeJson); //latitudeJson;
    // longitude = double.parse(longitudeJson);

    print("draw location");
    print(latitude);
    print(longitude);

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$lng&destination=$dropLatitude,$dropLongitude&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

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

      _getData = false;
    });
  }
}
