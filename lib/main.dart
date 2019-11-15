import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:canna_drive_main/BottomNavigation/app.dart';
import 'package:canna_drive_main/Screen/LogInPage/logInPage.dart';
import 'package:canna_drive_main/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'redux/reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';

int index = 0;

void main() => runApp(MyApp());

final store = Store<AppState>(reducer, 
initialState: AppState(demoState: "Welcome",notificationCount:0, connection: true,
              orderList: [],
              newOrderCount: 0,
               notifiCheck: true,
              notiList: [],
              reviewList:[],
              averageRate :0,
              newnotAcceptList: [],
              acceptedList: [],
              isOrder: false,
              isReview: false,
              isHome: false
              ), 
middleware: [thunkMiddleware]);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
   bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
      // check if token is there
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token!= null){
         setState(() {
            _isLoggedIn = true;
         });
      }
  }
  @override
  Widget build(BuildContext context) {


    // return  MaterialApp(
    //   home: Scaffold(
    //     body: Text("Hlw")
    //    )
    //   );
    

    return 
     StoreProvider<AppState>(
          store: store,
          child: 
          MaterialApp(
          debugShowCheckedModeBanner: false,
          home://DriveMap()
            _isLoggedIn?
            StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, items) =>  Navigation())  : LogIn())
       
    );
      
   
  }
}



