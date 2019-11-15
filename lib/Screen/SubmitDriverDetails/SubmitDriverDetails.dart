import 'package:canna_drive_main/Form/SubmitDriverDetailsForm/SubmitDriverDetailsForm.dart';
import 'package:flutter/material.dart';

class SubmitDriverDetails extends StatefulWidget {
  @override
  _SubmitDriverDetailsState createState() => _SubmitDriverDetailsState();
}

class _SubmitDriverDetailsState extends State<SubmitDriverDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Color(0xFFFFFFFF),
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
          'Add Driver Details',
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
             
              child: SubmitDriverDetailsForm(),
            ),
          ),
        )
        );
  }
}