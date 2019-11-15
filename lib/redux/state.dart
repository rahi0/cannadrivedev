


class AppState {
  
  var demoState;
  var notificationCount;
   bool connection;
   List orderList;
   var newOrderCount;
    bool notifiCheck;
  List notiList;
  List reviewList;
  var averageRate;
  var newnotAcceptList;
  List acceptedList;
  bool isOrder;
  bool isReview;
  bool isHome;

  AppState({this.demoState, this.notificationCount,this.connection,this.orderList,this.newOrderCount,this.notifiCheck, this.notiList,
  this.reviewList,this.averageRate,this.newnotAcceptList,this.acceptedList,this.isOrder,this.isReview,this.isHome});

  AppState copywith({demoState,notificationCount,connection,orderList,newOrderCount,notifiCheck,notiList,reviewList,averageRate,
  newnotAcceptList,acceptedList,isOrder,isReview,isHome}) {
    return AppState(
      demoState: demoState ?? this.demoState,
      notificationCount: notificationCount ?? this.notificationCount,
      connection: connection ?? this.connection, 
      orderList:orderList??this.orderList,
      newOrderCount:newOrderCount??this.newOrderCount,
      notiList:notiList??this.notiList,
      notifiCheck: notifiCheck??this.notifiCheck,
      reviewList:reviewList??this.reviewList,
      averageRate:averageRate??this.averageRate,
      newnotAcceptList:newnotAcceptList??this.newnotAcceptList,
      acceptedList:acceptedList??this.acceptedList,
      isOrder:isOrder??this.isOrder,
      isReview:isReview??this.isReview,
      isHome:isHome??this.isHome
    );
  }
}
