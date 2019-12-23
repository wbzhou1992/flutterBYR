import 'package:json_annotation/json_annotation.dart'; 
  
part 'banner.g.dart';


@JsonSerializable()
  class Banner extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  Data data;

  Banner(this.success,this.data,);

  factory Banner.fromJson(Map<String, dynamic> srcJson) => _$BannerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'banners')
  List<Banners> banners;

  Data(this.banners,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Banners extends Object {

  @JsonKey(name: 'image_url')
  String imageUrl;

  @JsonKey(name: 'intro')
  String intro;

  @JsonKey(name: 'url')
  String url;

  Banners(this.imageUrl,this.intro,this.url,);

  factory Banners.fromJson(Map<String, dynamic> srcJson) => _$BannersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannersToJson(this);

}

  
