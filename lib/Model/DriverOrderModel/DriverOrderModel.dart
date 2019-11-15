import 'package:json_annotation/json_annotation.dart';

part 'DriverOrderModel.g.dart';

@JsonSerializable()
class DriverOrderModel {
  List<Orders> order;

  DriverOrderModel(this.order);

  factory DriverOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderModelFromJson(json);
}


@JsonSerializable()
class Orders {
  
  var id;
  var status; 
  List<Orderdetails> orderdetails;
  Buyer buyer;
  Seller seller;

   

  Orders(this.id, this.status, this.orderdetails, this.buyer, this.seller);

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
}



@JsonSerializable()
class Orderdetails {
  
  var id;
  var orderId;
  var itemId;
  var quantity; 
  Item item;
  Orderdetails(this.id,this.orderId, this.itemId, this.quantity, this.item);

  factory Orderdetails.fromJson(Map<String, dynamic> json) => _$OrderdetailsFromJson(json);
}



@JsonSerializable()
class Buyer {


  var id;
  var name;
  var delLat;
  var delLong;
  var delAddress;
  var email;
  var img;
  var country;
  var state;
 
  Buyer(this.id, this.name, this.delLat, this.delLong,this.delAddress,this.img, this.country, this.email, this.state);

  factory Buyer.fromJson(Map<String, dynamic> json) => _$BuyerFromJson(json);
}



@JsonSerializable()
class Seller {
  
  var id;
  var userId;
  var name;
  var lat;
  var lng;
  var address;
  var deliveryFee;
  var license;
  var licenseExpiration;
  Seller(this.id, this.userId, this.name, this.lat, this.lng,this.address, this.deliveryFee, this.license, this.licenseExpiration);
  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@JsonSerializable()
class Item {
  
 var id;
  var userId;
  var name;
  var price;
  var img;
  var deliveryFee;
  var productPrice;
  var quantity;
  var description;
  var eta;

  Item(this.id,this.userId,this.name, this.price,this.deliveryFee, this.description, this.eta, this.img, this.productPrice, this.quantity);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}