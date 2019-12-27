import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static HttpRequest _instance;
  Dio _dio;

  static HttpRequest getInstance() {
    if (_instance == null) {
      _instance = HttpRequest();
    }
    return _instance;
  }

  HttpRequest() {
    var _baseOptions = new BaseOptions(
      baseUrl: '',
      //请求服务地址
      connectTimeout: 5000,
      //响应时间
      receiveTimeout: 5000,
      headers: {
        //需要配置请求的header可在此处配置
        'cookie':
            '_ga=GA1.2.783977894.1565973011; nforum-left=100; left-index=0010000000; nforum[UTMPUSERID]=wbzhou1992; nforum[PASSWORD]=chwkqyuFN0un0OlB6aMDQQ%3D%3D; nforum[UTMPKEY]=76292493; nforum[UTMPNUM]=3672; Hm_lvt_38b0e830a659ea9a05888b924f641842=1576480257,1576548292,1576636840,1576720768; nforum[site]=yamb; Hm_lpvt_38b0e830a659ea9a05888b924f641842=1576720808'
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      //表示期望以那种格式(方式)接受响应数据。接受三种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
    );
    _dio = new Dio(_baseOptions);
  }
  Future<dynamic> get(String uri) async {
    try {
      Response response = await _dio.get(uri);
      final statusCode = response.statusCode;
      final resData = response.data;
      print('[uri=$uri][statusCode=$statusCode][response=$resData]');
      return resData;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post(String uri, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(uri, data: data);
      final statusCode = response.statusCode;
      final resData = response.data;
      print('[uri=$uri][statusCode=$statusCode][response=$resData]');
      return resData;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }
}
