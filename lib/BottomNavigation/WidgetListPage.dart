
import 'package:canna_drive_main/DriveMap/DriveMap.dart';
import 'package:canna_drive_main/Screen/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';

class WidgetListPage extends StatefulWidget {
  WidgetListPage({this.color, this.title});
  final MaterialColor color;
  final String title;

  @override
  _WidgetListPageState createState() => _WidgetListPageState();
}

class _WidgetListPageState extends State<WidgetListPage> {
  var bottomItemIndex;


  final List bottomItemList = [ProfilePage(), DriveMap(), ProfilePage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    if (widget.title == "Home") {
      bottomItemIndex = bottomItemList[0];
    } else if (widget.title == "Request") {
      bottomItemIndex = bottomItemList[1];
    } 
    else if (widget.title == "History") {
      bottomItemIndex = bottomItemList[2];
    }
    else if (widget.title == "Profile") {
      bottomItemIndex = bottomItemList[3];
    }
    return Scaffold(
        body: Container(
     // color: Colors.white,
      child: bottomItemIndex,
    ));
  }
}
