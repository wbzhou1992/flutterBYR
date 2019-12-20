// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boardhome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boardhome _$BoardhomeFromJson(Map<String, dynamic> json) {
  return Boardhome(
    json['success'] as bool,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BoardhomeToJson(Boardhome instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['parent'] as int,
    (json['boards'] as List)
        ?.map((e) =>
            e == null ? null : Boards.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'parent': instance.parent,
      'boards': instance.boards,
    };

Boards _$BoardsFromJson(Map<String, dynamic> json) {
  return Boards(
    json['name'] as String,
    json['desc'] as String,
    json['dir'] as bool,
    json['pos'] as int,
    json['new'] as int,
    json['level'] as int,
  );
}

Map<String, dynamic> _$BoardsToJson(Boards instance) => <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'dir': instance.dir,
      'pos': instance.pos,
      'new': instance.notice,
      'level': instance.level,
    };
