import 'package:json_annotation/json_annotation.dart';

part 'NotificationDetailsModel.g.dart';

@JsonSerializable()
class NotificationDetailsModel {
  List<Notification> notification;

  NotificationDetailsModel(this.notification);

  factory NotificationDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailsModelFromJson(json);
}


@JsonSerializable()
class Notification {
  
  var title;
  var msg;
  var seen;
   

  Notification(this.title, this.msg, this.seen);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}

