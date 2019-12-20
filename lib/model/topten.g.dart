// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topten.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topten _$ToptenFromJson(Map<String, dynamic> json) {
  return Topten(
    json['success'] as bool,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ToptenToJson(Topten instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as int,
    json['group_id'] as int,
    json['reply_id'] as int,
    json['flag'] as String,
    json['position'] as int,
    json['is_top'] as bool,
    json['is_subject'] as bool,
    json['is_admin'] as bool,
    json['post_time'] as int,
    json['title'] as String,
    json['content'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['board_name'] as String,
    json['board_description'] as String,
    json['board'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'reply_id': instance.replyId,
      'flag': instance.flag,
      'position': instance.position,
      'is_top': instance.isTop,
      'is_subject': instance.isSubject,
      'is_admin': instance.isAdmin,
      'post_time': instance.postTime,
      'title': instance.title,
      'content': instance.content,
      'user': instance.user,
      'board_name': instance.boardName,
      'board_description': instance.boardDescription,
      'board': instance.board,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['user_name'] as String,
    json['face_url'] as String,
    json['face_width'] as int,
    json['face_height'] as int,
    json['gender'] as String,
    json['astro'] as String,
    json['life'] as int,
    json['qq'] as String,
    json['msn'] as String,
    json['home_page'] as String,
    json['level'] as String,
    json['is_online'] as bool,
    json['post_count'] as int,
    json['last_login_time'] as int,
    json['last_login_ip'] as String,
    json['is_hide'] as bool,
    json['is_register'] as bool,
    json['score'] as int,
    json['follow_num'] as int,
    json['fans_num'] as int,
    json['is_follow'] as bool,
    json['is_fan'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'face_url': instance.faceUrl,
      'face_width': instance.faceWidth,
      'face_height': instance.faceHeight,
      'gender': instance.gender,
      'astro': instance.astro,
      'life': instance.life,
      'qq': instance.qq,
      'msn': instance.msn,
      'home_page': instance.homePage,
      'level': instance.level,
      'is_online': instance.isOnline,
      'post_count': instance.postCount,
      'last_login_time': instance.lastLoginTime,
      'last_login_ip': instance.lastLoginIp,
      'is_hide': instance.isHide,
      'is_register': instance.isRegister,
      'score': instance.score,
      'follow_num': instance.followNum,
      'fans_num': instance.fansNum,
      'is_follow': instance.isFollow,
      'is_fan': instance.isFan,
    };
