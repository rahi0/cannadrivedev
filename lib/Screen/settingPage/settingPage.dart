import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:canna_drive_main/Screen/ChangePassword/ChangePassword.dart';
import 'package:canna_drive_main/Screen/profileEditPage/profileEditPage.dart';
import 'package:canna_drive_main/Screen/EditCannaDrivePage/editCAnnaDrivePage.dart';
import 'package:canna_drive_main/Screen/DriverSubmitPage/driverSubmitPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/Screen/SubmitDriverDetails/SubmitDriverDetails.dart';

class Settings extends StatefulWidget {
   final userData;
 final driverData;
  Settings(this.userData, this.driverData);
  
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
var userData;
  var driverData;
  
  //  }

   @override
  void initState() {
     _getUserInfo();
    super.initState();
  }

bool _driverIsEmpty=true;

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

        // print(driverData);
      });
    //  Timer.periodic(Duration(seconds: 5), (timer) {
        // _showOrderRequest();

      //    });
      //_showReviewData();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
          'Settings',
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
      body: Container(
        //color: Colors.red,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            ///////////Edit Profile Button//////////
            GestureDetector(
                onTap: () {
                   Navigator.push(context, new MaterialPageRoute(builder: (context) => ProfileEditPage(widget.userData, widget.driverData)));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    //margin: EdgeInsets.only(bottom: 40),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                Icons.settings,
                color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                'Edit Profile',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                color: Colors.black,
                               
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                 fontWeight: FontWeight.w500,
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )),

            ///////////Edit Profile Button//////////

            Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                color: Colors.grey[400],
              ),
            ),

            ///////////Reset Password Button//////////

            GestureDetector(
                onTap: () {
                  Navigator.push(context, SlideLeftRoute(page: ChangePassword())); 
                },
                child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Change Password',
                              textDirection: TextDirection.ltr,
                             style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                color: Colors.black,
                               
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                 fontWeight: FontWeight.w500,
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                  )),

            ///////////Reset Password Button end//////////
            
 

          Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                color: Colors.grey[400],
              ),
            ),

            ///////////Reset Cannbie Button//////////

          // widget.driverData != null ? 
         !_driverIsEmpty?  GestureDetector(
                onTap: () {
               Navigator.push(context, SlideLeftRoute(page: DriverEditPage(widget.userData, widget.driverData)));
                },
                child: Container(
             
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                           
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Edit Car Details',
                              textDirection: TextDirection.ltr,
                             style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                color: Colors.black,
                               
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                 fontWeight: FontWeight.w500,
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                  )
                )

            ///////////Reset Cannabi Button end//////////
             
            :

            ///////////Submit Cannbie Button//////////

           GestureDetector(
                onTap: () {
                  Navigator.push(context, SlideLeftRoute(page: SubmitDriverDetails()));
                },
                child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Submit Car Details',
                              textDirection: TextDirection.ltr,
                             style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                color: Colors.black,
                               
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                 fontWeight: FontWeight.w500,
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                  )
                ),
 Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                color: Colors.grey[400],
              ),
            ),
            ///////////Submit Cannabi Button end//////////
            
          ],
        ),
      ),
    ));
  }

}
