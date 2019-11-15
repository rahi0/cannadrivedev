import 'package:json_annotation/json_annotation.dart';

part 'TotalNotificationModel.g.dart';

@JsonSerializable()
class TotalNotificationModel {
   
  Notification notification;

  TotalNotificationModel(this.notification);

  factory TotalNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$TotalNotificationModelFromJson(json);
}


@JsonSerializable()
class Notification {
  
  var count;

  Notification(this.count);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}

