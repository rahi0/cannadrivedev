import 'dart:convert';

import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:canna_drive_main/Screen/DriverCommonRegisterPage/DriverCommonRegisterPage.dart';
import 'package:canna_drive_main/Screen/VerifyEmail/VerifyEmail.dart';
import 'package:canna_drive_main/Screen/ProfilePage/ProfilePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';


void showMsg(BuildContext context, String msg) {
  //
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

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isLoading = false;
var firebaseToken;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _showMsg(msg) {
    //
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

   void initState() {
   // _showNotification();
     _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);
      setState(() {
          firebaseToken = token;
      });
    
      //  SharedPreferences localStorage = await SharedPreferences.getInstance();
      //  localStorage.setString('firebaseToken',token);
    });
   store.dispatch(ConnectionCheck(true));
    showinternetCheck();
    super.initState();
  }



      void showinternetCheck() {
     // Timer.periodic(Duration(seconds: 2), (timer) {
   

      internetCheck();
   

    // });
  }

     void internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
     
        store.dispatch(ConnectionCheck(true));
    } else if (connectivityResult == ConnectivityResult.wifi) {
      
        store.dispatch(ConnectionCheck(true));
     
    } else {
      
         if(store.state.connection==false){

       
     }
    else{
 _showInternetConnnection();
   }
  
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop:(){
         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
          child: Container(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 40, bottom: 30),
            padding: EdgeInsets.only(top: 20),
            //height: 190,
            width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ///////////////// Email Textfield  Start///////////////
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: mailController,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green[300].withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40))),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontFamily: "sourcesanspro",
                          fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 12, top: 12),
                      fillColor: Colors.green[200].withOpacity(0.5),
                      filled: true,
                      hintText: "Email",
                    ),
                  ),
                ),

                ///////////////// Email Textfield  End///////////////

                ///////////////// Password Textfield  start///////////////
                Container(
                  child: TextField(
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green[300].withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40))),
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontFamily: "sourcesanspro",
                          fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 12, top: 12),
                      fillColor: Colors.green[200].withOpacity(0.5),
                      filled: true,
                      hintText: "Password",
                    ),
                  ),
                ),

                ///////////////// Password Textfield  End///////////////

                ///////////////// Forget Button  Start///////////////

                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed("/ForgetPass");
                    Navigator.push(
                        context, SlideLeftRoute(page: VerifyEmail()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 5),
                    child: Text(
                      'Forgot your password?',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'sourcesanspro',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )

                ///////////////// Forget Button  End///////////////
              ],
            ),
          ),
            Container(
            alignment: Alignment.centerLeft,
            //height: 90,
            width: MediaQuery.of(context).size.width,
            //color: Colors.yellow,
            child: Column(
              children: <Widget>[
                ///////////////// Log In Button  Start///////////////

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
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: FlatButton(
                      disabledColor: Colors.grey,
                      onPressed: _isLoading ? null : _login,
                      // onPressed: () {
                      //   Navigator.push(
                      //       context,
                      //       new MaterialPageRoute(
                      //           builder: (context) => App()));
                      // },

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            //width: 150,
                            //color: Colors.grey,
                            child: Text(
                              _isLoading? 'Logging...' : 'Login',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'MyriadPro',
                                fontWeight: FontWeight.w500,
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
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),

                ///////////////// Log In Button  End///////////////

             
              ],
            ),
          )
        ],
      )),
    );
  }

  void _login() async{
    

    if(mailController.text.isEmpty){
        return _showMsg("Email is empty");
      }
      else if(passwordController.text.isEmpty){
        return _showMsg("Password is empty");
      }

    setState(() {
       _isLoading = true;
    });

    var data = {
        'email' : mailController.text, 
        'password' : passwordController.text,
        'app_Token': firebaseToken
    };

    var res = await CallApi().postData(data, 'auth/loginDrive');
    var body = json.decode(res.body);
    print(body);
   if(body['success']==true){
    // print('oise');
      SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', body['token']);
    localStorage.setString('user', json.encode(body['user']));
    localStorage.setString('pass', passwordController.text);
    localStorage.setString('cannadrive', json.encode(body['cannadrive']));
    // mailController.text=""; 
    // passwordController.text="";
    print("Token");
    print(body['token']);
    bottomNavIndex=0;
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Navigation()));
      }
else if(body['messeage']=='You are not a driver!'){     
      _showMsg("You are not a driver!");
    }

     else{     
      _showMsg("Invalid Email or Password");
    }


    setState(() {
       _isLoading = false;
    });

  


  }

        void _showInternetConnnection() {

      store.dispatch(ConnectionCheck(false));
   //store.dispatch(ConnectionCheck(true));
    // Timer.periodic(Duration(seconds: 20), (timer) {
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
    // });
  }
}
// SharedPreferences localStorage = await SharedPreferences.getInstance();
//      firebaseToken = localStorage.getString('firebaseToken');