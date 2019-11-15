import 'package:canna_drive_main/Form/DriverCommonRegisterForm/DriverCommonRegisterForm.dart';
import 'package:flutter/material.dart';


class DriverCommonRegisterPage extends StatefulWidget {
  @override
  _DriverCommonRegisterPageState createState() => _DriverCommonRegisterPageState();
}

class _DriverCommonRegisterPageState extends State<DriverCommonRegisterPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        body: SafeArea(
                  child: Container(
            margin: EdgeInsets.only(top: 20),
            child: DriverCommonRegisterForm(),
          ),
        )
        );
  }
}
