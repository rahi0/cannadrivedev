// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeeklyDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyDataModel _$WeeklyDataModelFromJson(Map<String, dynamic> json) {
  return WeeklyDataModel(
      json['date'], json['total'], json['year'], json['month'], json['day']);
}

Map<String, dynamic> _$WeeklyDataModelToJson(WeeklyDataModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total': instance.total,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day
    };
