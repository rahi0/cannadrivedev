import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:canna_drive_main/api/api.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';


class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
          'Change Password',
          style: TextStyle(
          color:Color(0xFF01d56a),
          //  fontSize: 21.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
       // centerTitle: true,
      ),
        //backgroundColor: Colors.white,
        body: SafeArea(
                  child: Container(
      child: SingleChildScrollView(
              child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 40),
              child: Column(
                children: <Widget>[

                //  VerifyEmail(),
 
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.only(bottom: 30, top: 30),
          alignment: Alignment.center,
          //height: 70,
          width: MediaQuery.of(context).size.width,
         // color: Colors.blue,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Please enter your "Old Password" to verify this account',
                  //textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'sourcesanspro',  
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        

        /////////// Form Start//////////
        
        ResetPassForm()
        ///////////Form end///////////
                ],
              ),
            ),
      ),
    ),
        ));
  }
}








/////////



class ResetPassForm extends StatefulWidget {
  @override
  _ResetPassFormState createState() => _ResetPassFormState();
}

class _ResetPassFormState extends State<ResetPassForm> {

    _showMsg(msg) { //
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

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


    var matchOldPass="";
   @override
  void initState() {
  

      _getOldPass();
    
    super.initState();
  }

  void _getOldPass() async{ 
 SharedPreferences localStorage = await SharedPreferences.getInstance();
      matchOldPass = localStorage.getString('pass');
      print(matchOldPass);
  
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      //color: Colors.red,
      child: Column(children: <Widget>[
        Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 0),
               // height: 100,
                width: MediaQuery.of(context).size.width,
                //color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[



                    ///////////////// Old PAssword Textfield  Start///////////////
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: TextField(
                        obscureText: true,
                        controller: oldPasswordController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green[300].withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40))),
                                  child: Icon(
                                    Icons.vpn_key,
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

                    /////////////////Old PAssword Textfield  End///////////////
                    



                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(bottom: 10, top: 0),
                        alignment: Alignment.centerLeft,
                        //height: 70,
                        width: MediaQuery.of(context).size.width,
                      // color: Colors.blue,
                        child: Text(
                            'Enter your new password',
                            //textDirection: TextDirection.ltr,
                          style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'sourcesanspro',  
                    fontWeight: FontWeight.w500,
                  ),
                          ),
                      ),

                    ///////////////// New Password Textfield  Start///////////////
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextField(
                        obscureText: true,
                        controller: newPasswordController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green[300].withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40))),
                                  child: Icon(
                                    Icons.vpn_key,
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
                          hintText: "New Password",
                        ),
                      ),
                    ),

                    ///////////////// New Password Textfield  End///////////////
                    



                    ///////////////// Confirm Textfield  Start///////////////
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green[300].withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40))),
                                  child: Icon(
                                    Icons.vpn_key,
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
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),

                    ///////////////// Confirm Textfield  End///////////////


                          
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


                                  ///////////////// Submit Button  Start///////////////
                    



                    Container(
                                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                        ), ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  child: FlatButton(
                                    child: Text(
                                      'Submit',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'MyriadPro',
                                          fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    color: Colors.transparent,
                                    //elevation: 4.0,
                                    //splashColor: Colors.blueGrey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0)),
                                    onPressed: _changePassword,
                                  )),

                                  ///////////////// Submit Button  End///////////////



                                 

                  ],
                ),
              )
      ],)
    );
  }

   _changePassword() async{
     if (oldPasswordController.text.isEmpty){
        return _showMsg("Old Password is empty");
      }
        else if(matchOldPass != oldPasswordController.text){
        return _showMsg("Old Password doesn't match");
      }
      else if (newPasswordController.text.isEmpty){
        return _showMsg("New Password is empty");
      }
      else if (confirmPasswordController.text.isEmpty){
        return _showMsg("Confirm Password is empty");
      }

      else if(newPasswordController.text != confirmPasswordController.text){
        return _showMsg("Confirm Password doesn't match");
      }

 
      var data = {
      'oldPassword': oldPasswordController.text, 
      'password' : newPasswordController.text        
    };

    var res = await CallApi().postData(data, 'auth/resetPassword');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.remove('pass');
       localStorage.setString('pass', newPasswordController.text);
   
      _changePassMsg();
      
    }
     else{     
     
      _showMsg("Error");
    }
      
     
  }

         void _changePassMsg() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: 
              Text(
                                "Your Password has been changed. Now you can login with your new password",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: "grapheinpro-black",
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
              actions: <Widget>[
                Container(
               alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              // width: MediaQuery.of(context).size.width/3,
                              height: 30,
                              margin: EdgeInsets.only(bottom: 15, right: 10),
                              child: OutlineButton(
                                  color: Colors.greenAccent[400],
                                  child: new Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    
                                Navigator.push(context, SlideLeftRoute(page: Navigation()));
                                  },
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))]

     
        );
      },
    );
  }


}