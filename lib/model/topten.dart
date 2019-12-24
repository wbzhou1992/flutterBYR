import 'package:json_annotation/json_annotation.dart'; 
  
part 'topten.g.dart';


@JsonSerializable()
  class Topten extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  List<Data> data;

  Topten(this.success,this.data,);

  factory Topten.fromJson(Map<String, dynamic> srcJson) => _$ToptenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ToptenToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'group_id')
  int groupId;

  @JsonKey(name: 'reply_id')
  int replyId;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'position')
  int position;

  @JsonKey(name: 'is_top')
  bool isTop;

  @JsonKey(name: 'is_subject')
  bool isSubject;

  @JsonKey(name: 'is_admin')
  bool isAdmin;

  @JsonKey(name: 'post_time')
  int postTime;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'board_name')
  String boardName;

  @JsonKey(name: 'board_description')
  String boardDescription;

  @JsonKey(name: 'board')
  String board;

  @JsonKey(name: 'attachment')
  String attachment;

  Data(this.id,this.groupId,this.replyId,this.flag,this.position,this.isTop,this.isSubject,this.isAdmin,this.postTime,this.title,this.content,this.user,this.boardName,this.boardDescription,this.board,this.attachment);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class User extends Object {

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

  User(this.id,this.userName,this.faceUrl,this.faceWidth,this.faceHeight,this.gender,this.astro,this.life,this.qq,this.msn,this.homePage,this.level,this.isOnline,this.postCount,this.lastLoginTime,this.lastLoginIp,this.isHide,this.isRegister,this.score,this.followNum,this.fansNum,this.isFollow,this.isFan,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

  
