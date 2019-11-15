import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Model/DriverReviewModel/DriverReviewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_drive_main/main.dart';
import 'package:canna_drive_main/redux/action.dart';
import 'package:canna_drive_main/Screen/SubmitDriverDetails/SubmitDriverDetails.dart';
import 'package:canna_drive_main/CustomPlugin/CustomPlugin/RouteTransition/RouteTransition/routeAnimated.dart';


class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {


bool _isLoading= false;
var review;
var reviewInfo;
 var userData;
  var driverData;
  var avgRate;
  String driver = "";

  @override
  void initState() {
     bottomNavIndex = 2;
       store.dispatch(ConnectionCheck(true));
      _getUserInfo();
    super.initState();
  }

bool _driverIsEmpty=false;

    void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver;
    if (driverJson != null) {
      driver = json.decode(driverJson);
    } else {
      driver = null;
    }

    setState(() {
      userData = user;
    });

    if (driver == null) {
      driver = "No";
      _driverIsEmpty = true;
     
    } else {
      setState(() {
        driverData = driver;
        driver = "Yes";
        _driverIsEmpty = false;

        // print(driverData);
      });
    //  Timer.periodic(Duration(seconds: 5), (timer) {
        // _showOrderRequest();

      //    });
    //  store.state.reviewList.length>0? null : _showReviewData();
      //store.state.isReview==
       store.state.isReview == true? null: _showReviewData();
    }
  }
 Future <void>  _showReviewData() async{

     setState(() {
    
      _isLoading = true;
    });


     var res = await CallApi().getData('app/driverreviews/${driverData['id']}');
    var collection = json.decode(res.body);
    
    var reviewData = DriverReviewModel.fromJson(collection);
 //print(orderPrevious);
  if(!mounted) return;
    setState(() {
        review = reviewData.driverreview;
      _isLoading = false;
    });

    store.dispatch(ReviewList(review.reviews));
    store.dispatch(ClickReview(true));

    review.avgRating==null? store.dispatch(ReviewAverage(0)):store.dispatch(ReviewAverage(review.avgRating.averageRating));
    
  
  }
  @override
  Widget build(BuildContext context) {
    return  
    // _driverIsEmpty? driver == "No"?Scaffold(
    //   backgroundColor: Color(0xFFFFFFFF),
    //   appBar: AppBar(
        
    //      automaticallyImplyLeading: false,
    //     backgroundColor: Colors.greenAccent,
    //     elevation: 0,
    //     title: Text("Review"),
 
    //     ),
    //       body:
    //       /////////////
    //                  Center(
    //                     child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Container(
    //                         padding: EdgeInsets.only(left: 20, right: 20),
    //                         child: Text(
    //                           "Please add your driver details",
    //                           textAlign: TextAlign.justify,
    //                           style: TextStyle(
    //                               color: Color(0xFF000000),
    //                               fontFamily: "grapheinpro-black",
    //                               fontSize: 15,
    //                               fontWeight: FontWeight.w500),
    //                         ),
    //                       ),
    //                       Container(
    //                           decoration: BoxDecoration(
    //                             color: Colors.blue,
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(20.0)),
    //                             gradient: LinearGradient(
    //                               begin: Alignment.centerRight,
    //                               end: Alignment.topLeft,
    //                               stops: [0.1, 0.4, 0.6, 0.9],
    //                               colors: [
    //                                 Colors.greenAccent[400],
    //                                 Colors.greenAccent[400],
    //                                 Colors.tealAccent[400],
    //                                 Colors.tealAccent[700],
    //                               ],
    //                             ),
    //                           ),
    //                           height: 35,
    //                           margin: EdgeInsets.only(top: 25, bottom: 15),
    //                           child: OutlineButton(
    //                               color: Colors.greenAccent[400],
    //                               child: new Text(
    //                                 "Add Car Details",
    //                                 style: TextStyle(color: Colors.white),
    //                               ),
    //                               onPressed: () {
                                   
    //                                    Navigator.push(context, SlideLeftRoute(page: SubmitDriverDetails()));
    //                               },
    //                               borderSide:
    //                                   BorderSide(color: Colors.green, width: 0.5),
    //                               shape: new RoundedRectangleBorder(
    //                                   borderRadius:
    //                                       new BorderRadius.circular(20.0))))
    //                     ],
    //                   ))
                      ////////////////
                      // ):
                      // Container():
                      Scaffold(
        body:  
       _driverIsEmpty ||  driver == "No"? 
         Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "Please add your driver details",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.topLeft,
                                  stops: [0.1, 0.4, 0.6, 0.9],
                                  colors: [
                                    Colors.greenAccent[400],
                                    Colors.greenAccent[400],
                                    Colors.tealAccent[400],
                                    Colors.tealAccent[700],
                                  ],
                                ),
                              ),
                              height: 35,
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              child: OutlineButton(
                                  color: Colors.greenAccent[400],
                                  child: new Text(
                                    "Add Car Details",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    
                                       Navigator.push(context, SlideLeftRoute(page: SubmitDriverDetails()));
                                  },
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 0.5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))
                        ],
                      )):
                 _isLoading?  Center(child:  CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),):
                  Container( 
                    
          color:Color(0xFFFFFFFF),
          child: NestedScrollView( 
              physics: const AlwaysScrollableScrollPhysics(),
                            headerSliverBuilder:
                                (BuildContext context, bool innerBoxIsScrolled) {
                              return <Widget>[
                                  
                                //    Column(
                                //   children: 
                                //   _showReviewTopBar()
                                // )
                                ShopPageTopBar(userData)

                              ];
                            },
                            body: 
                           // review.reviews.length < 1
                         RefreshIndicator(
                    onRefresh: _showReviewData,
                    child:  store.state.reviewList.length<1
                      ? Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                       
                                child: Text("There is no Review",
                                  style: TextStyle(fontSize: 18),),
                                // decoration: new BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     image: new DecorationImage(
                                //       fit: BoxFit.fill,
                                //       image:
                                //           new AssetImage('assets/images/noproduct.png'),
                                //     ))
                                ),
                            ),
                             ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                 )
                          ],
                        )
                      :
                      SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(), 
                                child: Container(
                                    color: Color(0xFFFFFFFF),
                                    //margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                                    child: Column(
                            children: <Widget>[

                                Column(
                                  children: 
                                  _showReview()
                                ),
                                ],
                                    ),
                                  ),
                                ),
        ),
        )
                  ),
      
    );
  }

  List<Widget> _showReview() {

    List<Widget> list = [];
   // var index = 0;
   var rating;
    for (var d in store.state.reviewList) {

        if(d == null){
        rating = 0;
       // return;
      } 
       if(d.rating is int){
      rating = d.rating.toDouble();
    
    
    }
    else{
       rating =d.rating;
    }
      list.add(
       ReviewCard(d,rating),
        
      );
    }

    return list;
  }


  
}







