// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoVoAdapter extends TypeAdapter<ToDoVo> {
  @override
  final int typeId = 1;

  @override
  ToDoVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoVo(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoVo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.context)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoVo _$ToDoVoFromJson(Map<String, dynamic> json) => ToDoVo(
      json['id'] as int?,
      json['title'] as String?,
      json['context'] as String?,
      json['note'] as String?,
      json['date'] as String?,
      json['time'] as String?,
    );

Map<String, dynamic> _$ToDoVoToJson(ToDoVo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'context': instance.context,
      'note': instance.note,
      'date': instance.date,
      'time': instance.time,
    };
