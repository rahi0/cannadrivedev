import 'package:json_annotation/json_annotation.dart';

part 'WeeklyDataModel.g.dart';

@JsonSerializable()
class WeeklyDataModel {
   
   var  date;
  var total;
  var year;
  var month;
  var day;

  WeeklyDataModel(this.date, this.total, this.year, this.month, this.day);

  factory WeeklyDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyDataModelFromJson(json);
}


