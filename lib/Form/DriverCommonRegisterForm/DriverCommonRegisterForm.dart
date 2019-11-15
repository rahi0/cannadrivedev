import 'dart:convert';
import 'dart:io';

import 'package:canna_drive_main/API/api.dart';
// import 'package:canna_drive_main/Screen/CountryDetails/CountryDetails.dart';
// import 'package:canna_drive_main/Screen/CountryDetails/CountryModel.dart';
//import 'package:canna_drive_main/ImagePicker/image_picker_handler.dart';
import 'package:canna_drive_main/Screen/DriverRegisterPage/DriverRegisterPage.dart';
import 'package:canna_drive_main/Screen/profileEditPage/profileEditPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class DriverCommonRegisterForm extends StatefulWidget {
  @override
  _DriverCommonRegisterFormState createState() =>
      _DriverCommonRegisterFormState();
}

class _DriverCommonRegisterFormState extends State<DriverCommonRegisterForm>
    with TickerProviderStateMixin
//,ImagePickerListener
{
  //   File _image;
  // AnimationController _controller;
  // ImagePickerHandler imagePicker;
 bool _isImage= false;
  @override
  void initState() {
    state = PhotoCrop.free;
    _getYear();
    super.initState();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    // imagePicker=new ImagePickerHandler(this,_controller);
    // imagePicker.init();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  PhotoCrop state;
  File imageFile;
  String image;
  var imagePath=null;

  List _yr = [];

  void _getYear() {
    _yr.insert(0, 'Year');

    for (var yy = now.year - 60; yy <= now.year + 20; yy++) {
      _yr.add(yy.toString());
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  // Country _selected = Country(
  //     asset: "assets/flags/us_flag.png",
  //     dialingCode: "1",
  //     isoCode: "US",
  //     name: "Select Country");
  //ImagePickerHandler imagePicker;

  var now = new DateTime.now();
  String dayCheck = "";
  String yearCheck = "";
  String monthCheck = "Month";

  _showMsg(msg) {
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

  String nameDriverCountry = "";
  String nameDriverState = "";

  var _drivercountries = ['Country', 'United state america', 'Others'];
  var _drivercurrentCountrySelected = 'Country';

  var _driverstates = ['State', 'California', 'Others'];
  var _drivercurrentStateSelected = 'State';

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
  var _dayThirtyOne = [
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
    '31'
  ];

  var _dayThirty = [
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
    '30'
  ];

  var _dayTwentyEight = [
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
    '28'
  ];

  var _dayTwentyNine = [
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
    '29'
  ];
  var _currentDaySelected = 'Day';

  Container driverCommonRegisterContainer(String label, String field,
      bool secure, TextInputType type, TextEditingController control) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ////////////label///////////
          Container(
            width: MediaQuery.of(context).size.width,
            //height: 10,
            margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                   color: Color(0xFF343434),
                  fontFamily: "sourcesanspro",
                  fontSize: 15, 
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
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
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
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  hintText: "Type here",
                  hintStyle: TextStyle(
                      color: Color(0xFF9b9b9b),
                      fontSize: 15,
                      fontFamily: "sourcesanspro",
                      fontWeight: FontWeight.w400),
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
      // padding: EdgeInsets.only(left: 15, right: 15),

      //  padding: EdgeInsets.only(left: 5, right: 5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ///////////////  image  picker ////////////////

           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isImage? 
      Center(child: CircularProgressIndicator(),):  Center(child: _buildButtonIcon()),
            ),
            SizedBox(height: 5),


            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                driverCommonRegisterContainer("Driver name", "Type here",
                    false, TextInputType.text, nameController),
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                driverCommonRegisterContainer("Email", "Type here", false,
                    TextInputType.emailAddress, mailController),
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                driverCommonRegisterContainer("Password", "Type here", true,
                    TextInputType.text, passwordController),
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                driverCommonRegisterContainer("Confirm Password", "Type here",
                    true, TextInputType.text, confirmPasswordController),

            ////////  Country and State /////////
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 30,
                    margin: EdgeInsets.only(left: 25, top: 20, bottom: 10),
                    child: Text(
                      "Country and State",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                   color: Color(0xFF343434),
                  fontFamily: "sourcesanspro",
                  fontSize: 15, 
                  fontWeight: FontWeight.w500),
                    ),
                  ),

            ////////  country dropdown /////////
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                // Container(
                //     alignment: Alignment.centerLeft,
                //     margin: EdgeInsets.only(left: 20, right: 20),
                //     padding: EdgeInsets.only(left: 10),
                //     width: MediaQuery.of(context).size.width,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       color: Color(0xFFFFFFFF),
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.grey[200],
                //    // offset: Offset(1.0, 2.0),
                //     blurRadius: 14.0,
                //   ),
                // ],
                //     ),
                //     child: CountryPicker(
                //       dense: false,
                //       showFlag: false, //displays flag, true by default
                //       showDialingCode:
                //           false, //displays dialing code, false by default
                //       showName: true, //displays country name, true by default
                //       onChanged: (Country country) {
                //         setState(() {
                //           _selected = country;
                //         });
                //       },
                //       selectedCountry: _selected,
                //     ),
                //   ),


                /// Country ///
                

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Container(
                      //width: 350,
                      margin: EdgeInsets.only(left: 10, right: 10),
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
                      //  height: 40,
                      child: TextField(
                        controller: countryController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type Country",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontFamily: "sourcesanspro",
                              fontWeight: FontWeight.w400),
                          contentPadding:
                              EdgeInsets.only(left: 20, bottom: 10, top: 10),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                        ),
                      ),
                    ),
                  ),

            /////////// state dropdown ///////
            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Container(
                      //width: 350,
                      margin: EdgeInsets.only(left: 10, right: 10),
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
                      //  height: 40,
                      child: TextField(
                        controller: stateController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type State",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontFamily: "sourcesanspro",
                              fontWeight: FontWeight.w400),
                          contentPadding:
                              EdgeInsets.only(left: 20, bottom: 10, top: 10),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                        ),
                      ),
                    ),
                  ),

            ///////Dob//////
            // state == PhotoCrop.picked
            //     ? Container()
            //     :
                 Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
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
                            "Date of Birth",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                   color: Color(0xFF343434),
                  fontFamily: "sourcesanspro",
                  fontSize: 15, 
                  fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              /////////// year dropdown ///////
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                height: 40,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: _yr.map((var dropDownStringItem) {
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
                                                  fontWeight: FontWeight.w400),
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

                              /////////// month dropdown ///////
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 2,
                                height: 40,
                                margin: EdgeInsets.only(top: 10, right: 3),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: _months
                                        .map((String dropDownStringItem) {
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
                                                  fontWeight: FontWeight.w400),
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
                              /////////// day dropdown ///////
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 40,
                                height: 40,
                                margin: EdgeInsets.only(top: 10, right: 3),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: dayCheck == "Twenty Eight"
                                        ? _dayTwentyEight
                                            .map((String dropDownStringItem) {
                                            return DropdownMenuItem<String>(
                                                value: dropDownStringItem,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    dropDownStringItem,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF9b9b9b),
                                                        fontFamily:
                                                            "sourcesanspro",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ));
                                          }).toList()
                                        : dayCheck == "Twenty Nine"
                                            ? _dayTwentyNine.map(
                                                (String dropDownStringItem) {
                                                return DropdownMenuItem<String>(
                                                    value: dropDownStringItem,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        dropDownStringItem,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF9b9b9b),
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ));
                                              }).toList()
                                            : dayCheck == "Thirty One"
                                                ? _dayThirtyOne.map((String
                                                    dropDownStringItem) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value:
                                                            dropDownStringItem,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Text(
                                                            dropDownStringItem,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9b9b9b),
                                                                fontFamily:
                                                                    "sourcesanspro",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ));
                                                  }).toList()
                                                : _dayThirty.map((String
                                                    dropDownStringItem) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value:
                                                            dropDownStringItem,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Text(
                                                            dropDownStringItem,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9b9b9b),
                                                                fontFamily:
                                                                    "sourcesanspro",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

            ///////Dob end/////
            // state == PhotoCrop.picked
            //     ? Container()
            //     :
                 driverCommonRegisterContainer("Phone", "Type here", false,
                    TextInputType.number, phoneController),

            ///////////////////  Back and Next/////////////////

            // state == PhotoCrop.picked
            //     ? Container()
            //     : 
                Container(
                    margin: EdgeInsets.only(
                        top: 30, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // width: 140,
                          // height: 30,
                          margin: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              //               Navigator.push(
                              //  context,
                              //  new MaterialPageRoute(
                              //    builder: (context) => LogIn()
                              //  ));
                            },
                            child: Text(
                              "Back",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
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
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xFF01d56a).withOpacity(0.8),
                            disabledColor: Colors.grey,
                            //                     onPressed: (){
                            //                        Navigator.push(
                            // context,
                            // new MaterialPageRoute(
                            //     builder: (context) => DispensaryRegisterPage()));
                            //                     },

                            onPressed: _isLoading ? null : _handleLogin,
            //               onPressed: (){
            //                 Navigator.push(context,
            // new MaterialPageRoute(builder: (context) => DriverRegisterPage()));
            //               },

                            child: Text(_isLoading ? "Please wait..." : "Next",
                             style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.w500,
                                ),),
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

  //     @override
  // userImage(File _image) {
  //   setState(() {
  //     this._image = _image;
  //   });
  // }

  void _uploadImage() async {

    
    setState(() {
 _isImage = true; 
});

    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      image = base64.encode(imageBytes);
      image = 'data:image/png;base64,' + image;
      var data = {'image': image};

      var res = await CallApi().postData(data, 'app/upload/images');
      var body = json.decode(res.body);
      imagePath = body["image_path"];
      print(body["image_path"]);
      print("body th ");
    } else {
      imagePath = null;
    }

    setState(() {
 _isImage = false; 
});

  }

  void _handleLogin() async {
    if (nameController.text.isEmpty) {
      return _showMsg("Name is empty");
    } else if (mailController.text.isEmpty) {
      return _showMsg("Email is empty");
    } else if (passwordController.text.isEmpty) {
      return _showMsg("Password is empty");
    } else if (passwordController.text != confirmPasswordController.text) {
      return _showMsg("Password doesn't match");
    } else if (countryController.text.isEmpty) {
      return _showMsg("Country is empty");
    } else if (stateController.text.isEmpty) {
      return _showMsg("State is empty");
    } else if (_currentYearSelected == "Year") {
      return _showMsg("Year is empty");
    } else if (_currentMonthsSelected == 'Month') {
      return _showMsg("Month is empty");
    } else if (_currentDaySelected == 'Day') {
      return _showMsg("Day is empty");
    } else if (phoneController.text.isEmpty) {
      return _showMsg("Phone number is empty");
    }
    setState(() {
      _isLoading = true;
    });

    // String base64Image = '';
    // if(_image !=null){
    //   List<int> imageBytes = await _image.readAsBytes();
    //   base64Image = base64Encode(imageBytes);
    // }

    var data = {
      'name': nameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      'img': imagePath,
      'phone': phoneController.text,
      'country': countryController.text,//_selected.name, //_drivercurrentCountrySelected,
      'state': stateController.text, //_drivercurrentStateSelected,
      'birthday': _currentDaySelected +
          '-' +
          _currentMonthsSelected +
          '-' +
          _currentYearSelected,
      'userType': '2',
      'app_Token': "app_Token"
    };

    var res = await CallApi().postData(data, 'auth/register');
    var body = json.decode(res.body);
    print(body);

    if (body['message'].contains("ER_DUP_ENTRY")) {
      _showMsg("Email already exists");
    } else {
      if (body['success'] == true) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => DriverRegisterPage()));
      } else {
        _showMsg(body['message']);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _dropDownMonthSelected(String newValueSelected) {
    setState(() {
      this._currentMonthsSelected = newValueSelected;
      monthCheck = newValueSelected;
      _currentDaySelected = 'Day';

      if (newValueSelected == 'April' ||
          newValueSelected == 'June' ||
          newValueSelected == 'September' ||
          newValueSelected == 'November') {
        dayCheck = "Thirty";
      } else if (newValueSelected == 'February') {
        if ((int.parse(yearCheck) % 4 == 0) &&
            ((int.parse(yearCheck) % 100 != 0) ||
                (int.parse(yearCheck) % 400 == 0))) {
          dayCheck = "Twenty Nine";
        } else {
          dayCheck = "Twenty Eight";
        }
      } else {
        dayCheck = "Thirty One";
      }
    });
  }

  void _dropDownYearSelected(String newValueSelected) {
    setState(() {
      this._currentYearSelected = newValueSelected;
      yearCheck = newValueSelected;
      _dropDownMonthSelected(monthCheck);
    });
  }

  void _dropDownDaySelected(String newValueSelected) {
    setState(() {
      this._currentDaySelected = newValueSelected;
    });
  }

  Widget _buildButtonIcon() {
    if (state == PhotoCrop.free) {
      return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                         border: Border.all(
                            width: 3,
                            color: Color(0xFF01d56a).withOpacity(0.4)),
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/camera.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                  // width: 35,
                  // height: 35,
                  margin: EdgeInsets.only(top: 70, left: 80),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF01D56A),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.photo_camera,
                      color: Color(0xFFFFFFFF),
                    ),
                  )),
            )
          ],
        ),
      );
    }
    // return Icon(Icons.add);
    else if (state == PhotoCrop.picked)
      return Column(
        children: <Widget>[
          imageFile == null
              ? Container(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                    child: Text(
                      'No Image Selected',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'MyriadPro',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                )
              : Stack(
                  children: <Widget>[
                    // Container(
                    //     padding: EdgeInsets.only(top: 100, bottom: 100),
                    //     child: Center(child: CircularProgressIndicator())),
                    // Center(child: Image.file(imageFile)),
                         Container(
                    decoration: BoxDecoration(
                         border: Border.all(
                            width: 3,
                            color: Color(0xFF01d56a).withOpacity(0.4)),
                        shape: BoxShape.circle),
                    child: ClipOval(
                        child: Image.file(
                      imageFile,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    )
                      
                        ),
                  ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

                Container(
                 
              // padding: EdgeInsets.all(8),
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF00aa54).withOpacity(0.8),
                  ),
               margin: EdgeInsets.only(right: 10, top: 10,bottom: 10),
               
                child: IconButton(
                 
                  icon: Icon(Icons.crop, color: Colors.white,),
                  
                  onPressed: (){
                    _cropImage();
                  },
                ),
              ),
            Container(
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF00aa54).withOpacity(0.8),
                  ),
             //  padding: EdgeInsets.all(5),
               margin: EdgeInsets.only(left: 10, top: 10,bottom: 10),
               
                child: IconButton(
                 
                  icon: Icon(Icons.done, color: Colors.white),
                  onPressed: (){

                     _uploadImage();
                      setState(() {
                       state = PhotoCrop.cropped; 
                      });
                  },
                ),
              ),
            ],
          ) 
        ],
      ); //Icon(Icons.crop);
    else if (state == PhotoCrop.cropped) {
      return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Color(0xFF01d56a).withOpacity(0.4)),
                        shape: BoxShape.circle),
                    child: ClipOval(
                        child: Image.file(
                      imageFile,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    )
                      
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                  // width: 35,
                  // height: 35,
               margin: EdgeInsets.only(top: 70, left: 80),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF01D56A),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.photo_camera,
                      color: Color(0xFFFFFFFF),
                    ),
                  )),
            )
          ],
        ),
      );
    } // imageFile != null ? Image.file(imageFile) : Container(); //Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if (imageFile != null) {
      setState(() {
        state = PhotoCrop.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        // state = PhotoCrop.free;
        state = PhotoCrop.cropped;
      });
    }

    _uploadImage();
  }
}
