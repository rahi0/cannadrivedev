import 'dart:async';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:canna_drive_main/Screen/ChangePassword/ChangePassword.dart';
import 'package:canna_drive_main/Screen/VerifyEmail/VerifyEmail.dart';
import 'package:canna_drive_main/Screen/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:canna_drive_main/Screen/ProfilePage/ProfilePage.dart';
import 'package:canna_drive_main/Screen/GraphPage/GraphPage.dart';
import 'package:canna_drive_main/DriveMap/DriveMap.dart';
import 'package:canna_drive_main/Screen/OrderPage/orderPage.dart';
import 'package:canna_drive_main/Screen/notificationPage/notificationPage.dart';
import 'package:canna_drive_main/Screen/reviewPage/reviewPage.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Model/NewOrderModel/NewOrderModel.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:canna_drive_main/Model/TotalNotificationModel/TotalNotificationModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:toast/toast.dart';

int bottomNavIndex = 0;

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _isLoading = true;
  var latitude;
  var longitude;
  var newOrderData;
  var totalNotifi;
  var number;
  var orderData;
  var driverId;

   double socketLatitude;
  double socketLongitude;
   SocketIOManager manager;

  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  @override
  void initState() {
    super.initState();

 manager = SocketIOManager();

 _getUserInfo();

      _sendSocketData();

///////// add firebase notification/////

    _firebaseMessaging.getToken().then((token) async {
     print("Notification firebase token");
     print(token);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.setString('firebaseToken',token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        
       // Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
      },
      onLaunch: (Map<String, dynamic> message) async {
        pageLaunch(message);
       
      },
      onResume: (Map<String, dynamic> message) async {
        pageDirect(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

///////// end firebase notification/////




/////_showNotification();
    _showNewOrderNumber();
    _deviceLocation();
  }


  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver = json.decode(driverJson);


    if(driver!=null){
       driverId = driver['id'];
    }
   
  }

  @override
  void dispose() {
   disconnect(driverId.toString());
    super.dispose();
  }

  void _sendSocketData() async {
   // GoogleMapController controller = await _controller.future;
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      socketLatitude = currentLocation.latitude;
      socketLongitude = currentLocation.longitude;
      _getSocket(driverId.toString(),socketLatitude, socketLongitude);

    });
  }

disconnect(String order) async {

     print("disconnect");
    await manager.clearInstance(sockets[order]);
     if (!mounted) return;
    setState(() => _isProbablyConnected[order] = false);

  }

  
  void _getSocket(String order,double lat, double lng) async {

     setState(() => _isProbablyConnected[order.toString()] = true);


    SocketIO socket = await SocketIOManager().createInstance(SocketOptions(
        //Socket IO server URI
        'https://www.dynamyk.biz/',
        nameSpace: '/driver',
        //Query params - can be used for authentication
        query: {
          'orderId': '$driverId',
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport
        ));
    socket.onConnect((data) {
      print("connected...");
    
      socket.emit("driver_location_$driverId", [
        {"lat": lat, "lng": lng}
      ]);
     
    });
   
    socket.connect();


     sockets[driverId.toString()] = socket;
  }




  void pageDirect(Map<String, dynamic> msg) {
    print("onResume: $msg");
    setState(() {
      index = 1;
    });
    Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
  }

  void pageLaunch(Map<String, dynamic> msg) {
    print("onLaunch: $msg");

  
    pageRedirect();
    //print("onLaunch: $msg");
  }

  void pageRedirect() {
    //print(index);

    if (index != 1 && index != 2) {
     
      Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
      setState(() {
        index = 2;
      });
    }
  }

  void _showNewOrderNumber() {
   //  Timer.periodic(Duration(seconds: 2), (timer) {
   // _showNotificationNumber();
   // _showOrderNumber();
    internetCheck();
   //  });
  }

  void internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else {
      if (store.state.connection == false) {
      } else {
        _showInternetConnnection();
      }
    }
  }

  void _showOrderNumber() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var res = await CallApi().getData('app/getNewOrder');
    var collection = json.decode(res.body);
    var order = NewOrderModel.fromJson(collection);
    if (!mounted) return;
    setState(() {
      orderData = order.orders.length;
    });

    if (orderData > store.state.notificationCount) {
      number = orderData - store.state.notificationCount;
     // _showOrderAlert();

      store.dispatch(NotificationCountAction(orderData));
    }
  }
 void _showNotificationNumber() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var res = await CallApi().getData('app/getUnseenNoti');
    var collection = json.decode(res.body);
    var totalOrder = TotalNotificationModel.fromJson(collection);
    if (!mounted) return;
    if (totalOrder.notification == null) {
      setState(() {
        totalNotifi = 0;
      });
    } else {
      setState(() {
        totalNotifi = totalOrder.notification.count;
      });
    }
    // setState(() {
    //    totalNotifi = totalOrder.notification.count;
    // });

    if (totalNotifi > store.state.notificationCount) {
      // number = totalNotifi - store.state.notificationCount;
      _showNotification();

      // setState(() {
      store.dispatch(NotificationCountAction(
          totalNotifi)); //store.state.notificationCount==newOrderData.length;
    }

// setState(() {
//       _isLoading = false;
//     });
    //print(totalNotifi);
  }

  void _deviceLocation() async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    var currentLatitude = currentLocation.latitude;
    var currentLongitude = currentLocation.longitude;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('Latitude', '$currentLatitude');
    localStorage.setString('Longitude', '$currentLongitude');
  }

  final List<Widget> children = [
    GraphPage(),
  // DriveMap(),
    OrderPage(),
    ReviewPage(),
    ProfilePage(),
  ];
  int _currentIndex = bottomNavIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(primaryColor: Color(0xFF00aa54).withOpacity(0.8),),
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
              ),
              title: Text("Home"),
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.map),
            //   title: Text(
            //     "Map", 
            //   ),
            // ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: Text(
                "Order",
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.rate_review),
              title: Text(
                "Review",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(bottomNavIndex) {
    setState(() {
      _currentIndex = bottomNavIndex;
    });
  }

  void _showOrderAlert() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            
             number == 1
                ? "You have " + '$number' + " new order"
                : "You have " + '$number' + " new orders",
           
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(
                          top: 25,
                          bottom: 15,
                        ),
                        child: OutlineButton(
                          child: new Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              bottomNavIndex = 2;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Navigation()));
                              // _updateNotification();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
    
  }


   void _showNotification() {
    // Timer.periodic(Duration(seconds: 20), (timer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
           

            totalNotifi == 1
                ? "You have " + '$totalNotifi' + " new notification"
                : "You have " + '$totalNotifi' + " new notifications",
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(
                          top: 25,
                          bottom: 15,
                        ),
                        child: OutlineButton(
                          child: new Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //         context,
                              //         new MaterialPageRoute(
                              //             builder: (context) =>
                              //                 NotificationPage()));
                              _updateNotification();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
    // });
  }

  void _updateNotification() async {
    var data = {};

    var res = await CallApi().postData(data, 'app/updateNoti');
    var body = json.decode(res.body);

    // print(body);
    if (body['success'] == true) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => NotificationPage()));
    }
  }

  void _showInternetConnnection() {
    store.dispatch(ConnectionCheck(false));
   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "No Internet Connection",
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Retry",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
   
  }
}
