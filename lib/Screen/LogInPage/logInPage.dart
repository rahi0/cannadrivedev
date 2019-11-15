import 'package:canna_drive_main/Form/LogInForm/logInForm.dart';
import 'package:canna_drive_main/Screen/DriverCommonRegisterPage/DriverCommonRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


  class LogIn extends StatefulWidget {
    @override
    _LogInState createState() => _LogInState();
  }
  
  class _LogInState extends State<LogIn> {
 
  //  @override
  // void dispose() {
  //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.only(left: 20),
                alignment: Alignment.center,
                height: 90,
                width: MediaQuery.of(context).size.width,
                //color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CannaDrive',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 31.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'sourcesanspro',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/cannadrive.png', 
                          height: 85,
                          width: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              LogInForm(),


GestureDetector(
                    onTap: () {
                       Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => DriverCommonRegisterPage()));

                                  
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        'Have not account? Sign Up',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'sourcesanspro',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                     
            ],
          ),
      ),
    ),
        ));
  }
}
