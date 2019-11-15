import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Screen/DropLocation/DropLocation.dart';
import 'package:canna_drive_main/Screen/orderDetails/orderDetails.dart';
import 'package:canna_drive_main/Screen/AcceptedOrders/AcceptedOrders.dart';
import 'package:canna_drive_main/Screen/PickLocation/PickLocation.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/Model/NewOrderModel/NewOrderModel.dart';
import 'package:canna_drive_main/Model/DriverOrderModel/DriverOrderModel.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:canna_drive_main/Screen/SubmitDriverDetails/SubmitDriverDetails.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var orderData;
  var orderAccepted;
  bool _isLoading = false;
  bool _isLoadingAccept = false;

  var userData;
  var driverData;
  String orderType= "";

  @override
  void initState() {
    bottomNavIndex = 1;
    store.dispatch(ConnectionCheck(true));

   
    _getUserInfo();

    print(bottomNavIndex);
    super.initState();
  }

  void _call(){
    print("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      _showOrder();
      _showPreviousOrder();
  }

  bool _driverIsEmpty = false;

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
      orderType="no";
    } else {
      setState(() {
        driverData = driver;
        _driverIsEmpty = false;
          orderType="yes";
        // print(driverData);
      });

      print(driverData['id']);
     store.state.isOrder == true? null: _showOrder();
      store.state.isOrder == true? null: _showPreviousOrder();
    }

    var latitudeJson = localStorage.getString('Latitude');
    var longitudeJson = localStorage.getString('Longitude');

    print("latitudeJson");
    print(latitudeJson);
    print(longitudeJson);
  }

  Future <void> _showOrder() async {
if (!mounted) return;
        setState(() {
      _isLoading = true;
    });
    var res = await CallApi().getData('app/getNewOrder');
    var collection = json.decode(res.body);
    var order = NewOrderModel.fromJson(collection);
if (!mounted) return;
    setState(() {
      orderData = order.orders;
    });
  if (!mounted) return;  setState(() {
      _isLoading = false;
    });

    store.dispatch(NotAcceptedList(orderData));
    store.dispatch(ClickOrder(true));

    print(store.state.newnotAcceptList);
    print(orderData);
  }

  Future <void> _showPreviousOrder() async {
  if (!mounted) return;  setState(() {

      _isLoadingAccept = true;
    });
    var res = await CallApi().getData('app/ordersDriver');
    var collection = json.decode(res.body);

    var orderPrevious = DriverOrderModel.fromJson(collection);
if (!mounted) return;
    setState(() {
      orderAccepted = orderPrevious.order;

      _isLoadingAccept = false;
    });

     store.dispatch(AccptedList(orderAccepted));
     store.dispatch(ClickOrder(true));
  }

  @override
  Widget build(BuildContext context) {
    return _driverIsEmpty ||  orderType=="no"?
        Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.greenAccent,
              elevation: 0,
              title: Text("Orders"),
            ),
            body: Center(
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
                        stops: [0.1, 0.3, 0.6, 0.9],
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
            )))
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Color(0xFFFFFFFF),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        TabBar(
                          
                          indicatorColor: Colors.green[600],
                          indicatorWeight: 3,
                        
                              // child: new RefreshIndicator(
                          //isScrollable: true,
                          tabs: [
                         
                           Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'New Orders',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color:Color(0xFF00CE7C),
                                //  color:Color(0xFF01d56a),
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          
                           ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'My Orders',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                 // color:Color(0xFF01d56a),
                                color:Color(0xFF00CE7C),
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          ): RefreshIndicator(
                             onRefresh: _showOrder,
                    child:
                         store.state.newnotAcceptList== null || store.state.newnotAcceptList.length < 1
                            ? Center(
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                      child: Text("You have no new order"),
                              ),
                                    ),
                                    ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                 )

                                  ],
                                ))
                            
                                : SingleChildScrollView(
                                   physics: const AlwaysScrollableScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        children: _showAllOrder(),
                                      ),
                                    ),
                                  ),
                  ),
                 _isLoadingAccept
                        ? Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.green,
                            ),
                          ): RefreshIndicator(
                             onRefresh: _showPreviousOrder,
                    child:
                         store.state.acceptedList == null || store.state.acceptedList.length < 1
                            ? Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                  child: Text("You have no new order"),
                              ),
                                ),
                               ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                 )
                              ],
                            )
                           
                                : SingleChildScrollView(
                                   physics: const AlwaysScrollableScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        children: _showAcceptedOrder(),
                                      ),
                                    ),
                                  ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget> _showAllOrder() {
    List<Widget> list = [];
    // int checkIndex=0;
    for (var d in store.state.newnotAcceptList) {
      list.add(HistoryCard(d));

      //  print(d.status);
    }

    return list;
  }

  List<Widget> _showAcceptedOrder() {
    List<Widget> list = [];
    // int checkIndex=0;
    for (var d in store.state.acceptedList) {
      //    checkIndex = checkIndex+1;

      //  print(orderAccepted) ;
      //   print(d.seen);
      //
      list.add(AcceptedOrders(d));
    }

    return list;
  }
}

//////////Body//////

bool _anotherDriver = false;

