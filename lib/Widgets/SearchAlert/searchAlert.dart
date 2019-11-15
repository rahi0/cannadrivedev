import 'package:flutter/material.dart';

class SearchAlert extends StatefulWidget {
  var duration;
  SearchAlert(this.duration);
  @override
  _SearchAlertState createState() => _SearchAlertState();
}

class _SearchAlertState extends State<SearchAlert> {

 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Column(
               children: <Widget>[
                 Container(
                                width: 100,
                                height: 100,
                                decoration: new BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 5, color: Colors.blue[100]),
                                      top: BorderSide(
                                          width: 5, color: Colors.blue[100]),
                                      left: BorderSide(
                                          width: 5, color: Colors.blue[100]),
                                      right: BorderSide(
                                          width: 5, color: Colors.blue[100]),
                                    ),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/images/nen.jpg'),
                                    ))),
               ],
             ),
          
          content:  Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 180,
            margin: EdgeInsets.only(right: 15),
            child: Column(
              children: <Widget>[
                Text(
                 "Shop Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 20),

                Text(
                 
             "Distance:",//+ widget.locationDetails.distance,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: "grapheinpro-black",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),

             SizedBox(height: 20),

                Text(
             "Duration:",//+widget.duration,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: "grapheinpro-black",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
              ],
            ),
            
          ),
          actions: <Widget>[

            

             
          ],
        );
  }
}