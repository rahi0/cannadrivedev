



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:canna_drive_main/api/api.dart';
import 'package:canna_drive_main/form/LogInForm/LogInForm.dart';
import 'package:canna_drive_main/screen/VerifyPin/VerifyPin.dart';
import 'package:canna_drive_main/screen/forgetPassPage/forgetPassPage.dart';



class VerifyPin extends StatefulWidget {
  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {



  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomPadding: false,
        //backgroundColor: Colors.white,
          appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF01d56a),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        title: Text(
          'Submit Pin',
          style: TextStyle(
            color: Color(0xFF01d56a),
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
        body:SingleChildScrollView(child: VerifyPinForm())
    );
  }
}

class VerifyPinForm extends StatefulWidget {
  @override
  _VerifyPinFormState createState() => _VerifyPinFormState();
}

class _VerifyPinFormState extends State<VerifyPinForm> {


  TextEditingController tokenController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.fromLTRB(10, 70, 10, 50),
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 40),
          child: Column(
            children: <Widget>[
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   //height: 40,
      //   alignment: Alignment.centerLeft,
      //   margin: EdgeInsets.only(bottom: 25),
      //  // color: Colors.yellow,
      //   child: BackButton(),
      // ),

      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        height: 70,
        width: 300,
       // color: Colors.blue,
        child: Row(
          children: <Widget>[
            Expanded(
                                  child: Text(
               'We send verification code to your email,Please check your Email and enter the verification code here. ',
                //textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'sourcesanspro',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      

      /////////// Form Start//////////
      
             Container(
      child: Column(children: <Widget>[
        Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.only(top: 20),
        height: 100,
        width: MediaQuery.of(context).size.width,
        //color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[



            ///////////////// Email Textfield  Start///////////////
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                controller: tokenController,
                keyboardType: TextInputType.text,
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
                  hintText: "verification code",
                ),
              ),
            ),

            ///////////////// Email Textfield  End///////////////


                  
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
                          width: 320,
                          height: 45,
                          child: FlatButton(
                            child: Text(
                              'Submit',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                              ),
                            ),
                            color: Colors.transparent,
                            //elevation: 4.0,
                            //splashColor: Colors.blueGrey,
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                            onPressed: () {
                              _getValidMail();
                             //  Navigator.push(context, SlideLeftRoute(page: VerifyPin()));
                            },
                          )),

                          ///////////////// Submit Button  End///////////////



                         

          ],
        ),
      )
      ],)
    )
      ///////////Form end///////////
            ],
          ),
        ),
    
    );
  }
   void _getValidMail() async {

       if(tokenController.text.isEmpty){
        return showMsg(context,"Verification Code is empty");
      }

      var data = {
      'token': tokenController.text,          
    };

    var res = await CallApi().postData(data, 'auth/checkPasswordResetCode');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      
       localStorage.setString('passCode', tokenController.text);
       tokenController.text="";
   Navigator.push(context, SlideLeftRoute(page: ForgetPassword()));

      
    }
     else{     
     
      showMsg(context,"Verification Code doesn't match");
    }
  
  }


}
