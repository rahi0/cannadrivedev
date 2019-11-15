
import 'package:flutter/material.dart';
import 'package:canna_drive_main/BottomApp/BottomApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';

class AcceptedOrderDetails extends StatefulWidget {

  var data;
  AcceptedOrderDetails(this.data);
  @override
  _AcceptedOrderDetailsPageState createState() => _AcceptedOrderDetailsPageState();
}

class _AcceptedOrderDetailsPageState extends State<AcceptedOrderDetails> {

 var driverData;
 var userData;
  bool _isComplete = false;
  @override
  void initState() {
   _getUserInfo();
    super.initState();
  }

   void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var driverJson = localStorage.getString('cannadrive');
    var user = json.decode(userJson);
    var driver = json.decode(driverJson);
    setState(() {
      userData = user;
      driverData = driver;
     
    });
    // print(userData);
     print(driverData['id']);
  }
  Widget build(BuildContext context) {
    
    return SafeArea(
      top: false,
          child: Scaffold(
        backgroundColor:Color(0xFFFFFFFF),// Colors.grey[300],
        body: Stack(
          children: <Widget>[
            Container(
              child: NestedScrollView( 
                                headerSliverBuilder:
                                    (BuildContext context, bool innerBoxIsScrolled) {
                                  return <Widget>[
                                      
                                       Container(
            child: SliverAppBar(
              iconTheme: IconThemeData(
                  color: Color(0xFF01D56A)
                ),
              backgroundColor: Colors.white,
               automaticallyImplyLeading: false,
              leading:  Container(
        
               alignment: Alignment.center,
                 margin: EdgeInsets.only(left: 10, bottom: 8,top: 8),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(6),
                      color: Colors.white.withOpacity(0.2),
                 ),
               child: IconButton(
                  
               onPressed: (){
                Navigator.of(context).pop();
                   
               },
               icon: Icon(Icons.arrow_back_ios),
                  ),
             ),
              expandedHeight: 200.0,
              //floating: false,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                                           'Order Details',
                                           //overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                             color: Color(0xFF01D56A).withOpacity(0.8),
                                            fontSize: 15.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'sourcesanspro',
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),

                  ////////////////////Collapsed Bar/////////////////
                  background: Container(
                    //constraints: new BoxConstraints.expand(height: 256.0, ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                         image: AssetImage('assets/images/shopBanner.jpg'),
                       //image: widget.data.buyer.img==null?AssetImage('assets/images/camera.png'):NetworkImage("https://dynamyk.co"+'${widget.data.buyer.img}'),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )

                  ////////////////////Collapsed Bar  End/////////////////

                  ),
            ),
      )

                                  ];
                                },
                                body: SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //color: Colors.red,
                                    child: Column(
                                      children: <Widget>[
                                        ////////// Address /////////
                                        Card(
                          elevation: 0.2,
                          margin: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 25),
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        ///////// Status start //////////
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 8),
                              padding: EdgeInsets.fromLTRB(0, 3, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border: Border.all(
                                //   color: widget.data.status=="Completed"?Colors.green[300]: 
                                //             widget.data.status=="Request for Driver"?
                                //             Colors.red[300]:Colors.indigo[300]
                                // )
                              ),
                              child: Row(
                                
                                children: <Widget>[
                                   Text(
                                                    //"name",
                                                    "Order Status: ",
                                                      textAlign: TextAlign.left,
                                                     style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                                                          ),
                                  Text(
                                                widget.data.status=="driver map visible"?"Order is on the way":'${widget.data.status}',
                                               //overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: widget.data.status=="Completed"?Colors.green[300]: 
                                                  Color(0xFFffa900),
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'sourcesanspro',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                ],
                              ),
                            ),
                            //////// Status  end/////////
                            


                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                  ////////////////Order Id start////////////
                                  Container(
                                      //color: Colors.red,
                                     
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                         
                                          /////////// /////////
                                         
                                          Container(    
                                                  child: Text(
                                                    //"name",
                                                    "Order ID: ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                                                          ),
                                                        ),

                                        
                                        Expanded(
                                          child: Container(    
                                             child: Text(
                                               //"name",
                                              '${widget.data.id}' == null
                                        ? ""
                                        : ' ${widget.data.id}',
                                                 textAlign: TextAlign.left,
                                                 style: TextStyle(
                                                           color: Colors.teal,
                                                           fontFamily: "DINPro",
                                                           fontSize: 15,
                                                           fontWeight: FontWeight.normal       
                                                               ),
                                                     ),
                                                   ),
                                        )
                                        ],
                                      ),
                                  ),
                  ////////////////Order Id end////////////
                                
                  

                  ////////////////Store start////////////
                                  Container(
                                      //color: Colors.red,
                                     margin: EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                         
                                          /////////// /////////
                                         
                                          Container(    
                                                  child: Text(
                                                    //"name",
                                                    "Store Name: ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                                                          ),
                                                        ),

                                        
                                        Expanded(
                                          child: Container(    
                                             child: Text(
                                               //"name",
                                              widget.data.seller.name == null
                                        ? ""
                                        : widget.data.seller.name,
                                                 textAlign: TextAlign.left,
                                                style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                                                     ),
                                                   ),
                                        )
                                        ],
                                      ),
                                  ),
                  ////////////////store end////////////
                  


                  ////////////////Buyer start////////////
                                  Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                         
                                          /////////// /////////
                                         
                                          Container(    
                                                  child: Text(
                                                    //"name",
                                                    "Buyer Name: ",
                                                      textAlign: TextAlign.left,
                                                     style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                                                          ),
                                                        ),

                                        
                                        Expanded(
                                          child: Container(    
                                             child: Text(
                                               widget.data.buyer.name == null
                                        ? ""
                                        : widget.data.buyer.name,
                                                 textAlign: TextAlign.left,
                                                style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                                                     ),
                                                   ),
                                        )
                                        ],
                                      ),
                                  ),
                  ////////////////Buyer Id end////////////
                  

                  ////////////////Address start////////////
                                  Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                         
                                          /////////// /////////
                                         
                                          Container(    
                                                  child: Text(
                                                    //"name",
                                                    "Delivery Address: ",
                                                      textAlign: TextAlign.left,
                                                     style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro", 
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                                                          ),
                                                        ),

                                        
                                        Expanded(
                                          child: Container(    
                                             child: Text(
                                               //"name",
                                               widget.data.buyer.delAddress == null
                                        ? ""
                                        :  widget.data.buyer.delAddress,
                                                 textAlign: TextAlign.left,
                                               style: TextStyle(
                      color: Color(0xFF505050), 
                      fontFamily: "sourcesanspro",
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal),
                                                     ),
                                                   ),
                                        )
                                        ],
                                      ),
                                  ),
                  ////////////////Order Id end////////////





                                ],
                              ),
                            ),
                                  

                                      ],
                                    ),
                          ),
                        ),

                        ////////// Address end/////////
                        



                        ////////// Item Details /////////
                         Container(
                           width: MediaQuery.of(context).size.width,
                         padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            decoration: BoxDecoration(
                                     color: Color(0xFFFFFFFF),
                                     borderRadius:  BorderRadius.circular(8),
                                     
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[

                                       
                                        


                                        //////// Title start///////
                                       
                                       Container(
                                               margin: EdgeInsets.only(top: 10),
                                               width: MediaQuery.of(context).size.width,
                                               //color: Colors.red,
                                               child: Text(
                                               "Items",
                                               textAlign: TextAlign.left,
                                               style: TextStyle(
                                                 color: Colors.black,
                                                 fontFamily:"DINPro",
                                                 fontSize: 18,
                                                 fontWeight: FontWeight.bold       
                                                     ),
                                                 ),
                                             ),

                                        //////// Title end///////
                                          

                                          //////// Items start///////
                                       
                                       Container(
                                         width: MediaQuery.of(context).size.width,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:

                                           
                                            _showItemDetails()
                                           
                                         ),
                                       ),

                                        //////// Items end///////

                                       
                                     ],
                                   ),
                         ),

                        ////////// Item Details end/////////
                                      ],
                                    ),

                                  ),
                                ),
            ),
            ),



           widget.data.status=='Completed'?Container():Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){

                     widget.data.status=='Order is on the way'? _sureComplete():null;
                              //  _completeOrder();
                    },
                     child: Container(
                      color:widget.data.status=='Order is on the way'? Color(0xFF00aa54).withOpacity(0.8):Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                                          'Mark as Complete',
                                          
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          
                                          fontFamily: 'MyriadPro',
                                          fontWeight: FontWeight.bold,
                                          ),
                                          ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
