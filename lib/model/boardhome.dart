import 'package:json_annotation/json_annotation.dart'; 
  
part 'boardhome.g.dart';


@JsonSerializable()
  class Boardhome extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  Data data;

  Boardhome(this.success,this.data,);

  factory Boardhome.fromJson(Map<String, dynamic> srcJson) => _$BoardhomeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BoardhomeToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'parent')
  int parent;

  @JsonKey(name: 'boards')
  List<Boards> boards;

  Data(this.parent,this.boards,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Boards extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'dir')
  bool dir;

  @JsonKey(name: 'pos')
  int pos;

  @JsonKey(name: 'new')
  int notice;

  @JsonKey(name: 'level')
  int level;

  Boards(this.name,this.desc,this.dir,this.pos,this.notice,this.level,);

  factory Boards.fromJson(Map<String, dynamic> srcJson) => _$BoardsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BoardsToJson(this);

}

  
