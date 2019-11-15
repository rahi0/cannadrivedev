import 'package:json_annotation/json_annotation.dart';

part 'DirectionJson.g.dart';

@JsonSerializable()
class DirectionList {
  List<Routes> routes;
  String status;

  DirectionList(this.routes, this.status);

  factory DirectionList.fromJson(Map<String, dynamic> json) =>
      _$DirectionListFromJson(json);
}

@JsonSerializable()
class Routes {
  String copyrights;
  List<Legs> legs; 
  Overview_polyline overview_polyline;

  Routes(this.copyrights, this.overview_polyline);

  factory Routes.fromJson(Map<String, dynamic> json) => _$RoutesFromJson(json);
}


@JsonSerializable()
class Legs {
  
  Distance distance;
  DurationTime duration;

  Legs(this.distance, this.duration);

  factory Legs.fromJson(Map<String, dynamic> json) => _$LegsFromJson(json);
}

@JsonSerializable()
class Overview_polyline {
  String points;

  Overview_polyline(this.points);

  factory Overview_polyline.fromJson(Map<String, dynamic> json) =>
      _$Overview_polylineFromJson(json);
}


@JsonSerializable()
class Distance {
  String text;

  Distance(this.text);

  factory Distance.fromJson(Map<String, dynamic> json) =>
      _$DistanceFromJson(json);
}

@JsonSerializable()
class DurationTime {
  String text;

  DurationTime(this.text);

  factory DurationTime.fromJson(Map<String, dynamic> json) =>
      _$DurationTimeFromJson(json);
}
