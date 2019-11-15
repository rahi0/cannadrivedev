import 'package:json_annotation/json_annotation.dart';

part 'DriverReviewModel.g.dart';

@JsonSerializable()
class DriverReviewModel {
  Driverreview driverreview;

  DriverReviewModel(this.driverreview);

  factory DriverReviewModel.fromJson(Map<String, dynamic> json) =>
      _$DriverReviewModelFromJson(json);
}


@JsonSerializable()
class Driverreview {
 
 dynamic id;
 dynamic userId;
 dynamic lat;
 dynamic lng;
 dynamic license;
 dynamic licenseExpiration;
 List<Reviews> reviews;
 AvgRating avgRating;

  Driverreview(this.id,this.userId, this.lat, this.lng, this.license, this.licenseExpiration, this.reviews, this.avgRating);

  factory Driverreview.fromJson(Map<String, dynamic> json) =>
      _$DriverreviewFromJson(json);
}

@JsonSerializable()
class Reviews {
 
 dynamic id;
 dynamic userId;
 dynamic rating;
 dynamic content;
 User user;


  Reviews(this.id,this.userId,this.rating, this.content, this.user);

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
}

@JsonSerializable()
class User {
 
 dynamic id;
 dynamic delLat;
 dynamic delLong;
 dynamic delAddress;
 dynamic email;
 dynamic name;
 dynamic img;
 dynamic country;
 dynamic state;
 dynamic phone;
 dynamic userType;


  User(this.id,this.delLat, this.delLong, this.delAddress, this.email, this.name, this.img, this.country, this.state, this.phone, this.userType);

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}

@JsonSerializable()
class AvgRating {
 
 dynamic driverId;
 dynamic averageRating;



  AvgRating(this.driverId, this.averageRating);

  factory AvgRating.fromJson(Map<String, dynamic> json) =>
      _$AvgRatingFromJson(json);
}