void _sureComplete(){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: 
              Text(
                                "Have you completed this order?",
                               // textAlign: TextAlign.,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: "grapheinpro-black",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),

                              content:    Container(
                    height: 70,
                    width: 250,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              width: 110,
                              height: 45,
                              margin: EdgeInsets.only(
                                top: 25,
                                bottom: 15,
                              ),
                              child: OutlineButton(
                                child: new Text(
                                  "No",
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0.5),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              width: 110,
                              height: 45,
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              child: OutlineButton(
                                  color: Colors.greenAccent[400],
                                  child: new Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {

                                     _completeOrder();
                                   
                                  
                                  },
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))
                        ])),
            
        );
        //return SearchAlert(duration);
      },
    );
  }
   void _completeOrder() async {
    
      var data = { 
      'id': '${widget.data.id}',    
      'title': "Completed",
      'body': "${userData['name']} has completed order ${widget.data.id}",
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'  
     
      
    };

    var res = await CallApi().postData(data, 'app/drivrordercomplete');
    var body = json.decode(res.body);
    _isComplete = true;
   

   print(body);
   bottomNavIndex = 0;
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Navigation()));

   
  }

  // _driverReview(){
  //  // Navigator.push(context, SlideLeftRoute(page: ReviewDriverPage(widget.orderedItem)));
  // }


  List<Widget> _showItemDetails(){
     List<Widget> lists = []; 
     for(var d in widget.data.orderdetails){
        lists.add(
          ItemPrice(d)
        );
     }
     return lists;
  }
}





