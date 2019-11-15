import 'dart:async';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:canna_drive_main/Screen/notificationPage/notificationPage.dart';
import 'package:canna_drive_main/Screen/Statistics/Statistics.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Model/TotalNotificationModel/TotalNotificationModel.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/Model/DriverOrderModel/DriverOrderModel.dart';
import 'package:canna_drive_main/Model/NewOrderModel/NewOrderModel.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/Screen/SubmitDriverDetails/SubmitDriverDetails.dart';
import 'package:canna_drive_main/Screen/DriverSubmitPage/driverSubmitPage.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  String pushOnlineString = '';
  bool _value1 = false;
  bool _value2 = false;
  bool _isLoading = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);
  bool isSwitched = true;
  var orderDetails;
  var processingOrder = 0;
  var pendingOrder = 0;
  var orderData;
  var completedOrder = 0;
  var balance = 0;

  var totalNotifi;

  Container dataContainer(String label, String data) {
    return Container(
      child: Container(
          margin: EdgeInsets.only(bottom: 7),
             decoration: BoxDecoration(
         // color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
          color:Colors.white,
         // color: Colors.red,
                     
                      
                          boxShadow:[
                         BoxShadow(color:Colors.grey[300],
                         blurRadius: 17,
                          //offset: Offset(0.0,3.0)
                          )
                       
                       ], 
                   
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2-15,
        //color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      label,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          
                          fontFamily: "sourcesanspro",
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF00bb5d),
                    fontFamily: "DINPro",
                    fontSize: 22 ,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    bottomNavIndex = 0;
    store.dispatch(ConnectionCheck(true));

    _showAllTimerMethod();

    // _showOrderRequest();
    _getUserInfo();
 
    super.initState();
  }

  var userData;
  var driverData;
  bool _driverIsEmpty = false;

  void _showAllTimerMethod() {
    //if (!mounted) return;
    Timer.periodic(Duration(seconds: 5), (timer) {
      _showNotificationNumber();
  });
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver;
    if (driverJson != null) {
      driver = json.decode(driverJson);
    } else {
      driver = null;
    }

    setState(() {
      userData = user;
    });

    if (driver == null) {
      _driverIsEmpty = true;
    } else {
      setState(() {
        driverData = driver;
        _driverIsEmpty = false;
      });
    
     //store.state.orderList.length>0 ? null : _showOrderRequest();
      store.state.isHome == true? null: _showOrderRequest();

       _numberOrder();
         orderData = 0;
    }
  }

  void _showpendingOrderNumber() async {
    var res = await CallApi().getData('app/getNewOrder');
    var collection = json.decode(res.body);
    var order = NewOrderModel.fromJson(collection);

    if (order.orders == null) {
      setState(() {
        orderData = 0;
      });
    } else {
      if (!mounted) return;
      setState(() {
        orderData = order.orders.length;
      });

      store.dispatch(NewOrderList(orderData));
    }
  }

  Future <void> _showOrderRequest() async {
    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().getData('app/ordersDriver');
    var collection = json.decode(res.body);
    var allOrderRequest = DriverOrderModel.fromJson(collection);
    // print(allOrderRequest);

    if (!mounted) return;
    setState(() {
      orderDetails = allOrderRequest.order;
      _isLoading = false;
    });
      store.dispatch(OrderList(orderDetails));
      store.dispatch(ClickHome(true));
    // print(orderDetails);

       _showpendingOrderNumber();

  }

  void _numberOrder(){

  processingOrder = 0;
 pendingOrder = 0;
 
  completedOrder = 0;
 balance = 0;


    if (store.state.orderList != null || store.state.orderList.length>0) {

      print(store.state.orderList);
    
      for (var d in store.state.orderList) {

        print(d.status);
        if (d.status == 'Completed') {    
          completedOrder = completedOrder + 1;
             print(completedOrder.toString());
          balance = balance + d.seller.deliveryFee;
        } else if (d.status != 'Completed' &&
            d.status != 'Request for Driver') {
               
          processingOrder = processingOrder + 1;


          print(processingOrder.toString());
        }
        
      }
    }

  }
  void _showNotificationNumber() async {
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

     if(totalOrder.notification.count>store.state.notificationCount){

          store.dispatch(NotificationCheck(true));

          print("HomePage soman na");
      }
     
     store.dispatch(NotificationCountAction(totalOrder.notification.count)); 
  }
  void _updateNotification() async {


    
    //  if(totalNotifi>store.state.notificationCount){

          var data = {};

    var res = await CallApi().postData(data, 'app/updateNoti');
    var body = json.decode(res.body);

    print(body);
    print("update hpmepage body");
   // setState(() {
      _showNotificationNumber();
       
    //  }
   
   // });
  
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => NotificationPage()));
  
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              backgroundColor: Color(0xFFFFFFFF),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                 // elevation: 0,
                  //centerTitle: false,
                
           //
              title: Text("CannaDrive",
        style: TextStyle(
          color:Color(0xFF01d56a),
          fontWeight: FontWeight.bold,
          fontSize: 25),),
                  actions: <Widget>[
                   _driverIsEmpty?Container(): Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Stack(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  _updateNotification();
                                },
                                icon: Icon(Icons.notifications, 
                                size: 30, color: Color(0xFF343434),),
                              ),
                              totalNotifi == 0 || totalNotifi == null
                                  ? Container()
                                 : 
                                  Positioned(
                                     right: 7,
                                      top: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // height: 21,
                                        // width: 21,
                                        decoration: BoxDecoration(
                                        color: Color(0xFFd20000),
                                            borderRadius:
                                                BorderRadius.circular(15)
                                                ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(totalNotifi == 0
                                              ? "":totalNotifi>9?"9+":
                                               '$totalNotifi',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                        ),
                                        //count
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                body: SafeArea(
                  child:_driverIsEmpty?

                    Center(
                child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Please add your driver details",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: "grapheinpro-black",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.topLeft,
                        stops: [0.1, 0.4, 0.6, 0.9],
                        colors: [
                          Colors.greenAccent[400],
                          Colors.greenAccent[400],
                          Colors.tealAccent[400],
                          Colors.tealAccent[700],
                        ],
                      ),
                    ),
                    height: 35,
                    margin: EdgeInsets.only(top: 25, bottom: 15),
                    child: OutlineButton(
                        color: Colors.greenAccent[400],
                        child: new Text(
                          "Add Car Details",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              SlideLeftRoute(page: SubmitDriverDetails()));
                        },
                        borderSide: BorderSide(color: Colors.green, width: 0.5),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0))))
              ],
            )):_isLoading? Center(child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ))
                    :
         RefreshIndicator(
           onRefresh: _showOrderRequest,
           child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
             child: Container(
                 padding: EdgeInsets.only(
                     top: 10, left: 10, right: 10, bottom: 15),

                 // width: 500,
                 child: Column(children: [
                   Container(
                     padding: EdgeInsets.only(top: 30),
                     alignment: Alignment.center,
                     child: Row(
                       mainAxisAlignment:
                           MainAxisAlignment.center,
                       children: [
                         Container(
                           //height: 30,
                           child: Text(
                             'Net Balance',
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 21,
                                 fontFamily: 'FontSpring',
                                 fontWeight: FontWeight.normal),
                           ),
                         ),
                        
                       ],
                     ),
                   ),
                   Container(
                     margin:
                         EdgeInsets.only(bottom: 10, top: 10),
                     alignment: Alignment.center,
                     child: Row(
                       mainAxisAlignment:
                           MainAxisAlignment.center,
                       children: [
                         Text('\$ ',
                             style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                  color: Color(0xFF00bb5d),)),
                         Text('${(balance).toStringAsFixed(2)}',
                             style: TextStyle(
                                 fontSize: 25,
                                 fontWeight: FontWeight.w500,
                                  color: Color(0xFF00bb5d),)
                                  )
                       ],
                     ),
                   ),

                   ///////overview start//////

                   Container(
                     width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                     padding: EdgeInsets.only(
                        
                        
                         top: 20,
                         bottom: 10),
                     child: Column(
                       crossAxisAlignment:
                           CrossAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                           child: Text(
                             "Orders Overview",
                             textAlign: TextAlign.left,
                             style: TextStyle(
                                 color: Colors.black,
                                 fontFamily: "DINPro",
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                        // Divider(color: Colors.grey),
                         Container(
                            // color: Colors.yellow,
                           child: Row(
                             mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               dataContainer('Processing Orders',
                                   processingOrder.toString()),
                               dataContainer(
                                   'Pending Orders',
                                   orderData == null || store.state.newOrderCount==null
                                       ? "0"
                                       : store.state.newOrderCount.toString())
                             ],
                           ),
                         ),
                         Container(
                           // color: Colors.blue,
                           child: Row(
                             mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               dataContainer('Completed Orders',
                                   completedOrder.toString()),
                               dataContainer(
                                   'Total Orders',
                                   orderData == null
                                       ? '${processingOrder + completedOrder}'
                                       : '${processingOrder + completedOrder + store.state.newOrderCount}')
                             ],
                           ),
                         ),
                         Container(
                             margin: EdgeInsets.all(20),
                             decoration: BoxDecoration(
                              // color: Colors.blue,
                               borderRadius: BorderRadius.all(
                                   Radius.circular(20.0)),
                               gradient: LinearGradient(
                                 begin: Alignment.centerRight,
                                 end: Alignment.topLeft,
                                 stops: [0.1, 0.4, 0.6, 0.9],
                                 colors: [
                                   Colors.greenAccent[400],
                                   Colors.greenAccent[400],
                                   Colors.tealAccent[400],
                                   Colors.tealAccent[700],
                                 ],
                               ),
                             ),
                             width: MediaQuery.of(context)
                                 .size
                                 .width,
                             height: 45,
                             child: FlatButton(
                               disabledColor: Colors.grey,
                               onPressed: () {
                                 Navigator.push(
                                     context,
                                     new MaterialPageRoute(
                                         builder: (context) =>
                                             Statistics(
                                                 completedOrder)));
                               },

                               child: Row(
                                 mainAxisAlignment:
                                     MainAxisAlignment
                                         .spaceBetween,
                                 children: <Widget>[
                                   Padding(
                                     padding: EdgeInsets.only(
                                         left: 20),
                                   ),
                                   Container(
                                     //width: 150,
                                     //color: Colors.grey,
                                     child: Text(
                                       'Statistics',
                                       textDirection:
                                           TextDirection.ltr,
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 17.0,
                                         decoration:
                                             TextDecoration.none,
                                         fontFamily: 'MyriadPro',
                                         fontWeight:
                                             FontWeight.normal,
                                       ),
                                     ),
                                   ),
                                   // Padding(
                                   //   padding: EdgeInsets.only(left: 90),
                                   // ),

                                   Container(
                                       //width: 80,
                                       // color: Colors.red,
                                       child: Icon(
                                     Icons.keyboard_arrow_right,
                                     color: Colors.white,
                                     size: 30,
                                   ))
                                 ],
                               ),
                               color: Colors.transparent,
                               //elevation: 4.0,
                               //splashColor: Colors.blueGrey,
                               shape: new RoundedRectangleBorder(
                                   borderRadius:
                                       new BorderRadius.circular(
                                           20.0)),
                             )),
                       ],
                     ),
                   )

                   ///////overview end//////
                 ]))),
              )));
  }
}