///////Top bar/////


class ShopPageTopBar extends StatefulWidget {

  var data;
//  var reviewNumber;
  ShopPageTopBar(this.data);
  @override
  _ShopPageTopBarState createState() => _ShopPageTopBarState();
}


const kExpandedHeight = 180.0;
class _ShopPageTopBarState extends State<ShopPageTopBar> {
  ScrollController _scrollController;
  String ratingText="";

    @override
  void initState() {
    super.initState();

  
    print(store.state.averageRate);
   // print("data");
//print(widget.reviewNumber.reviews.length);

 bottomNavIndex = 3;
    _scrollController = ScrollController()
      ..addListener(() => setState(() {}));

      _showtext();
  }

  bool get _showTitle {
    return _scrollController.hasClients
        && _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }
  void _showtext(){
      if(store.state.averageRate==0){//} widget.reviewNumber.avgRating==null){
        ratingText = "No Rating Yet";
      }
     
   //   else if( widget.reviewNumber.avgRating.averageRating<=2.00){
       else if(store.state.averageRate <=2.00){
          ratingText = "Poor";
      }
      else if( store.state.averageRate <=3.00){
        ratingText = "Average";
      }
      else if( store.state.averageRate <=4.00){
        ratingText = "Good";
      }
      else if(store.state.averageRate <=5.00){
        ratingText = "Excellent";
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverAppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
            color: Color(0xFF01D56A)
          ),
        backgroundColor: Colors.white,
        expandedHeight: 180.0,
        //floating: false,
        pinned: true,
        centerTitle: true,
        title:  Container(
                        //color: Colors.red,
                      //  width: 200,
                        alignment: Alignment.center,
                        child: Text(
                          widget.data != null ? '${  widget.data['name']}' : '',
                       //  widget.data.user.name==null?"":widget.data.user.name,
                                     //overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color:  Color(0xFF01D56A).withOpacity(0.8),
                                      fontSize: 25.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'sourcesanspro',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                      ),
        flexibleSpace: new FlexibleSpaceBar(

            ////////////////////Collapsed Bar/////////////////
            background: Container(
          child: Stack(
            children: <Widget>[
              Container(
                //constraints: new BoxConstraints.expand(height: 256.0, ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('assets/images/car.jpg'), // widget.data == null?AssetImage('assets/images/nen.jpg'):NetworkImage("https://dynamyk.co"+widget.data['img']),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomRight,
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ///////// Shop Name //////////
                     
                      //////// Shop Name end/////////
                      

                      /////// Open Close start //////////
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5,right: 10),
                        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.white
                          )
                        ),
                        child: Text(
                                     ratingText,
                                     //overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'sourcesanspro',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                      ),
                      ////// Open Close  end/////////
                      

                      ///////// rating start //////////
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: <Widget>[
                            Icon(Icons.star,size: 15, color:  Color(0xFFffa900),),

                            Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          //"o",
                                    '${store.state.averageRate}'== 0?"0":store.state.averageRate.toString(),
                                     //overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'sourcesanspro',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                      ),



                      Container(
                        child: Text(
                                  //   widget.reviewNumber.reviews==null?"(0)":"(${widget.reviewNumber.reviews.length})",
                                      store.state.reviewList==null?"(0)":"(${store.state.reviewList.length})",
                                     //overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'sourcesanspro',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                      ),
                          ],
                        ),
                      ),
                      //////// rating end/////////////
                    ],
                  ),
                ),
              )
            ],
          ),
        )

            ////////////////////Collapsed Bar  End/////////////////

            ),
      ),
    );
  }
}






