import 'dart:convert';


class User extends Object{
  int id;
  String user_name;
  String face_url;
  int post_count;
  bool is_online;
  int follow_num;
  int fans_num;
  bool is_follow;
  String level;
  String astro;
  String qq;
  String msn;
  String home_page;
  User({this.id,this.user_name,this.face_url,this.post_count,this.is_online,this.follow_num,this.fans_num,this.is_follow,this.level,this.astro,this.qq,this.msn,this.home_page});

}
class UserData extends Object{
  User data;
  bool success;
  UserData({this.data,this.success})
}

factory User.fromJson(Map<String,dynamic> jsonData){
  return User(
    id: jsonData['id'],
    user_name:jsonData['user_name'],
    face_url:jsonData['face_url'],
    post_count:jsonData['post_count'],
    is_online:jsonData['is_online'],
    follow_num:jsonData['follow_num'],
    fans_num:jsonData['fans_num'],
    is_follow:jsonData['is_follow'],
    level:jsonData['level'],
    astro:jsonData['astro'],
    qq:jsonData['qq'],
    msn:jsonData['msn'],
    home_page:jsonData['home_page'],
  )
}


factory UserData.fromJson(Map<String,dynamic> jsonData){
  return UserData(
    data: User.fromJson(jsonData['data']),
    success: jsonData['success']
  )
}