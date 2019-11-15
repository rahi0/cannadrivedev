import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Screen/DropLocation/DropLocation.dart';
import 'package:canna_drive_main/Screen/AcceptedOrderDetails/AcceptedOrderDetails.dart';
import 'package:canna_drive_main/Screen/PickLocation/PickLocation.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';

import 'package:canna_drive_main/Screen/ReportPage/ReportPage.dart';

class AcceptedOrders extends StatefulWidget {

  var data;
  AcceptedOrders(this.data);
  @override
  _AcceptedOrdersState createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {


  var userData;
  var driverData;
  bool _isDriverFound = false;
 

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        print(widget.data);

        Navigator.push(context, SlideLeftRoute(page: AcceptedOrderDetails(widget.data)));
      },
          child: Card(
                      elevation: 0.5,
                      margin: EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                         
                         decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:  BorderRadius.circular(20),
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
                  fontWeight: FontWeight.w600)
                                                          ),
                                                        ),

                                        
                                        Expanded(
                                          child: Container(    
                                             child: Text(
                                               //"name",
                                                '${widget.data.id}' == null
                                        ? ""
                                        : '${widget.data.id}',
                                                 textAlign: TextAlign.left,
                                                 style: TextStyle(
                                                           color: Colors.teal,
                                                           fontFamily: "DINPro",
                                                           fontSize: 15,
                                                           fontWeight: FontWeight.normal       
                                                               ),
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
                                     margin: EdgeInsets.only(top: 5),
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
                  fontWeight: FontWeight.w600)
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
                                      margin: EdgeInsets.only(top: 5),
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
                  fontWeight: FontWeight.w600)
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
                                  // Container(
                                  //     margin: EdgeInsets.only(top: 5),
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: <Widget>[
                                         
                                  //         /////////// /////////
                                         
                                  //         Container(    
                                  //                 child: Text(
                                  //                   //"name",
                                  //                   "Delivery Address: ",
                                  //                     textAlign: TextAlign.left,
                                  //                     style: TextStyle(
                                  //                               color: Colors.black,
                                  //                               fontFamily: "DINPro",
                                  //                               fontSize: 15,
                                  //                               fontWeight: FontWeight.bold       
                                  //                                   ),
                                  //                         ),
                                  //                       ),

                                        
                                  //       Expanded(
                                  //         child: Container(    
                                  //            child: Text(
                                  //              //"name",
                                  //              "Kolafara",
                                  //                textAlign: TextAlign.left,
                                  //                style: TextStyle(
                                  //                          color: Colors.grey,
                                  //                          fontFamily: "DINPro",
                                  //                          fontSize: 14,
                                  //                          fontWeight: FontWeight.bold       
                                  //                              ),
                                  //                    ),
                                  //                  ),
                                  //       )
                                  //       ],
                                  //     ),
                                  // ),
                  ////////////////Order Id end////////////





                                ],
                              ),
                            ),


                            //////////Button Section Start/////////
                            
                            Container(
                  padding: EdgeInsets.only(top: 20,bottom: 6),
                  //height: 40,
                  //color: Colors.blue,
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
                               onPressed: (){
                                        Navigator.push(
                        context, SlideLeftRoute(page: PickLocation(widget.data)));
                               } ,
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
                              // elevation: 4.0,
                              //splashColor: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                             
                            )
                            ),
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
                            //width: 150,
                            height: 40,
                            child: FlatButton(
                               onPressed: (){
                                  Navigator.push(
                        context, SlideLeftRoute(page: DropLocation(widget.data)));

                               } ,
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
                              // elevation: 4.0,
                              //splashColor: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                             
                            )
                            ),
                      ),

                      /////////////////Buyer Button  End///////////////
                    ],
                  ),
                  ),
                  Container(
                                                 padding: EdgeInsets.only(top: 3, bottom: 3),
                            decoration: BoxDecoration(
                             color:Color(0xFF00CE7C),
                      //                gradient: LinearGradient(
                      //   begin: Alignment.centerRight,
                      //   end: Alignment.topLeft,
                      //   stops: [0.1, 0.3, 0.6, 0.9],
                      //   colors: [
                      //     Colors.greenAccent[400],
                      //     Colors.greenAccent[400],
                      //     Colors.tealAccent[400],
                      //     Colors.tealAccent[700],
                      //   ],
                      // ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: FlatButton(
                               onPressed: (){
                                   Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ReportPage(widget.data)));
                              
                               } ,
                              child: Container(
                               
                                child: Text(
                                           'Report an Issue',
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
                              
                              // elevation: 4.0,
                              //splashColor: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                             
                            )
                            ),

              

                  

                            //////////Button Section end//////
                          ],
                        ),
                      ),
                    ),
    );
  }

//    void _acceptOrder() async {


//       SharedPreferences localStorage = await SharedPreferences.getInstance();
   
//     var latitudeJson = localStorage.getString('Latitude');
//     var longitudeJson = localStorage.getString('Longitude');

    
//       var data = {
//       'id': '${widget.data.id}',      
//       'status': 'Order is on the way',
//       'lat': latitudeJson, 
//       'lng': longitudeJson,
//       'driverId': '${driverData['id']}'
      
//     };

//     var res = await CallApi().postData(data, 'app/driverAcceptOrder');
//     var body = json.decode(res.body);
//    // print('${driverData['id']}');
//  print(body);



//     Navigator.push(
//         context, new MaterialPageRoute(builder: (context) => Navigation()));

   
//   }
}