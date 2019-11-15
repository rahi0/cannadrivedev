
import 'package:canna_drive_main/redux/action.dart';
import 'package:canna_drive_main/redux/state.dart';


AppState reducer(AppState state, dynamic action){

  if(action is DemoAction){
    return state.copywith(
      demoState: action.demoAction
    );
  }

  if(action is NotificationCountAction){
    return state.copywith(
      notificationCount: action.notificationAction
    );
  }

     if(action is ConnectionCheck){
    return state.copywith(
      connection: action.connectionAction
    );
  }

  
     if(action is OrderList){
    return state.copywith(
      orderList: action.orderList
    );
  }

     if(action is NewOrderList){
    return state.copywith(
      newOrderCount: action.newOrderList
    );
  }

       if(action is NotificationCheck){
  
    return state.copywith(
    notifiCheck: action.notifiCheck
    );
  }

  if(action is NotificationList){
 
    return state.copywith(
    notiList: action.notiList
    );
  }

  if(action is ReviewList){
 
    return state.copywith(
    reviewList: action.reviewList
    );
  }

   if(action is ReviewAverage){
 
    return state.copywith(
    averageRate: action.reviewAverage
    );
  }

    if(action is NotAcceptedList){
 
    return state.copywith(
    newnotAcceptList: action.notAcceptedList
    );
  }
    if(action is AccptedList){
 
    return state.copywith(
    acceptedList: action.accptedList
    );
  }

   if(action is ClickOrder){
 
    return state.copywith(
    isOrder: action.isOrder
    );
  }

   if(action is ClickReview){
 
    return state.copywith(
    isReview: action.isReview
    );
  }
   if(action is ClickHome){
 
    return state.copywith(
    isHome: action.isHome
    );
  }


  return state;
}