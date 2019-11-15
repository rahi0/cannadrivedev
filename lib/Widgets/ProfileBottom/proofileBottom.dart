


import 'dart:convert';

import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Screen/LogInPage/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileBottom extends StatefulWidget {
  @override
  _ProfileBottomState createState() => _ProfileBottomState();
}

class _ProfileBottomState extends State<ProfileBottom> {

 var userData;
 var driverData;
 
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }
SharedPreferences localStorage;


 void _getUserInfo() async {
    localStorage = await SharedPreferences.getInstance();
  
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
  
    var user = json.decode(userJson);
    var driver = json.decode(userJson);
   
    setState(() {
      userData = user;
      driverData = driver;
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  margin:
                      EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
                  child: Container(
                    // width: 300,
                    //height: 60,
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (context) => Inquire()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Deactivate",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: "grapheinpro-black",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.supervisor_account,
                                    color: Color(0xFF01D56A),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 3,
                          height: 30,
                          color: Colors.grey[300],
                          margin: EdgeInsets.only(left: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (context) => Report()));
                          },
                          child: GestureDetector(

                            onTap: (){

                              logout();
                              
                            },
                                                      child: Container(
                              margin: EdgeInsets.only(left: 15, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Log out",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontFamily: "grapheinpro-black",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                    Container(
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: Color(0xFF01D56A),
                                    ),
                                  )
                                  // Container(
                                  //     width: 20,
                                  //     height: 20,
                                  //     margin: EdgeInsets.only(top: 5),
                                  //     decoration: new BoxDecoration(
                                  //         image: new DecorationImage(
                                  //       fit: BoxFit.fill,
                                  //       image: new AssetImage(
                                  //           'assets/images/logout.png'),
                                  //     )))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 3,
                          height: 30,
                          color: Colors.grey[300],
                          margin: EdgeInsets.only(left: 15),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5),
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Share code",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: "grapheinpro-black",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),

                                Container(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.share,
                                    color: Color(0xFF01D56A),
                                  ),
                                )
                              // Container(
                              //     width: 20,
                              //     height: 20,
                              //     margin: EdgeInsets.only(top: 5),
                              //     decoration: new BoxDecoration(
                              //         image: new DecorationImage(
                              //       fit: BoxFit.fill,
                              //       image: new AssetImage(
                              //           'assets/images/share-button.png'),
                              //     ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
  }


    void logout() async{

       var data = {
      'userId': '${userData['id']}' ,
        };
      // logout from the server ... 
      var res = await CallApi().postData(data,'auth/logout');
      var body = json.decode(res.body);
      print(body);
      if(body['success']==true){
         localStorage.remove('user');
         localStorage.remove('cannadrive');
         localStorage.remove('token');
          Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => LogIn()));
      }
     
  }
}