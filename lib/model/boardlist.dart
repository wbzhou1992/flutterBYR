import 'package:json_annotation/json_annotation.dart'; 
  
part 'boardlist.g.dart';


@JsonSerializable()
  class Boardlist extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  Data data;

  Boardlist(this.success,this.data,);

  factory Boardlist.fromJson(Map<String, dynamic> srcJson) => _$BoardlistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BoardlistToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'boards')
  List<Boards> boards;

  Data(this.boards,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Boards extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'dir')
  bool dir;

  @JsonKey(name: 'first_level')
  bool firstLevel;

  @JsonKey(name: 'new')
  int notice;

  @JsonKey(name: 'children')
  List<Children> children;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'fav')
  bool fav;

  Boards(this.id,this.name,this.desc,this.dir,this.firstLevel,this.notice,this.children,this.offset,this.fav,);

  factory Boards.fromJson(Map<String, dynamic> srcJson) => _$BoardsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BoardsToJson(this);

}

  
@JsonSerializable()
  class Children extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'dir')
  bool dir;

  @JsonKey(name: 'first_level')
  bool firstLevel;

  @JsonKey(name: 'new')
  int notice;

  @JsonKey(name: 'children')
  List<Children> children;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'fav')
  bool fav;

  Children(this.id,this.name,this.desc,this.dir,this.firstLevel,this.notice,this.children,this.offset,this.fav,);

  factory Children.fromJson(Map<String, dynamic> srcJson) => _$ChildrenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildrenToJson(this);

}

  
@JsonSerializable()
  class Children extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'dir')
  bool dir;

  @JsonKey(name: 'first_level')
  bool firstLevel;

  @JsonKey(name: 'new')
  int notice;

  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'fav')
  bool fav;

  Children(this.id,this.name,this.desc,this.dir,this.firstLevel,this.notice,this.children,this.offset,this.fav,);

  factory Children.fromJson(Map<String, dynamic> srcJson) => _$ChildrenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildrenToJson(this);

}

  
