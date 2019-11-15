


import 'package:flutter/material.dart';
import 'package:canna_drive_main/DriveMap/DriveMap.dart';

class OrderAlert extends StatefulWidget {
  @override
  _OrderAlertState createState() => _OrderAlertState();
}

class _OrderAlertState extends State<OrderAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Container(
              height: 30.00,
              width: 350.00,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 3, color: Colors.grey.withOpacity(0.2)))),
              child: Row(children: [
                Text(
                  "Distance ",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(bottom: 4),
                    width: 100,
                    height: 10,
                    child: Text(
                      '4 km',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    )),
              ])),
          content: Container(
            margin: EdgeInsets.only(top: 5, right: 5, left: 20),
            height: 40,
            width: 300.00,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  child: Text('Total distance to you of your package',
                      style: TextStyle(color: Colors.black87, fontSize: 11))),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('4 km from your location',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black87, fontSize: 11)),
              )
            ]),
          ),
          actions: <Widget>[
            Container(
                height: 70,
                width: 250,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          width: 110,
                          height: 45,
                          margin: EdgeInsets.only(
                            top: 25,
                            bottom: 15,
                          ),
                          child: OutlineButton(
                            child: new Text(
                              "Decline",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          width: 110,
                          height: 45,
                          margin: EdgeInsets.only(top: 25, bottom: 15),
                          child: OutlineButton(
                              color: Colors.green,
                              child: new Text("Accept", style: TextStyle(color: Colors.white),),
                              onPressed: () {

                                
                                 Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => MapPage()));
                              },
                              borderSide:
                                  BorderSide(color: Colors.green, width: 0.5),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0))))
                    ]))
          ],
        );
  }
}