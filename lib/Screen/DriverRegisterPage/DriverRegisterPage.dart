import 'package:canna_drive_main/Form/DriverRegisterForm/DriverRegisterForm.dart';
import 'package:flutter/material.dart';

class DriverRegisterPage extends StatefulWidget {
  @override
  _DriverRegisterPageState createState() => _DriverRegisterPageState();
}

class _DriverRegisterPageState extends State<DriverRegisterPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
             backgroundColor: Color(0xFFFFFFFF),
         appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
  //             leading: Builder(
  //   builder: (BuildContext context) {
  //     return IconButton(
  //       icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
  //       onPressed: () { 
  //         Navigator.of(context).pop();
  //       },
       
  //     );
  //   },
  // ), 
        title: Text(
          'Add Car Details',
          style: TextStyle(
          color:Color(0xFF01d56a),
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
        body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
              child: DriverRegisterForm(),
            ),
          ),
        )
        );
  }
}