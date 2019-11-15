import 'dart:convert';
import 'dart:io';
import 'package:canna_drive_main/Form/LogInForm/logInForm.dart';
// import 'package:canna_drive_main/Screen/CountryDetails/CountryDetails.dart';
// import 'package:canna_drive_main/Screen/CountryDetails/CountryModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileEditPage extends StatelessWidget {
  final userData;
  final driverData;
  ProfileEditPage(this.userData, this.driverData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.grey[200],
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
          'Edit Profile',
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

      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(child: ProfileEditForm(userData, driverData)),
    );
  }
}

////////////

class ProfileEditForm extends StatefulWidget {
  final userData;
  final cannagoData;
  ProfileEditForm(this.userData, this.cannagoData);

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

String image;
var imagePath;
bool _isImage = false;

enum PhotoCrop {
  free,
  picked,
  cropped,
}

class _ProfileEditFormState extends State<ProfileEditForm>
    with TickerProviderStateMixin
//, ImagePickerListener
{
  TextEditingController nameController;
  TextEditingController userNameController;
  TextEditingController cannabisController;
  TextEditingController countryController;
  TextEditingController stateController;
  TextEditingController countyController;
  TextEditingController emailController;
  TextEditingController passWordController;
  TextEditingController confirmPassWordController;
  TextEditingController phoneController;
  TextEditingController dateController;

  String date;

  DateTime selectedDate = DateTime.now();
  var format;

  String countryName;

  // Country _selected = Country(
  //     asset: "assets/flags/us_flag.png",
  //     dialingCode: "1",
  //     isoCode: "US",
  //     name: "Select Country");

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

  PhotoCrop state;
  File imageFile;

  ///////Image

  // File _image;
  // AnimationController _controller;
  // ImagePickerHandler imagePicker;
  // ImagePickerListener listener;

  @override
  void initState() {
    state = PhotoCrop.free;
    _getUserInfo();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    // imagePicker = new ImagePickerHandler(this, _controller);
    // imagePicker.init();
    super.initState();
  }

  // SOME INITIAL VALUES
  bool _isLoading = false;

  void _getUserInfo() {
    nameController = TextEditingController(
        text:
            '${widget.userData['name'] == null ? '' : widget.userData['name']}');
    // userNameController = TextEditingController(
    //     text:
    //         '${widget.userData['lastName'] == null ? '' : widget.userData['lastName']}');
    countryController = TextEditingController(
        text:
            '${widget.userData['country'] == null ? '' : widget.userData['country']}');

    stateController = TextEditingController(
        text:
            '${widget.userData['state'] == null ? '' : widget.userData['state']}');

    countyController = TextEditingController(
        text:
            '${widget.userData['county'] == null ? '' : widget.userData['county']}');

    countryName =
        '${widget.userData['county'] == null ? '' : widget.userData['county']}';

    emailController = TextEditingController(
        text:
            '${widget.userData['name'] == null ? '' : widget.userData['email']}');

    passWordController = TextEditingController(
        text:
            '${widget.userData['password'] == null ? '' : widget.userData['password']}');

    phoneController = TextEditingController(
        text:
            '${widget.userData['phone'] == null ? '' : widget.userData['phone']}');

    dateController = TextEditingController(
        text:
            '${widget.userData['birthday'] == null ? '' : widget.userData['birthday']}');

    date =
        '${widget.userData['birthday'] == null ? '' : widget.userData['birthday']}';

    // _selected = Country(
    //     asset: "assets/flags/us_flag.png",
    //     dialingCode: "1",
    //     isoCode: "US",
    //     name: countryController.text);

    imagePath = '${widget.userData['img']}';
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  //////

  Container profileContainer(String label, TextEditingController controller,
      bool obscure, String text, TextInputType type) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 10, right: 20),
      padding: EdgeInsets.only(left: 0, right: 10),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            margin: EdgeInsets.only(left: 25),
            //color: Colors.blue,
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
              height: 40,
              child: TextField(
                controller: controller,
                obscureText: obscure,
                keyboardType: type,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontFamily: "sourcesanspro",
                    fontWeight: FontWeight.normal),
                cursorColor: Color(0xFF9b9b9b),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                  hintText: text,
                  hintStyle: TextStyle(
                      color: Colors.grey[600],
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
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///////////////  image  picker ////////////////
          _isImage
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(child: _buildButtonIcon()),
          SizedBox(height: 10),
        

          ///////////// Form Start //////////

          /////////// name field //////
          //  state == PhotoCrop.picked? Container():
          profileContainer(
              "Name",
              nameController,
              false,
              widget.userData['name'] != null
                  ? '${widget.userData['name']}'
                  : '',
              TextInputType.text),
       

          // //state == PhotoCrop.picked? Container():
          // Container(
          //   margin: EdgeInsets.only(top: 5, bottom: 10),
          //   padding: EdgeInsets.only(left: 0, right: 10),
          //   // color: Colors.red,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       ////////  name /////////
          //       Container(
          //         width: MediaQuery.of(context).size.width / 3 - 30,
          //         margin: EdgeInsets.only(left: 25),
          //         //color: Colors.blue,
          //         child: Text(
          //           "Country",
          //           textAlign: TextAlign.left,
          //           style: TextStyle(
          //               color: Color(0xFF343434),
          //               fontFamily: "sourcesanspro",
          //               fontSize: 15,
          //               fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           margin: EdgeInsets.only(right: 20),
          //           alignment: Alignment.centerLeft,
          //           padding: EdgeInsets.only(left: 10),
          //           height: 40,
          //           decoration: BoxDecoration(
          //             color: Color(0xFFFFFFFF),
          //             borderRadius: BorderRadius.circular(20),
          //             boxShadow: <BoxShadow>[
          //               BoxShadow(
          //                 color: Colors.grey[200],
          //                 // offset: Offset(1.0, 2.0),
          //                 blurRadius: 14.0,
          //               ),
          //             ],
          //           ),
          //           child: CountryPicker(
          //             dense: false,
          //             showFlag: false, //displays flag, true by default
          //             showDialingCode:
          //                 false, //displays dialing code, false by default
          //             showName: true, //displays country name, true by default
          //             onChanged: (Country country) {
          //               setState(() {
          //                 _selected = country;
          //               });
          //             },
          //             selectedCountry: _selected,
          //           ),
          //         ),
          //       ),
          //       ////////  name textfield /////////
          //     ],
          //   ),
          // ),

          // state == PhotoCrop.picked? Container():

           profileContainer(
              "Country",
              countryController,
              false,
              widget.userData != null ? '${widget.userData['country']}' : '',
              TextInputType.text),
          profileContainer(
              "State",
              stateController,
              false,
              widget.userData != null ? '${widget.userData['state']}' : '',
              TextInputType.text),
          //profileContainer("County", countyController, false, widget.userData['county']!= null ? '${widget.userData['county']}' : ''),
          //profileContainer("Email", emailController, false, widget.userData!= null ? '${widget.userData['email']}' : ''),
          // profileContainer( "Password",passWordController, true, widget.userData!= null ? '${widget.userData['password']}' : '',),
          //profileContainer( "Confirm Password", confirmPassWordController, true, widget.userData!= null ? '${widget.userData['password']}' : '',),
          //  state == PhotoCrop.picked? Container():
          profileContainer(
              "Phone",
              phoneController,
              false,
              widget.userData != null ? '${widget.userData['phone']}' : '',
              TextInputType.number),
          // profileContainer("Birth Date", dateController, false, widget.userData!= null ? '${widget.userData['birthday']}' : '',TextInputType.text),

          //  state == PhotoCrop.picked? Container():
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            padding: EdgeInsets.only(left: 0, right: 10),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ////////  name /////////
                Container(
                  width: MediaQuery.of(context).size.width / 3 - 30,
                  margin: EdgeInsets.only(left: 25),
                  //color: Colors.blue,
                  child: Text(
                    "Birth Date",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFF343434),
                        fontFamily: "sourcesanspro",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                ////////  name textfield /////////

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            // widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? date.toString() : '',
                            '${widget.userData['birthday']}' != null
                                ? date.toString()
                                : "",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
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

          /////////////Action BAr///////////////////

          //   state == PhotoCrop.picked? Container():
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
               
                ///////////////// Add to cart Button  Start///////////////

                Container(
                    decoration: BoxDecoration(
                      color: _isLoading
                          ? Colors.grey
                          : Color(0xFF01d56a).withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    //width: 150,
                    height: 42,
                    padding: EdgeInsets.only(left: 8, right: 8),
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
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'MyriadPro',
                                fontWeight: FontWeight.w400,
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
    );
  }

  // @override
  // userImage(File _image) async {
  //   print('userimage is called');
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

      print("imagePath");
      print(imagePath);
    }
// else{
//   imagePath = "";
// }

    setState(() {
      _isImage = false;
    });
  }

  void _saveEditButton() async {
    if (nameController.text.isEmpty) {
      return showMsg(context, "Name is empty");
    }

    else if(countryController.text.isEmpty){
      return showMsg(context,"Country is empty");
    }
    else if (stateController.text.isEmpty) {
      return showMsg(context, "State is empty");
    } else if (phoneController.text.isEmpty) {
      return showMsg(context, "Phone number is empty");
    } else if (date.isEmpty) {
      return showMsg(context, "Day is empty");
    }

    setState(() {
      _isLoading = true;
    });

    // String base64Image = '';
    // if(_image !=null){
    //   List<int> imageBytes = await _image.readAsBytes();
    //   print('base64 image');
    //   base64Image = base64Encode(imageBytes);
    // }
    var data = {
      'id': '${widget.userData['id']}',
      'name': nameController.text,
      'country': countyController.text,//_selected.name,
      'state': stateController.text,
      //'county' : countyController.text,
      'email': '${widget.userData['email']}',
      //'password' : passWordController.text,
      'phone': phoneController.text,
      'birthday': date, //dateController.text,
      'img': imagePath
    };

    print(data);

    var res = await CallApi().postData(data, 'app/userEdit');
    var body = json.decode(res.body);

    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.setString('user', json.encode(body['user']));
      _showDialog('Information has been saved successfully!');
    } else {
      print('user is not updated');
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

  Widget _buildButtonIcon() {
    if (state == PhotoCrop.free) {
      return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 3, color: Color(0xFF01d56a).withOpacity(0.4)),
                      shape: BoxShape.circle),
                  child: ClipOval(
                    child: widget.userData['img'] != null
                        ? Image.network(
                            "https://www.dynamyk.biz" + '${widget.userData['img']}',
                            //  'https://picsum.photos/250?image=9',
                            height: 85,
                            width: 85,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/camera.png',
                            // 'assets/img/camera.png',
                            height: 85,
                            width: 85,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(top: 60, left: 70),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF01D56A),
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    color: Color(0xFFFFFFFF),
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
          Center(
            child: imageFile == null
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 5,
                                color: Color(0xFF01d56a).withOpacity(0.4)),
                            shape: BoxShape.circle),
                        child: ClipOval(
                            child: Image.file(
                          imageFile,
                          height: 85,
                          width: 85,
                          fit: BoxFit.fill,
                        )
                            //  Image.asset(
                            //    imageFile,
                            //  // 'assets/images/nen.jpg',
                            //   height: 85,
                            //   width: 85,
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      ),
                      // Container(

                      //    padding: EdgeInsets.only(top: 100, bottom: 100),
                      //   child: Center(child:CircularProgressIndicator())),
                      //  Center(child: Image.file(imageFile)),
                    ],
                  ),
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
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(
                    Icons.crop,
                    color: Colors.white,
                  ),
                  onPressed: () {
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
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(Icons.done, color: Colors.white),
                  onPressed: () {
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
                      height: 85,
                      width: 85,
                      fit: BoxFit.fill,
                    )
                        //  Image.asset(
                        //    imageFile,
                        //  // 'assets/images/nen.jpg',
                        //   height: 85,
                        //   width: 85,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(top: 60, left: 70),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF01D56A),
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    color: Color(0xFFFFFFFF),
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
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
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
