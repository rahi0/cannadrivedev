
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:canna_drive_main/Screen/OrderPage/orderPage.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Model/NotificationDetailsModel/NotificationDetailsModel.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:canna_drive_main/Screen/reviewPage/reviewPage.dart';

import '../../main.dart';

class NotificationPage extends StatefulWidget {

  
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
    var notificationData;
  bool _isLoading = false;

  @override
  void initState() {
   // _updateNotification();
  //  print(store.state.notifiCheck);
   store.state.notifiCheck==true? _showNotification():null;
 // _showNotification();
    super.initState(); 
  }
void _updateNotification() async {
    var data = {};

    var res = await CallApi().postData(data, 'app/updateNoti');
    var body = json.decode(res.body);

    print(body);
   
  }
    Future <void> _showNotification() async {
   

   print("aiche");
   setState(() {
    _isLoading = true; 
   });

  var res = await CallApi().getData('app/getUnseenNotiDetails');
    var collection = json.decode(res.body);
    var notification = NotificationDetailsModel.fromJson(collection);
if (!mounted) return;
    setState(() {
       notificationData = notification.notification;
      
    });
     store.dispatch(NotificationCheck(false));
     store.dispatch(NotificationList(notificationData));
     
     print(store.state.notiList.length);
  
setState(() {
      _isLoading = false;
    });
 
  }

//   var notificationData;
//   bool _isLoading = true;

//   @override
//   void initState() {


//    _showNotification();
//    _updateNotification();
//    print("bottomNavIndex");
//    print(bottomNavIndex);
//     super.initState();
//   }

//    void _updateNotification() async {
//     var data = {};

//     var res = await CallApi().postData(data, 'app/updateNoti');
//     var body = json.decode(res.body);

//     print(body);
//     // if (body['success'] == true) {
//     //   Navigator.push(context,
//     //       new MaterialPageRoute(builder: (context) => NotificationPage()));
//     // }
//   }

//     void _showNotification() async {
//     // setState(() {
//     //   _isLoading = true;
//     // });

//     var res = await CallApi().getData('app/getUnseenNotiDetails');
//     var collection = json.decode(res.body);
//     var notification = NotificationDetailsModel.fromJson(collection);

//     setState(() {
//        notificationData = notification.notification;
      
//     });
    
// setState(() {
//       _isLoading = false;
//     });
//    // print(notificationData.length);
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar:  AppBar(
        iconTheme: IconThemeData(
        color: Colors.white
        ),  
            automaticallyImplyLeading: false,
         leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
          bottomNavIndex=0;
           Navigator.push(context,
          new MaterialPageRoute(builder: (context) => Navigation()));
        },
       
      );
    },
  ), 
        backgroundColor:Colors.white,
     //   elevation: 0,
        title: Text("Notification",
        style: TextStyle( color:Color(0xFF01d56a),),)
        ),
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(top: 5,right: 10, left: 10),
          child: _isLoading
              ?Center(child:  CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),)
              :RefreshIndicator(
          onRefresh: _showNotification,
          child: store.state.notiList==null || store.state.notiList.length < 1?

              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                   
                      child: Text("You have no new notification"),
                      
                      ),
                  ),
                   ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                 )
                  
                ],
              )

           
                  :  SingleChildScrollView(
                     physics: const AlwaysScrollableScrollPhysics(),
                      child:Padding(
                                       padding: EdgeInsets.only( top: 5, bottom: 15),
                                      child:// _isLoading?CircularProgressIndicator():
                                       
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: 
                                          _showOrder()
                                        ),
                                    ),
                    ),
     
        ),
      ),
      ),
    );
  }

    List<Widget> _showOrder() {
    

    List<Widget> list = [];
   // int checkIndex=0;
    for (var d in store.state.notiList) {
       // checkIndex = checkIndex+1;
    
      //print("seeen") ;  
      //print(d.seen);
     //   print(d.status);

      list.add(
      NotificationCard(d)
      );
    }

    return list;
  }
}

// RaisedButton(
//               onPressed: (){
//                 Navigator.push( context, SlideLeftRoute(page: ShopItemsPage()));
//               },
//               child: Text('Items'),
//             ),



class NotificationCard extends StatefulWidget {

  var data;
  NotificationCard(this.data);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool open = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){


        //  bottomNavIndex = 1;
           widget.data.title =='New Review Created!'? bottomNavIndex = 2: bottomNavIndex = 1;
         Navigator.push(context,
          new MaterialPageRoute(builder: (context) =>  Navigation()));
     
      },
          child: Card(
                      elevation: 0.5,
                     // margin: EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Container(
                              decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                          color:Colors.white,
                           boxShadow:[
                             BoxShadow(color:Colors.grey[200],
                             blurRadius: 16.0,
                             // offset: Offset(0.0,3.0)
                              )
                           
                           ],
                         
                        ),
            padding: EdgeInsets.only(right: 5, left: 5, top: 10, bottom: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 12.0),
                      child: ClipOval(
                        child: Image.asset(
                          widget.data.title =='New Review Created!'?'assets/images/review.jpg':
                          widget.data.title =='New Order'?'assets/images/new_order.jpg':
                          'assets/images/cannadrive.png',
                          height: 42,
                          width: 42,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                           widget.data.title == null
                                      ? ""
                                      : widget.data.title,

                                //'Your Order Has been recived',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:"sourcesanspro",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold       
                                                        ),
                              ),
                            ),


                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                widget.data.msg == null
                                      ? ""
                                      : widget.data.msg,

                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                                    color: Color(0xFF343434),
                                                      fontFamily:"sourcesanspro",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal       
                                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
                    ),
    );
  }
}