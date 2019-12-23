// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner(
    json['success'] as bool,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['banners'] as List)
        ?.map((e) =>
            e == null ? null : Banners.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'banners': instance.banners,
    };

Banners _$BannersFromJson(Map<String, dynamic> json) {
  return Banners(
    json['image_url'] as String,
    json['intro'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'image_url': instance.imageUrl,
      'intro': instance.intro,
      'url': instance.url,
    };
