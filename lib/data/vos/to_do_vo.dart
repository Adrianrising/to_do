
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../constant/hive_constant.dart';
part 'to_do_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: kToDoType)
class ToDoVo{
  @JsonKey(name: 'id')
  @HiveField(0)
  int ? id;

  @JsonKey(name: 'title')
  @HiveField(1)
  String ? title;

  @JsonKey(name: 'context')
  @HiveField(2)
  String ? context;

  @JsonKey(name: 'note')
  @HiveField(3)
  String ? note;

  @JsonKey(name: 'date')
  @HiveField(4)
  String ? date;

  @JsonKey(name: 'time')
  @HiveField(5)
  String ? time;


  ToDoVo(this.id, this.title, this.context, this.note, this.date, this.time);

  factory ToDoVo.fromJson(Map<String,dynamic>json)=>_$ToDoVoFromJson(json);
  Map<String,dynamic>toJson()=>_$ToDoVoToJson(this);
}