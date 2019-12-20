import 'package:json_annotation/json_annotation.dart'; 
  
part 'article.g.dart';


@JsonSerializable()
  class Article extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  Article data;

  Article(this.success,this.data,);

  factory Article.fromJson(Map<String, dynamic> srcJson) => _$ArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}

  
@JsonSerializable()
  class Postdetail extends Object {

  @JsonKey(name: 'gid')
  int gid;

  @JsonKey(name: 'anony')
  bool anony;

  @JsonKey(name: 'reid')
  int reid;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'board')
  Board board;

  @JsonKey(name: 'articles')
  List<Articles> articles;

  @JsonKey(name: 'head')
  Head head;

  @JsonKey(name: 'popularReplies')
  List<PopularReplies> popularReplies;

  @JsonKey(name: 'pagination')
  Pagination pagination;

  Postdetail(this.gid,this.anony,this.reid,this.time,this.title,this.board,this.articles,this.head,this.popularReplies,this.pagination,);

  factory Postdetail.fromJson(Map<String, dynamic> srcJson) => _$PostdetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PostdetailToJson(this);

}

  
@JsonSerializable()
  class Board extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'manager')
  String manager;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'section')
  String section;

  @JsonKey(name: 'is_favorite')
  bool isFavorite;

  @JsonKey(name: 'threads_today_count')
  int threadsTodayCount;

  Board(this.name,this.manager,this.description,this.section,this.isFavorite,this.threadsTodayCount,);

  factory Board.fromJson(Map<String, dynamic> srcJson) => _$BoardFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

}

  
@JsonSerializable()
  class Articles extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'op')
  bool op;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'pos')
  int pos;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'subject')
  bool subject;

  @JsonKey(name: 'voted')
  bool voted;

  @JsonKey(name: 'voteup_count')
  String voteupCount;

  @JsonKey(name: 'voteddown')
  bool voteddown;

  @JsonKey(name: 'votedown_count')
  String votedownCount;

  @JsonKey(name: 'votedown_min')
  int votedownMin;

  @JsonKey(name: 'poster')
  Poster poster;

  Articles(this.id,this.op,this.time,this.pos,this.content,this.subject,this.voted,this.voteupCount,this.voteddown,this.votedownCount,this.votedownMin,this.poster,);

  factory Articles.fromJson(Map<String, dynamic> srcJson) => _$ArticlesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);

}

  
@JsonSerializable()
  class Poster extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'face_url')
  String faceUrl;

  @JsonKey(name: 'face_width')
  int faceWidth;

  @JsonKey(name: 'face_height')
  int faceHeight;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'astro')
  String astro;

  @JsonKey(name: 'life')
  int life;

  @JsonKey(name: 'qq')
  String qq;

  @JsonKey(name: 'msn')
  String msn;

  @JsonKey(name: 'home_page')
  String homePage;

  @JsonKey(name: 'level')
  String level;

  @JsonKey(name: 'is_online')
  bool isOnline;

  @JsonKey(name: 'post_count')
  int postCount;

  @JsonKey(name: 'last_login_time')
  int lastLoginTime;

  @JsonKey(name: 'last_login_ip')
  String lastLoginIp;

  @JsonKey(name: 'is_hide')
  bool isHide;

  @JsonKey(name: 'is_register')
  bool isRegister;

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'follow_num')
  int followNum;

  @JsonKey(name: 'fans_num')
  int fansNum;

  @JsonKey(name: 'is_follow')
  bool isFollow;

  @JsonKey(name: 'is_fan')
  bool isFan;

  Poster(this.id,this.userName,this.faceUrl,this.faceWidth,this.faceHeight,this.gender,this.astro,this.life,this.qq,this.msn,this.homePage,this.level,this.isOnline,this.postCount,this.lastLoginTime,this.lastLoginIp,this.isHide,this.isRegister,this.score,this.followNum,this.fansNum,this.isFollow,this.isFan,);

  factory Poster.fromJson(Map<String, dynamic> srcJson) => _$PosterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PosterToJson(this);

}

  
@JsonSerializable()
  class Head extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'voted')
  bool voted;

  @JsonKey(name: 'voteddown')
  bool voteddown;

  @JsonKey(name: 'voteup_count')
  String voteupCount;

  @JsonKey(name: 'votedown_count')
  String votedownCount;

  @JsonKey(name: 'poster')
  HeadPoster poster;

  Head(this.id,this.time,this.voted,this.voteddown,this.voteupCount,this.votedownCount,this.poster,);

  factory Head.fromJson(Map<String, dynamic> srcJson) => _$HeadFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadToJson(this);

}

  
@JsonSerializable()
  class HeadPoster extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'face_url')
  String faceUrl;

  @JsonKey(name: 'face_width')
  int faceWidth;

  @JsonKey(name: 'face_height')
  int faceHeight;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'astro')
  String astro;

  @JsonKey(name: 'life')
  int life;

  @JsonKey(name: 'qq')
  String qq;

  @JsonKey(name: 'msn')
  String msn;

  @JsonKey(name: 'home_page')
  String homePage;

  @JsonKey(name: 'level')
  String level;

  @JsonKey(name: 'is_online')
  bool isOnline;

  @JsonKey(name: 'post_count')
  int postCount;

  @JsonKey(name: 'last_login_time')
  int lastLoginTime;

  @JsonKey(name: 'last_login_ip')
  String lastLoginIp;

  @JsonKey(name: 'is_hide')
  bool isHide;

  @JsonKey(name: 'is_register')
  bool isRegister;

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'follow_num')
  int followNum;

  @JsonKey(name: 'fans_num')
  int fansNum;

  @JsonKey(name: 'is_follow')
  bool isFollow;

  @JsonKey(name: 'is_fan')
  bool isFan;

  HeadPoster(this.id,this.userName,this.faceUrl,this.faceWidth,this.faceHeight,this.gender,this.astro,this.life,this.qq,this.msn,this.homePage,this.level,this.isOnline,this.postCount,this.lastLoginTime,this.lastLoginIp,this.isHide,this.isRegister,this.score,this.followNum,this.fansNum,this.isFollow,this.isFan,);

  factory HeadPoster.fromJson(Map<String, dynamic> srcJson) => _$HeadPosterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadPosterToJson(this);

}

  
@JsonSerializable()
  class PopularReplies extends Object {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'pos')
  int pos;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'voteup_count')
  String voteupCount;

  @JsonKey(name: 'votedown_count')
  String votedownCount;

  @JsonKey(name: 'voted')
  bool voted;

  @JsonKey(name: 'voteddown')
  bool voteddown;

  @JsonKey(name: 'poster')
  PopularPoster poster;

  PopularReplies(this.content,this.time,this.pos,this.id,this.flag,this.voteupCount,this.votedownCount,this.voted,this.voteddown,this.poster,);

  factory PopularReplies.fromJson(Map<String, dynamic> srcJson) => _$PopularRepliesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PopularRepliesToJson(this);

}

  
@JsonSerializable()
  class PopularPoster extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'face_url')
  String faceUrl;

  @JsonKey(name: 'face_width')
  int faceWidth;

  @JsonKey(name: 'face_height')
  int faceHeight;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'astro')
  String astro;

  @JsonKey(name: 'life')
  int life;

  @JsonKey(name: 'qq')
  String qq;

  @JsonKey(name: 'msn')
  String msn;

  @JsonKey(name: 'home_page')
  String homePage;

  @JsonKey(name: 'level')
  String level;

  @JsonKey(name: 'is_online')
  bool isOnline;

  @JsonKey(name: 'post_count')
  int postCount;

  @JsonKey(name: 'last_login_time')
  int lastLoginTime;

  @JsonKey(name: 'last_login_ip')
  String lastLoginIp;

  @JsonKey(name: 'is_hide')
  bool isHide;

  @JsonKey(name: 'is_register')
  bool isRegister;

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'follow_num')
  int followNum;

  @JsonKey(name: 'fans_num')
  int fansNum;

  @JsonKey(name: 'is_follow')
  bool isFollow;

  @JsonKey(name: 'is_fan')
  bool isFan;

  PopularPoster(this.id,this.userName,this.faceUrl,this.faceWidth,this.faceHeight,this.gender,this.astro,this.life,this.qq,this.msn,this.homePage,this.level,this.isOnline,this.postCount,this.lastLoginTime,this.lastLoginIp,this.isHide,this.isRegister,this.score,this.followNum,this.fansNum,this.isFollow,this.isFan,);

  factory PopularPoster.fromJson(Map<String, dynamic> srcJson) => _$PopularPosterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PopularPosterToJson(this);

}

  
@JsonSerializable()
  class Pagination extends Object {

  @JsonKey(name: 'current')
  int current;

  @JsonKey(name: 'total')
  int total;

  Pagination(this.current,this.total,);

  factory Pagination.fromJson(Map<String, dynamic> srcJson) => _$PaginationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

}

  
