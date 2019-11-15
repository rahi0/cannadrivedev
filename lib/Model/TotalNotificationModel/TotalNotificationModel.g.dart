// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TotalNotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalNotificationModel _$TotalNotificationModelFromJson(
    Map<String, dynamic> json) {
  return TotalNotificationModel(json['notification'] == null
      ? null
      : Notification.fromJson(json['notification'] as Map<String, dynamic>));
}

Map<String, dynamic> _$TotalNotificationModelToJson(
        TotalNotificationModel instance) =>
    <String, dynamic>{'notification': instance.notification};

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(json['count']);
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{'count': instance.count};
