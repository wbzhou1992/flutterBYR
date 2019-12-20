// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['success'] as bool,
    json['data'] == null
        ? null
        : Article.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Postdetail _$PostdetailFromJson(Map<String, dynamic> json) {
  return Postdetail(
    json['gid'] as int,
    json['anony'] as bool,
    json['reid'] as int,
    json['time'] as String,
    json['title'] as String,
    json['board'] == null
        ? null
        : Board.fromJson(json['board'] as Map<String, dynamic>),
    (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['head'] == null
        ? null
        : Head.fromJson(json['head'] as Map<String, dynamic>),
    (json['popularReplies'] as List)
        ?.map((e) => e == null
            ? null
            : PopularReplies.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostdetailToJson(Postdetail instance) =>
    <String, dynamic>{
      'gid': instance.gid,
      'anony': instance.anony,
      'reid': instance.reid,
      'time': instance.time,
      'title': instance.title,
      'board': instance.board,
      'articles': instance.articles,
      'head': instance.head,
      'popularReplies': instance.popularReplies,
      'pagination': instance.pagination,
    };

Board _$BoardFromJson(Map<String, dynamic> json) {
  return Board(
    json['name'] as String,
    json['manager'] as String,
    json['description'] as String,
    json['section'] as String,
    json['is_favorite'] as bool,
    json['threads_today_count'] as int,
  );
}

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'name': instance.name,
      'manager': instance.manager,
      'description': instance.description,
      'section': instance.section,
      'is_favorite': instance.isFavorite,
      'threads_today_count': instance.threadsTodayCount,
    };

Articles _$ArticlesFromJson(Map<String, dynamic> json) {
  return Articles(
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
        : Poster.fromJson(json['poster'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
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

Poster _$PosterFromJson(Map<String, dynamic> json) {
  return Poster(
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

Map<String, dynamic> _$PosterToJson(Poster instance) => <String, dynamic>{
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

Head _$HeadFromJson(Map<String, dynamic> json) {
  return Head(
    json['id'] as int,
    json['time'] as String,
    json['voted'] as bool,
    json['voteddown'] as bool,
    json['voteup_count'] as String,
    json['votedown_count'] as String,
    json['poster'] == null
        ? null
        : HeadPoster.fromJson(json['poster'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HeadToJson(Head instance) => <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'voted': instance.voted,
      'voteddown': instance.voteddown,
      'voteup_count': instance.voteupCount,
      'votedown_count': instance.votedownCount,
      'poster': instance.poster,
    };

HeadPoster _$HeadPosterFromJson(Map<String, dynamic> json) {
  return HeadPoster(
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

Map<String, dynamic> _$HeadPosterToJson(HeadPoster instance) =>
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

PopularReplies _$PopularRepliesFromJson(Map<String, dynamic> json) {
  return PopularReplies(
    json['content'] as String,
    json['time'] as String,
    json['pos'] as int,
    json['id'] as int,
    json['flag'] as String,
    json['voteup_count'] as String,
    json['votedown_count'] as String,
    json['voted'] as bool,
    json['voteddown'] as bool,
    json['poster'] == null
        ? null
        : PopularPoster.fromJson(json['poster'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PopularRepliesToJson(PopularReplies instance) =>
    <String, dynamic>{
      'content': instance.content,
      'time': instance.time,
      'pos': instance.pos,
      'id': instance.id,
      'flag': instance.flag,
      'voteup_count': instance.voteupCount,
      'votedown_count': instance.votedownCount,
      'voted': instance.voted,
      'voteddown': instance.voteddown,
      'poster': instance.poster,
    };

PopularPoster _$PopularPosterFromJson(Map<String, dynamic> json) {
  return PopularPoster(
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

Map<String, dynamic> _$PopularPosterToJson(PopularPoster instance) =>
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
