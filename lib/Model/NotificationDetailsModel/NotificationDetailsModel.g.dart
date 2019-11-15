// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationDetailsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDetailsModel _$NotificationDetailsModelFromJson(
    Map<String, dynamic> json) {
  return NotificationDetailsModel((json['notification'] as List)
      ?.map((e) =>
          e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$NotificationDetailsModelToJson(
        NotificationDetailsModel instance) =>
    <String, dynamic>{'notification': instance.notification};

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(json['title'], json['msg'], json['seen']);
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'msg': instance.msg,
      'seen': instance.seen
    };
