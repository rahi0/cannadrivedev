import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/Screen/LogInPage/logInPage.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';

class DriverSubmitPage extends StatelessWidget {
//  final userData;
//  final cannagoData;
//   CannabiEditPage(this.userData, this.cannagoData);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        //backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Submit Cannbis License',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          ),
        
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
                  child: CannabisSubmitForm()
        ),
     
      
    );
  }
}





////////////







class CannabisSubmitForm extends StatefulWidget { 
  @override
  _CannabisSubmitFormState createState() => _CannabisSubmitFormState();
}

class _CannabisSubmitFormState extends State<CannabisSubmitForm>{
  // _showMsg(msg) { //
  //   final snackBar = SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: 'Close',
  //       onPressed: () {
  //         // Some code to undo the change!
  //       },
  //     ),
  //   );
  //   Scaffold.of(context).showSnackBar(snackBar);
  //  }
TextEditingController licenseController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();



  var _months = [
    'Month',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var _currentMonthsSelected = 'Month';

  var _year = ['Year', '1990', '1991', '1992', '1993', '1994', '1995', '1996'];
  var _currentYearSelected = 'Year';

  var _day = [
    'Day',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];
  var _currentDaySelected = 'Day';

  _showMsg(msg) {
    //
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

  bool _isLoading = false;

 

  Container driverRegisterContainer(String label, String field, bool secure,
      TextInputType type, TextEditingController control) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ////////////label///////////
          Container(
            width: MediaQuery.of(context).size.width,
           /// height: 10,
            margin: EdgeInsets.only(left: 15, top: 20, bottom: 15),
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: "grapheinpro-black",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),

          ////////   textfield /////////

                   Padding(
                     padding: const EdgeInsets.only(left: 10, right: 10),
                     child: Container(
                            //width: 350,
                            decoration: BoxDecoration(
                              //color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            height: 40,
                            child: TextField(
                              controller: control,
                              obscureText: secure,
                              keyboardType: type,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Color(0xFFFFFFFF))),
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Color(0xFFFFFFFF))),
                                hintText: "Type here",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontFamily: "sourcesanspro",
                                    fontWeight: FontWeight.w300),
                                contentPadding:
                                    EdgeInsets.only(left: 20, bottom: 12, top: 12),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                              ),
                            ),
                          ),
                   ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        alignment: Alignment.center,
              //color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            driverRegisterContainer("License Number", "Type here", false,
                TextInputType.number, licenseController),

            ///////Dob//////
              Container(
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                //color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      //height: 30,
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        "License Expiration Date",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "grapheinpro-black",
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /////////// day dropdown ///////
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 35,
                            height: 40,
                            margin: EdgeInsets.only(top: 10, right: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: _day.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontFamily: "sourcesanspro",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  _dropDownDaySelected(newValueSelected);
                                },
                                value: _currentDaySelected,
                              ),
                            ),
                          ),
                          /////////// month dropdown ///////
                          Container(
                            width: MediaQuery.of(context).size.width / 3 -2,
                            height: 40,
                            margin: EdgeInsets.only(top: 10, right: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: _months.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontFamily: "sourcesanspro",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  _dropDownMonthSelected(newValueSelected);
                                },
                                value: _currentMonthsSelected,
                              ),
                            ),
                          ),

                          /////////// year dropdown ///////
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 30,
                            height: 40,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: _year.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontFamily: "sourcesanspro",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  _dropDownYearSelected(newValueSelected);
                                },
                                value: _currentYearSelected,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              ///////Dob end/////
            

            driverRegisterContainer("Car Brand", "Type here", false,
                TextInputType.text, brandController),
            driverRegisterContainer("Car Model", "Type here", false,
                TextInputType.text, modelController),
            driverRegisterContainer("Car Color", "Type here", false,
                TextInputType.text, colorController),
            driverRegisterContainer("Car Plate Number", "Type here", false,
                TextInputType.text, plateNumberController),
            driverRegisterContainer("Car Insurance", "Type here", false,
                TextInputType.number, insuranceController),

            Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 140,
                    // height: 30,
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                       // Navigator.pop(context);
                                 Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => LogIn()
                          ));
                      },
                      child: Text(
                        "Back",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "grapheinpro-black",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //    color: Color(0xFF01D56A)
                    // ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                      color: Color(0xFF01D56A),
                      disabledColor: Colors.grey,
                      //                     onPressed: (){
                      //                        Navigator.push(
                      // context,
                      // new MaterialPageRoute(
                      //     builder: (context) => Home()));
                      //                     },

                      onPressed: _isLoading ? null : _handleLogin,

                      child: Text(
                        _isLoading ? "Please wait..." : "Submit"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {

     SharedPreferences localStorage = await SharedPreferences.getInstance();

       var userJson = localStorage.getString('user');
   
    var userData = json.decode(userJson);
   
    //print('${userData['id']}');

    if (licenseController.text.isEmpty) {
      return _showMsg("License Number is empty");

    }
    
      else if( _currentDaySelected =='Day'){
        return _showMsg( "Day is empty");
      }
      else if(_currentMonthsSelected=='Month'){
        return _showMsg("Month is empty");
      }
      else if( _currentYearSelected=="Year"){
        return _showMsg("Year is empty");
      }

     else if (brandController.text.isEmpty) {
      return _showMsg("Car Brand Field is empty");
    } else if (modelController.text.isEmpty) {
      return _showMsg("Car Model is empty");
    } 
    else if (colorController.text.isEmpty) {
      return _showMsg("Car Color is empty");
    } 
    else if (plateNumberController.text.isEmpty) {
      return _showMsg("Car Plate Number is empty");
    }  
    else if (insuranceController.text.isEmpty) {
      return _showMsg("Car Insurance Number is empty");
    } 
    setState(() {
      _isLoading = true;
    });

    var data = {
      'userId': '${userData['id']}' ,
      'license': licenseController.text,
      'licenseExpiration': _currentDaySelected +
          '-' +
          _currentMonthsSelected +
          '-' +
          _currentYearSelected,
      'carBrand': brandController.text,
      'carModel': modelController.text,
      'carColor': colorController.text,
      'carPlateNumber': plateNumberController.text,
      'carInsurance': insuranceController.text
      
    };

    var res = await CallApi().postData(data, 'auth/registerDrive');
    var body = json.decode(res.body);
    print(body);
   

    if (body['success']) {
     
      // localStorage.setString('token', body['token']);
      // localStorage.setString('user', json.encode(body['user']));
      localStorage.setString('cannadrive', json.encode(body['cannadrive']));

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Navigation()));
    }
   else{
      _showMsg(body['message']);
    }


    setState(() {
      _isLoading = false;
    });
  }


  void _dropDownMonthSelected(String newValueSelected) {
    setState(() {
      this._currentMonthsSelected = newValueSelected;
    });
  }

  void _dropDownYearSelected(String newValueSelected) {
    setState(() {
      this._currentYearSelected = newValueSelected;
    });
  }

  void _dropDownDaySelected(String newValueSelected) {
    setState(() {
      this._currentDaySelected = newValueSelected;
    });
  }
}