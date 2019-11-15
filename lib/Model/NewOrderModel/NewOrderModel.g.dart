// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderModel _$NewOrderModelFromJson(Map<String, dynamic> json) {
  return NewOrderModel((json['orders'] as List)
      ?.map(
          (e) => e == null ? null : Orders.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$NewOrderModelToJson(NewOrderModel instance) =>
    <String, dynamic>{'orders': instance.orders};

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return Orders(
      json['id'],
      json['status'],
      (json['orderdetails'] as List)
          ?.map((e) => e == null
              ? null
              : Orderdetails.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['buyer'] == null
          ? null
          : Buyer.fromJson(json['buyer'] as Map<String, dynamic>),
      json['seller'] == null
          ? null
          : Seller.fromJson(json['seller'] as Map<String, dynamic>));
}

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'orderdetails': instance.orderdetails,
      'buyer': instance.buyer,
      'seller': instance.seller
    };

Orderdetails _$OrderdetailsFromJson(Map<String, dynamic> json) {
  return Orderdetails(
      json['id'],
      json['orderId'],
      json['itemId'],
      json['quantity'],
      json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>));
}

Map<String, dynamic> _$OrderdetailsToJson(Orderdetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'item': instance.item
    };

Buyer _$BuyerFromJson(Map<String, dynamic> json) {
  return Buyer(
      json['id'],
      json['name'],
      json['delLat'],
      json['delLong'],
      json['delAddress'],
      json['img'],
      json['country'],
      json['email'],
      json['state']);
}

Map<String, dynamic> _$BuyerToJson(Buyer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'delLat': instance.delLat,
      'delLong': instance.delLong,
      'delAddress': instance.delAddress,
      'email': instance.email,
      'img': instance.img,
      'country': instance.country,
      'state': instance.state
    };

Seller _$SellerFromJson(Map<String, dynamic> json) {
  return Seller(
      json['id'],
      json['userId'],
      json['name'],
      json['lat'],
      json['lng'],
      json['address'],
      json['deliveryFee'],
      json['license'],
      json['licenseExpiration']);
}

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'deliveryFee': instance.deliveryFee,
      'license': instance.license,
      'licenseExpiration': instance.licenseExpiration
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      json['id'],
      json['userId'],
      json['name'],
      json['price'],
      json['deliveryFee'],
      json['description'],
      json['eta'],
      json['img'],
      json['productPrice'],
      json['quantity']);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'price': instance.price,
      'img': instance.img,
      'deliveryFee': instance.deliveryFee,
      'productPrice': instance.productPrice,
      'quantity': instance.quantity,
      'description': instance.description,
      'eta': instance.eta
    };
