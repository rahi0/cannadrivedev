// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DirectionJson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionList _$DirectionListFromJson(Map<String, dynamic> json) {
  return DirectionList(
      (json['routes'] as List)
          ?.map((e) =>
              e == null ? null : Routes.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as String);
}

Map<String, dynamic> _$DirectionListToJson(DirectionList instance) =>
    <String, dynamic>{'routes': instance.routes, 'status': instance.status};

Routes _$RoutesFromJson(Map<String, dynamic> json) {
  return Routes(
      json['copyrights'] as String,
      json['overview_polyline'] == null
          ? null
          : Overview_polyline.fromJson(
              json['overview_polyline'] as Map<String, dynamic>))
    ..legs = (json['legs'] as List)
        ?.map(
            (e) => e == null ? null : Legs.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RoutesToJson(Routes instance) => <String, dynamic>{
      'copyrights': instance.copyrights,
      'legs': instance.legs,
      'overview_polyline': instance.overview_polyline
    };

Legs _$LegsFromJson(Map<String, dynamic> json) {
  return Legs(
      json['distance'] == null
          ? null
          : Distance.fromJson(json['distance'] as Map<String, dynamic>),
      json['duration'] == null
          ? null
          : DurationTime.fromJson(json['duration'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LegsToJson(Legs instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration
    };

Overview_polyline _$Overview_polylineFromJson(Map<String, dynamic> json) {
  return Overview_polyline(json['points'] as String);
}

Map<String, dynamic> _$Overview_polylineToJson(Overview_polyline instance) =>
    <String, dynamic>{'points': instance.points};

Distance _$DistanceFromJson(Map<String, dynamic> json) {
  return Distance(json['text'] as String);
}

Map<String, dynamic> _$DistanceToJson(Distance instance) =>
    <String, dynamic>{'text': instance.text};

DurationTime _$DurationTimeFromJson(Map<String, dynamic> json) {
  return DurationTime(json['text'] as String);
}

Map<String, dynamic> _$DurationTimeToJson(DurationTime instance) =>
    <String, dynamic>{'text': instance.text};
