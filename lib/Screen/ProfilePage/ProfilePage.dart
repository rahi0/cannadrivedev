import 'dart:convert';

import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Screen/LogInPage/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/Screen/settingPage/settingPage.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';

import '../../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData;
  var driverData;
  var imgData;
  
   bool _isLoaded = false;
   bool _isLoading = true;
  @override
  void initState() {
     bottomNavIndex = 3;
     
    _getUserInfo();
    super.initState();
  }


_showMsg(msg) {
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

 
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver = json.decode(driverJson);
   
    setState(() {
      userData = user;
      driverData = driver;
      _isLoaded = true;
        userData['img']!=null? imgData ="https://www.dynamyk.biz"+'${userData['img']}': "";
    });

    print(imgData);
    print(userData);

      setState(() {
   _isLoading = false; 
  });
    // print(userData);
     print(driverData);
  }

  Container profileContainer(String label, String text) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left: 0, right: 10),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
             width: MediaQuery.of(context).size.width/3,
            margin: EdgeInsets.only(left: 20),
         
            //color: Colors.blue,
            child: Text(
              label,
              textAlign: TextAlign.left,
             style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),

          ////////  name textfield /////////

          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
              //color: Colors.yellow,
              child: Text(
                text,
                style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                //  fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded ? Container(child: Center(child: CircularProgressIndicator(),),) 
    : Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Colors.white30,
      // ),
      //backgroundColor: Colors.grey[200],
      //resizeToAvoidBottomPadding: false,
      body:SafeArea(
              child: _isLoading?
        Container(
         
          child:Center(child: CircularProgressIndicator(),) ,) :SingleChildScrollView(
            child: Container(
               color: Colors.white,  
               margin: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //////// photo part //////////

                  Container(
                    
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       

                        ////////// photo/////////

                        Container(
                         margin: EdgeInsets.only( bottom: 20),
                          child: Stack(
                            children: <Widget>[ 
                              Container(
                                   width: 120,
                                   height: 120,
                                  decoration: new BoxDecoration(
                                      border: Border.all(
                                      
                                      width: 3,
                                        color:Color(0xFF01d56a).withOpacity(0.4),
                                        
                                      ),
                                      shape: BoxShape.circle),
                                      child: ClipOval(
                                          child:  userData['img']!= null
                                  // ? Image.asset(
                                            
                                  //                     'assets/images/camera.png',
                                  //          // 'assets/img/camera.png',
                                  //           height: 100,
                                  //           width: 100,
                                  //           fit: BoxFit.cover, 
                                  //         )
                                  ?Image.network(
                                           imgData,
                                         // "https://dynamyk.co"+'${userData['img']}',
                                      //  'https://picsum.photos/250?image=9', 
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          )
                                          :Image.asset(
                                            
                                                      'assets/images/camera.png',
                                           // 'assets/img/camera.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        )),

                              //////   camera icon  ////////////
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///////////// Form Start //////////

                  /////////// name field //////
                  profileContainer(
                      "Name", userData != null ? '${userData['name']}' : '---'),

                  driverData==null?Container():profileContainer("License Number",
                      driverData != null && driverData['license'] != null ? '${driverData['license']}' : ''),


                  profileContainer(
                        "Country",
                        userData != null
                            ? '${userData['country']}'
                            : '---'),
                    profileContainer("State",
                        userData != null ? '${userData['state']}' : '---'),
                  
                    profileContainer("Email",
                        userData != null ? '${userData['email']}' : '---'),

                        profileContainer(
                      "Birth Date",
                      userData != null ? '${userData['birthday']}' : '---',
                    ),
                    profileContainer("Phone",
                        userData != null ? '${userData['phone']}' : '---'),

                       profileContainer("License Expiration",
                      driverData != null && driverData['licenseExpiration'] != null ? '${driverData['licenseExpiration']}' : '---'),


                     profileContainer("Car Brand",
                      driverData != null && driverData['carBrand'] != null ? '${driverData['carBrand']}' : '---'),


                     profileContainer("Car Model",
                      driverData != null && driverData['carModel'] != null ? '${driverData['carModel']}' : '---'),

                       profileContainer("Car Plate Number",
                      driverData != null && driverData['carPlateNumber'] != null ? '${driverData['carPlateNumber']}' : '---'),

                    

                  /////////////Action BAr///////////////////

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center, 
                    //   children: <Widget>[
                    //     Card(
                    //       elevation: 0.2,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(50)),
                    //       margin: EdgeInsets.only(
                    //           top: 40, bottom: 30, left: 10, right: 10),
                    //       child: Container(
                    //         padding: EdgeInsets.only(
                    //             bottom: 10, top: 10, right: 10, left: 10),
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFFFFFFFF),
                    //           borderRadius: BorderRadius.circular(50),
                    //              boxShadow:[
                    //                BoxShadow(color:Colors.grey[200],
                    //                blurRadius: 16.0,
                    //                // offset: Offset(0.0,3.0)
                    //                 )
                                 
                    //              ],
                    //         ),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: <Widget>[
                    //             ///////////Deactive Button Start/////////
                    //             GestureDetector(
                    //               onTap: () {
                    //                  Navigator.push(context, new MaterialPageRoute(builder: (context) => Settings(userData, driverData)));
                    //               },
                    //               child: Column(
                    //                 children: <Widget>[
                    //                   Container(
                    //                     padding: EdgeInsets.only(bottom: 2),
                    //                     child: Text(
                    //                       "Settings",
                    //                       textAlign: TextAlign.left,
                    //                       style: TextStyle(
                    //                           color: Color(0xFF000000),
                    //                           fontFamily: "sourcesanspro",
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ),
                    //                   Icon(
                    //                     Icons.settings,
                    //                     color: Color(0xFF01D56A),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),

                    //             //////////Deactive Button end/////////
                    //             Container(
                    //               width: 2,
                    //               height: 30,
                    //               color: Colors.grey[300],
                    //             ),

                    //             ///////////Logout Button Start/////////
                    //             GestureDetector(
                    //               onTap: _logout,
                    //               child: Column(
                    //                 children: <Widget>[
                    //                   Container(
                    //                    padding: EdgeInsets.only(bottom: 2),

                    //                     child: Text(
                    //                       "Log Out",
                    //                       textAlign: TextAlign.left,
                    //                       style: TextStyle(
                    //                           color: Color(0xFF000000),
                    //                           fontFamily: "sourcesanspro",
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ),
                    //                   Icon(
                    //                     Icons.exit_to_app,
                    //                     color: Color(0xFF01D56A),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),

                    //             //////////Deactive Button end/////////
                    //             Container(
                    //               width: 2,
                    //               height: 30,
                    //               color: Colors.grey[300],
                    //             ),

                    //             ///////////Deactive Button Start/////////
                    //             GestureDetector(
                    //               onTap: () {
                    //                 // Navigator.push(
                    //                 //     context,
                    //                 //     new MaterialPageRoute(
                    //                 //         builder: (context) => Inquire()));
                    //               },
                    //               child: Column(
                    //                 children: <Widget>[
                    //                   Container(
                    //                      padding: EdgeInsets.only(bottom: 2),

                    //                     child: Text(
                    //                       "Share Code",
                    //                       textAlign: TextAlign.left,
                    //                       style: TextStyle(
                    //                           color: Color(0xFF000000),
                    //                           fontFamily: "sourcesanspro",
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ),
                    //                   Icon(
                    //                     Icons.share,
                    //                     color: Color(0xFF01D56A),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),

                    //             //////////Deactive Button end/////////
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )

                    /////////////Action BAr end///////////////////
                    ///
                    ///
                    Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 30,left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          //height: 90,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                     color:Color(0xFF01d56a).withOpacity(0.8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  //width: 150,
                                  height: 45,
                                  child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Settings',
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    color: Colors.transparent,
                                    // elevation: 4.0,
                                    //splashColor: Colors.blueGrey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0)),
                                    onPressed: () {
                                    Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Settings(userData, driverData)));
                                    },
                                  )),
                              ///////////////// Add to cart Button  Start///////////////

                              Container(
                                  decoration: BoxDecoration(
                                     color: Colors.redAccent,
                                  
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  //width: 150,
                                  height: 45,
                                  child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.exit_to_app,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Logout',
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ), 
                                      ],
                                    ),
                                    color: Colors.transparent,
                                    // elevation: 4.0,
                                    //splashColor: Colors.blueGrey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      _logout();
                                    },
                                  )),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
      ),
    );
  }


 _logout() async {
     var data = {
      'userId': '${userData['id']}' ,
        };
    var res = await CallApi().postData(data,'auth/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      _showMsg(body['message']);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.remove('user');
         localStorage.remove('cannadrive');
         localStorage.remove('token');
        store.state.notificationCount=0;
         store.state.connection= true;
               store.state.orderList= [];
               store.state.newOrderCount= 0;
                store.state.notifiCheck= true;
               store.state.notiList= [];
               store.state.reviewList=[];
               store.state.averageRate =0;
               store.state.newnotAcceptList= [];
               store.state.acceptedList= [];
               store.state.isOrder=false;
               store.state.isReview= false;
               store.state.isHome= false;


      
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => LogIn()));

    } else {
      _showMsg(body['message']);
    }
  }

}