//////



class ItemPrice extends StatefulWidget {

  var data;
  ItemPrice(this.data);
  @override
  _ItemPriceState createState() => _ItemPriceState();
}

class _ItemPriceState extends State<ItemPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            child: Column(
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
    Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 15.0),
      child: ClipOval(
        child: widget.data.item==null || widget.data.item.img==null?Image.asset(
         'assets/images/med_icon.PNG',
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ):Image.network(
         "https://www.dynamyk.biz"+'${ widget.data.item.img}',
           height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
      ),
    ),
    Expanded(
      child: Container(
       // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
              widget.data.item==null ||  widget.data.item.name==null?"Product is not available now":widget.data.item.name,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                color: Colors.black,
                fontFamily:"DINPro",
                fontSize: 16,
                fontWeight: FontWeight.w500      
                    ),
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 4),
              child: 
              Text(
               widget.data.item==null ||  '${widget.data.quantity}'==null?"": "Quantity: "+'${widget.data.quantity}'+'x',
                 textAlign: TextAlign.left,
                 style: TextStyle(
                 color: Colors.teal,
                 fontFamily:"DINPro",
                 fontSize: 15,
                 fontWeight: FontWeight.normal
                 )
              )
            ),
          ],
        ),
      ),
    ),



    Container(
      child: Text(
          widget.data.item==null || '${widget.data.item.price}'==null?"":'\$'+'${(widget.data.item.price).toStringAsFixed(2)}',
             textAlign: TextAlign.left,
             style: TextStyle(
             color: Color(0xFF00bb5d),
             fontFamily:"DINPro",
             fontSize: 15,
             fontWeight: FontWeight.bold       
             ),
           ),
    )
                  ], 
                ),
                
              ],
            ),
          );
  }
  _reviewPrduct(){
   // Navigator.push(context, SlideLeftRoute(page: ReviewPage(widget.d)));
  }


  void _showDialog() {
    // flutter defined function
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              backgroundColor: Colors.white,
              content: new Text(
                "You can only review when the order is completed",
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
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
  }
}


