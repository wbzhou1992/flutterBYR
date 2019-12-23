import 'package:flutterdemo/api/API.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

///模拟数据
class MockRequest {

  Future<dynamic> get(String action, {Map params}) async {
    return MockRequest.mock(action: getJsonName(action), params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  Map<String, String> map = {
    API.TOP_10: 'top250',
    API.ARTICLE: 'article',
    API.TIMELINE: 'timeline',
    API.BOARD: 'board',
    API.BANNER: 'banner',
    API.BOARDS: 'boardlist'
  };

  getJsonName(String action) {
    return map[action];
  }
}
