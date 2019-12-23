// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boardlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boardlist _$BoardlistFromJson(Map<String, dynamic> json) {
  return Boardlist(
    json['success'] as bool,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BoardlistToJson(Boardlist instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['boards'] as List)
        ?.map((e) =>
            e == null ? null : Boards.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'boards': instance.boards,
    };

Boards _$BoardsFromJson(Map<String, dynamic> json) {
  return Boards(
    json['id'] as int,
    json['name'] as String,
    json['desc'] as String,
    json['dir'] as bool,
    json['first_level'] as bool,
    json['new'] as int,
    (json['children'] as List)
        ?.map((e) =>
            e == null ? null : Children.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['fav'] as bool,
  );
}

Map<String, dynamic> _$BoardsToJson(Boards instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'dir': instance.dir,
      'first_level': instance.firstLevel,
      'new': instance.notice,
      'children': instance.children,
      'offset': instance.offset,
      'fav': instance.fav,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) {
  return Children(
    json['id'] as String,
    json['name'] as String,
    json['desc'] as String,
    json['dir'] as bool,
    json['first_level'] as bool,
    json['new'] as int,
    json['children'] as List,
    json['offset'] as int,
    json['fav'] as bool,
  );
}

Map<String, dynamic> _$ChildrenToJson(Children instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'dir': instance.dir,
      'first_level': instance.firstLevel,
      'new': instance.notice,
      'children': instance.children,
      'offset': instance.offset,
      'fav': instance.fav,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) {
  return Children(
    json['id'],
    json['name'],
    json['desc'],
    json['dir'],
    json['first_level'],
    json['new'],
    json['children'],
    json['offset'],
    json['fav'],
  );
}
