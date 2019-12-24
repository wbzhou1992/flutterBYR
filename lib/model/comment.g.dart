// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['success'] as bool,
    json['data'] == null
        ? null
        : CommentData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return CommentData(
    json['gid'] as int,
    json['anony'] as bool,
    json['reid'] as int,
    json['time'] as String,
    json['title'] as String,
    (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : CommentItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{
      'gid': instance.gid,
      'anony': instance.anony,
      'reid': instance.reid,
      'time': instance.time,
      'title': instance.title,
      'articles': instance.articles,
      'pagination': instance.pagination,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) {
  return CommentItem(
    json['id'] as int,
    json['op'] as bool,
    json['time'] as String,
    json['pos'] as int,
    json['content'] as String,
    json['subject'] as bool,
    json['voted'] as bool,
    json['voteup_count'] as String,
    json['voteddown'] as bool,
    json['votedown_count'] as String,
    json['votedown_min'] as int,
    json['poster'] == null
        ? null
        : CommentUser.fromJson(json['poster'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'op': instance.op,
      'time': instance.time,
      'pos': instance.pos,
      'content': instance.content,
      'subject': instance.subject,
      'voted': instance.voted,
      'voteup_count': instance.voteupCount,
      'voteddown': instance.voteddown,
      'votedown_count': instance.votedownCount,
      'votedown_min': instance.votedownMin,
      'poster': instance.poster,
    };

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) {
  return CommentUser(
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

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
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

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    json['current'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'current': instance.current,
      'total': instance.total,
    };
