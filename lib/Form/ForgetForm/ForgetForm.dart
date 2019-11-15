import 'package:flutter/material.dart';


class ForgetPassForm extends StatefulWidget {
  @override
  _ForgetPassFormState createState() => _ForgetPassFormState();
}

class _ForgetPassFormState extends State<ForgetPassForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                      print('object');
                                    },
                                  )),

                                  ///////////////// Submit Button  End///////////////



                                 

                  ],
                ),
              )
      ],)
    );
  }
}