class HistoryCard extends StatefulWidget {
  var data;
  HistoryCard(this.data);
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  var userData;
  var driverData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver = json.decode(driverJson);
    if (!mounted) return;
    setState(() {
      userData = user;
      driverData = driver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, SlideLeftRoute(page: OrderDetailsPage(widget.data)));
      },
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
         margin: EdgeInsets.only(bottom: 10),
              child: Container(
          
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
           // color: Colors.white,
            borderRadius: BorderRadius.circular(15),
               color:Colors.white,
                             boxShadow:[
                               BoxShadow(color:Colors.grey[200],
                               blurRadius: 16.0,
                               // offset: Offset(0.0,3.0)
                                )
                             
                             ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ////////////////Order Id start////////////
                    Container(
                      //color: Colors.red,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /////////// /////////

                          Container(
                            child: Text(
                              //"name",
                              "Order ID: ",
                              textAlign: TextAlign.left,
                                  style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                              // style: TextStyle(
                              //     color: Colors.black,
                              //     fontFamily: "DINPro",
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              child: Text(
                                //"name",
                                '${widget.data.id}' == null
                                    ? ""
                                    : ' ${widget.data.id}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontFamily: "DINPro",
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ////////////////Order Id end////////////

                    ////////////////Store start////////////
                    Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /////////// /////////

                          Container(
                            child: Text(
                              //"name",
                              "Store Name: ",
                              textAlign: TextAlign.left,
                                 style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              child: Text(
                                //"name",
                                widget.data.seller.name == null
                                    ? ""
                                    : widget.data.seller.name,
                                textAlign: TextAlign.left,
                               style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ////////////////store end////////////

                    ////////////////Buyer start////////////
                    Container(
                       margin: EdgeInsets.only(top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /////////// /////////

                          Container(
                            child: Text(
                              //"name",
                              "Buyer Name: ",
                              textAlign: TextAlign.left,
                                 style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              child: Text(
                                //"name",
                                widget.data.buyer.name == null
                                    ? ""
                                    : widget.data.buyer.name,
                                textAlign: TextAlign.left,
                               style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ////////////////Buyer Id end////////////

                    ////////////////Address start////////////
                    ////////////////Address start////////////
                    Container(
                        margin: EdgeInsets.only(top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /////////// /////////

                          Container(
                            child: Text(
                              //"name",
                              "Delivery Address: ",
                              textAlign: TextAlign.left,
                                 style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              child: Text(
                                //"name",
                                widget.data.buyer.delAddress == null
                                    ? ""
                                    : widget.data.buyer.delAddress,
                                textAlign: TextAlign.left,
                               style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ////////////////Order Id end////////////
                  ],
                ),
              ),

              //////////Button Section Start/////////

              Container(
                padding: EdgeInsets.only(top: 20,bottom: 6),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ///////////////// Seller Button  Start///////////////

                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          decoration: BoxDecoration(
                          color:Color(0xFF34da9c),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          //width: 150,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  SlideLeftRoute(
                                      page: PickLocation(widget.data)));
                            },
                            child: Container(
                              child: Text(
                                'Pick Location',
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF343434),
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            color: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),
                    ),

                    ///////////////// Seller Button  End///////////////

                    ///////////////// Buyer Button  Start///////////////

                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            color: Color(0xFF7fe6bd),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          height: 40,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  SlideLeftRoute(
                                      page: DropLocation(widget.data)));
                            },
                            child: Container(
                              child: Text(
                                'Drop Location',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Color(0xFF343434),
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            color: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),
                    ),

                    /////////////////Buyer Button  End///////////////
                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      color:Color(0xFF00CE7C),
                   // color: Colors.greenAccent[400],
                        // gradient: LinearGradient(
                        //                         begin: Alignment.centerRight,
                        //                         end: Alignment.topLeft,
                        //                         stops: [0.1, 0.4, 0.6, 0.9],
                        //                         colors: [
                        //                           Colors.greenAccent[400],
                        //                           Colors.greenAccent[400],
                        //                           Colors.tealAccent[400],
                        //                           Colors.tealAccent[700],
                        //                         ],
                        //                       ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      _acceptOrder();
                    },
                    child: Container(
                      child: Text(
                        'Accept Order',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color(0xFF343434),
                          fontSize: 17.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'MyriadPro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),

              //////////Button Section end//////
            ],
          ),
        ),
      ),
    );
  }

  void _acceptOrder() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var latitudeJson = localStorage.getString('Latitude');
    var longitudeJson = localStorage.getString('Longitude');

    //
    var data = {
      'id': '${widget.data.id}',
      'status': "Driver has accepted order", //'Order has been accepted',
      'lat': latitudeJson,
      'lng': longitudeJson,
      'driverId': '${driverData['id']}',
      'title': "Driver Found",
      'body': "${userData['name']} has accepted order ${widget.data.id}",
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'
    };

    var res = await CallApi().postData(data, 'app/driverAcceptOrder');
    var body = json.decode(res.body);


    print("accept order body");
    print(body);

    if (body['success'] == false &&
        body['message'] == "Order is accepted by other driver !") {
      _showDriverMsg();
    } else {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Navigation()));
    }
  }

  void _showDriverMsg() {
    _anotherDriver = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(5),
            title: Text(
              "Order is accepted by other driver !",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: "grapheinpro-black",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  // width: MediaQuery.of(context).size.width/3,
                  height: 30,
                  margin: EdgeInsets.only(bottom: 15, right: 10),
                  child: OutlineButton(
                      color: Colors.greenAccent[400],
                      child: new Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Navigation()));
                      },
                      borderSide: BorderSide(color: Colors.green, width: 0.5),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))))
            ]);
      },
    );
  }
}
