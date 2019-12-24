import 'package:json_annotation/json_annotation.dart'; 
  
part 'comment.g.dart';


@JsonSerializable()
  class Comment extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  CommentData data;

  Comment(this.success,this.data,);

  factory Comment.fromJson(Map<String, dynamic> srcJson) => _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}

  
@JsonSerializable()
  class CommentData extends Object {

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

 

  @JsonKey(name: 'articles')
  List<CommentItem> articles;

  @JsonKey(name: 'pagination')
  Pagination pagination;

  CommentData(this.gid,this.anony,this.reid,this.time,this.title,this.articles,this.pagination,);

  factory CommentData.fromJson(Map<String, dynamic> srcJson) => _$CommentDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentDataToJson(this);

}
  
@JsonSerializable()
  class CommentItem extends Object {

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
  CommentUser poster;

  CommentItem(this.id,this.op,this.time,this.pos,this.content,this.subject,this.voted,this.voteupCount,this.voteddown,this.votedownCount,this.votedownMin,this.poster,);

  factory CommentItem.fromJson(Map<String, dynamic> srcJson) => _$CommentItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);

}

  
@JsonSerializable()
  class CommentUser extends Object {

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

  CommentUser(this.id,this.userName,this.faceUrl,this.faceWidth,this.faceHeight,this.gender,this.astro,this.life,this.qq,this.msn,this.homePage,this.level,this.isOnline,this.postCount,this.lastLoginTime,this.lastLoginIp,this.isHide,this.isRegister,this.score,this.followNum,this.fansNum,this.isFollow,this.isFan,);

  factory CommentUser.fromJson(Map<String, dynamic> srcJson) => _$CommentUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentUserToJson(this);

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

  
