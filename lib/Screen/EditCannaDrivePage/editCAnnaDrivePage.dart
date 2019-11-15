import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/Form/LogInForm/logInForm.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:intl/intl.dart';

class DriverEditPage extends StatelessWidget {
  final userData;
  final driverData;
  DriverEditPage(this.userData, this.driverData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Edit Car License',
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
      body: SafeArea(
          child: SingleChildScrollView(
              child: DriverEditForm(userData, driverData))),
    );
  }
}

//////

class DriverEditForm extends StatefulWidget {
  final userData;
  var driverData;
  DriverEditForm(this.userData, this.driverData);

  @override
  _DriverEditFormState createState() => _DriverEditFormState();
}

class _DriverEditFormState extends State<DriverEditForm> {
  TextEditingController licenseController;
  TextEditingController licenseExpirationController;
  TextEditingController carBrandController;
  TextEditingController carModelController;
  TextEditingController carColorController;
  TextEditingController carPlateNumberController;
  TextEditingController carInsuranceController;
  TextEditingController codeReferralController;

  String date;

  DateTime selectedDate = DateTime.now();
  var format;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        //  locale: Locale("yyyy-MM-dd"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${DateFormat("yyyy - MMMM - dd").format(selectedDate)}";
      });
  }

  @override
  void initState() {
    _getUserInfo();
    print(widget.driverData);
    super.initState();
  }

  // SOME INITIAL VALUES
  bool _isLoading = false;
  void _getUserInfo() {
    licenseController = TextEditingController(
        text: widget.driverData != null && widget.driverData['license'] != null
            ? '${widget.driverData['license']}'
            : '');

    licenseExpirationController = TextEditingController(
        text: widget.driverData != null &&
                widget.driverData['licenseExpiration'] != null
            ? '${widget.driverData['licenseExpiration']}'
            : '');

    carBrandController = TextEditingController(
        text: widget.driverData != null && widget.driverData['carBrand'] != null
            ? '${widget.driverData['carBrand']}'
            : '');

    carModelController = TextEditingController(
        text: widget.driverData != null && widget.driverData['carModel'] != null
            ? '${widget.driverData['carModel']}'
            : '');

    carColorController = TextEditingController(
        text: widget.driverData != null && widget.driverData['carColor'] != null
            ? '${widget.driverData['carColor']}'
            : '');
    carPlateNumberController = TextEditingController(
        text: widget.driverData != null &&
                widget.driverData['carPlateNumber'] != null
            ? '${widget.driverData['carPlateNumber']}'
            : '');
    carInsuranceController = TextEditingController(
        text: widget.driverData != null &&
                widget.driverData['carInsurance'] != null
            ? '${widget.driverData['carInsurance']}'
            : '');
// codeReferralController = TextEditingController(
//         text:
//             widget.driverData!=null && widget.driverData['codeReferral']!= null ? '${widget.driverData['codeReferral']}' : '');

    date = widget.driverData != null &&
            widget.driverData['licenseExpiration'] != null
        ? '${widget.driverData['licenseExpiration']}'
        : '';
  }

  Container profileContainer(String label, TextEditingController controller,
      bool obscure, String text, TextInputType type) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 2, right: 20),
      padding: EdgeInsets.only(left: 0, right: 10),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: EdgeInsets.only(left: 20),
            //color: Colors.blue,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),

          ////////  name textfield /////////

          Expanded(
            child: Container(
              //width: 350,
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                    // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
              ),
              height: 42,
              child: TextField(
                controller: controller,
                obscureText: obscure,
                keyboardType: type,
                style: TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontFamily: "sourcesanspro",
                    fontWeight: FontWeight.normal),
                cursorColor: Color(0xFF606060),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  hintText: text,
                  hintStyle: TextStyle(
                      color: Color(0xFF606060),
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontFamily: "sourcesanspro",
                      fontWeight: FontWeight.w300),
                  contentPadding:
                      EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 15),
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 5),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///////////// Form Start //////////

            profileContainer(
                "License",
                licenseController,
                false,
                widget.driverData != null &&
                        widget.driverData['license'] != null
                    ? '${widget.driverData['license']}'
                    : '',
                TextInputType.number),

            //  profileContainer("Expiration Date", licenseExpirationController, false, widget.driverData!=null && widget.driverData['licenseExpiration']!= null ? '${widget.driverData['licenseExpiration']}' : '',TextInputType.text),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 3),
              padding: EdgeInsets.only(left: 0, right: 10),
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ////////  name /////////
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    margin: EdgeInsets.only(left: 20),
                    //color: Colors.blue,
                    child: Text(
                      "Expiration Date",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF343434),
                          fontFamily: "sourcesanspro",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  ////////  name textfield /////////

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],
                            // offset: Offset(1.0, 2.0),
                            blurRadius: 14.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              // widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? date.toString() : '',
                              widget.driverData != null ? date.toString() : "",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color(0xFF606060),
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  fontFamily: "sourcesanspro",
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            icon: Icon(Icons.calendar_today),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            profileContainer(
                "Car Brand",
                carBrandController,
                false,
                widget.driverData != null &&
                        widget.driverData['carBrand'] != null
                    ? '${widget.driverData['carBrand']}'
                    : '',
                TextInputType.text),

            profileContainer(
                "Car Model",
                carModelController,
                false,
                widget.driverData != null &&
                        widget.driverData['carModel'] != null
                    ? '${widget.driverData['carModel']}'
                    : '',
                TextInputType.text),

            profileContainer(
                "Car Color",
                carColorController,
                false,
                widget.driverData != null &&
                        widget.driverData['carColor'] != null
                    ? '${widget.driverData['carColor']}'
                    : '',
                TextInputType.text),

            profileContainer(
                "Car Plate Number",
                carPlateNumberController,
                false,
                widget.driverData != null &&
                        widget.driverData['carPlateNumber'] != null
                    ? '${widget.driverData['carPlateNumber']}'
                    : '',
                TextInputType.text),

            profileContainer(
                "Car Insurance",
                carInsuranceController,
                false,
                widget.driverData != null &&
                        widget.driverData['carInsurance'] != null
                    ? '${widget.driverData['carInsurance']}'
                    : '',
                TextInputType.number),

            //profileContainer("Code Referral",codeReferralController, false, widget.driverData!=null && widget.driverData['codeReferral']!= null ? '${widget.driverData['codeReferral']}' : ''),

            /////////////Action BAr///////////////////

            Container(
              width: MediaQuery.of(context).size.width,
              //height: 90,
              padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     //           Navigator.push(
                  //     // context,
                  //     // new MaterialPageRoute(
                  //     //   builder: (context) => Shop()
                  //     // ));
                  //   },
                  //   child: Container(
                  //     //padding: EdgeInsets.only(left: 20),
                  //     child: Text(
                  //       'Back',

                  //       //textDirection: TextDirection.ltr,
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 18.0,
                  //         //  decoration: TextDecoration.underline,
                  //         fontFamily: 'MyriadPro',
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //     //color: Colors.red,
                  //   ),
                  // ),

                  ///////////////// Add to cart Button  Start///////////////

                  Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: _isLoading
                            ? Colors.grey
                            : Color(0xFF01d56a).withOpacity(0.8),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      //width: 150,
                      height: 42,
                      child: FlatButton(
                        onPressed: _isLoading ? null : _saveEditButton,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              _isLoading ? Icons.repeat : Icons.save,
                              color: Colors.black,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                _isLoading ? 'Saving...' : 'Save',
                                //  textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.transparent,
                        // elevation: 4.0,
                        //splashColor: Colors.blueGrey,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )),

                  ///////////////// Add to cart Button  End///////////////
                ],
              ),
            )

            /////////////Action BAr end///////////////////
          ],
        ),
      ),
    );
  }

  void _saveEditButton() async {
    if (licenseController.text.isEmpty) {
      return showMsg(context, "License is empty");
    } else if (date.isEmpty) {
      return showMsg(context, "Date is empty");
    } else if (carBrandController.text.isEmpty) {
      return showMsg(context, "Brand is empty");
    } else if (carModelController.text.isEmpty) {
      return showMsg(context, "Model is empty");
    } else if (carColorController.text.isEmpty) {
      return showMsg(context, "Color is empty");
    } else if (carPlateNumberController.text.isEmpty) {
      return showMsg(context, "Plate Number is empty");
    } else if (carInsuranceController.text.isEmpty) {
      return showMsg(context, "Car Insurance is empty");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'id': '${widget.driverData['id']}',
      'license': licenseController.text,
      'licenseExpiration': date, //licenseExpirationController.text,
      'carBrand': carBrandController.text,
      'carModel': carModelController.text,
      'carColor': carColorController.text,
      'carPlateNumber': carPlateNumberController.text,
      'carInsurance': carInsuranceController.text,
      'codeReferral': '${widget.driverData['codeReferral']}'
    };

    print(data);

    var res = await CallApi().postData(data, 'app/cannadriveEdit');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('cannadrive');
      var editedInfo = json.encode(body['data']);
      localStorage.setString('cannadrive', editedInfo);
      _showDialog('Information has been saved successfully!');
      print(editedInfo);
    } else {
      _showDialog('Something went wrong!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showDialog(msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          content: new Text(
            msg,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              decoration: TextDecoration.none,
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
            ),
          ),
          //content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.push(context, SlideLeftRoute(page: Navigation()));
              },
            ),
          ],
        );
      },
    );
  }
}