//////////Body//////



class ReviewCard extends StatefulWidget {

  var data;
  var ratedata;
  ReviewCard(this.data,this.ratedata);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

   @override
  void initState() {
   // print(widget.orderedItem.seller.profile.name);
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 0.2,
                margin: EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                   
                   decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:  BorderRadius.circular(20),
                             boxShadow:[
                               BoxShadow(color:Colors.grey[200],
                               blurRadius: 16.0,
                               // offset: Offset(0.0,3.0)
                                )
                             
                             ],
                          ),
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

            ////////////////Pic Name Price Slide Section Start////////////
                      Container(
                          //color: Colors.red,
                         
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             
                              /////////// item image/////////
                             
                              Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(right: 10),
                            decoration: new BoxDecoration(
                                      color: Colors.green,
                                       shape: BoxShape.circle,
                                       image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        
                                        image:widget.data.user.img==null? new AssetImage('assets/images/camera.png'):
                                        NetworkImage("https://www.dynamyk.biz"+'${widget.data.user.img}'),
                                        
                                    ),
                                 ),
                               ),
 
                               /////////// item image end/////////

                               ////////////// Details//////////////
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  /////////////   title   /////////////
                                   Container(    
                                      //width: 150,
                                     // color: Colors.green,
                                    //  height: 10,
                                      margin: EdgeInsets.only(top: 10,left: 2,bottom: 4),
                                      child: Text(
                                        //"name",
                                        
                                       widget.data.user.name==null?"":widget.data.user.name,
                                          textAlign: TextAlign.left,
                                         style: TextStyle(
                          color: Color(0xFF343434),
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'MyriadPro',
                          fontWeight: FontWeight.bold,
                        ),
                                              ),
                                            ),

                              ////////////   price    ///////////////
                              Container(
          child:widget.ratedata == null ? 
          Row(
            children: <Widget>[
              SmoothStarRating(
              allowHalfRating: false,
                onRatingChanged: null,
                starCount: 5,
                rating: 0,
                size: 20.0,
                color:   Color(0xFFffa900),
                borderColor: Color(0xF606060),
                spacing:0.0
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 3),
                child: Text(
                  "(0)",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'MyriadPro',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          )
          
         :
          Row(
            children: <Widget>[
              SmoothStarRating(
              allowHalfRating: false,
                onRatingChanged: null,
                starCount: 5,
                rating: widget.ratedata,//widget.item.avgRating.averageRating,
                size: 20.0,
                color: Color(0xFFffa900),
                borderColor: Color(0xFF606060),
                spacing:0.0
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 10, top: 3),
              //   child: Text(
              //   '${ratingData.totalrev.total}'==null?"": "(${ratingData.totalrev.total})",
              //     textDirection: TextDirection.ltr,
              //     style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 15.0,
              //       decoration: TextDecoration.none,
              //       fontFamily: 'MyriadPro',
              //       fontWeight: FontWeight.normal,
              //     ),
              //   ),
              // ),
            ],
          ),
        )
                                      //    Container(
                                      //     //width: 80,
                                      // //color: Colors.green,
                                      //     //margin: EdgeInsets.only(top: 5),
                                      //     child: SmoothStarRating(
                                      //       allowHalfRating: false,
                                      //         onRatingChanged: null,
                                      //         starCount: 5,
                                      //         rating: 6,
                                      //         size: 15.0,
                                      //         color: Colors.yellow[700],
                                      //         borderColor: Colors.green,
                                      //         spacing:0.0
                                      //       ),
                                      //         ),


                                  ///////////  Rating Start ///////////



                             ///////////  Rating End ///////////
                                ],
                              ),
                            )
                            ],
                          ),
                      ),
            ////////////////Pic Name Price Slide Section end////////////
                    
                    //////Comment////
            

            Container(
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 3,left: 40),
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Text(widget.data.content==null?"":widget.data.content,
              textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'MyriadPro',
                    fontWeight: FontWeight.normal,
                  ),
              ),
            )





                    ],
                  ),
                ),
              );
  }
}