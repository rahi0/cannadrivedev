// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriverReviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverReviewModel _$DriverReviewModelFromJson(Map<String, dynamic> json) {
  return DriverReviewModel(json['driverreview'] == null
      ? null
      : Driverreview.fromJson(json['driverreview'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DriverReviewModelToJson(DriverReviewModel instance) =>
    <String, dynamic>{'driverreview': instance.driverreview};

Driverreview _$DriverreviewFromJson(Map<String, dynamic> json) {
  return Driverreview(
      json['id'],
      json['userId'],
      json['lat'],
      json['lng'],
      json['license'],
      json['licenseExpiration'],
      (json['reviews'] as List)
          ?.map((e) =>
              e == null ? null : Reviews.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['avgRating'] == null
          ? null
          : AvgRating.fromJson(json['avgRating'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DriverreviewToJson(Driverreview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'lat': instance.lat,
      'lng': instance.lng,
      'license': instance.license,
      'licenseExpiration': instance.licenseExpiration,
      'reviews': instance.reviews,
      'avgRating': instance.avgRating
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) {
  return Reviews(
      json['id'],
      json['userId'],
      json['rating'],
      json['content'],
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'rating': instance.rating,
      'content': instance.content,
      'user': instance.user
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'],
      json['delLat'],
      json['delLong'],
      json['delAddress'],
      json['email'],
      json['name'],
      json['img'],
      json['country'],
      json['state'],
      json['phone'],
      json['userType']);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'delLat': instance.delLat,
      'delLong': instance.delLong,
      'delAddress': instance.delAddress,
      'email': instance.email,
      'name': instance.name,
      'img': instance.img,
      'country': instance.country,
      'state': instance.state,
      'phone': instance.phone,
      'userType': instance.userType
    };

AvgRating _$AvgRatingFromJson(Map<String, dynamic> json) {
  return AvgRating(json['driverId'], json['averageRating']);
}

Map<String, dynamic> _$AvgRatingToJson(AvgRating instance) => <String, dynamic>{
      'driverId': instance.driverId,
      'averageRating': instance.averageRating
    };
