import 'package:flutter/material.dart';
import 'package:flutterdemo/api/http_request.dart';
import 'package:flutterdemo/model/topten.dart';
import 'package:flutterdemo/model/article.dart';
import 'package:flutterdemo/model/comment.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://bbs.byr.cn/n/b';

  ///TOP10
  static const String TOP_10 = BASE_URL + '/home/topten.json';
  //时间线
  static const String TIMELINE = BASE_URL + '/home/timeline.json';
  //版面
  static const String BLOCK = BASE_URL + '/home/fav/0.json';
  //文章详情
  static const String ARTICLE = BASE_URL + '/article/';
  //版面
  static const String BOARD = BASE_URL + '/home/fav/0.json';
  static const String BANNER = BASE_URL + '/banner.json';
  //banner
  static const String BOARDS = BASE_URL + '/section.json';

  static const String USER = BASE_URL + '/user/query/fyzebo.json';

  var _request = HttpRequest.getInstance();

  Future<dynamic> _query(String uri) async {
    var response = await _request.get(uri);
    return response;
  }

  void getTopten(RequestCallBack requestCallBack) async {
    final result = await _query(TOP_10);
    Topten bean = Topten.fromJson(result);
    List<Data> list = bean.data;
    requestCallBack(list);
  }

  void getArticleDetail(RequestCallBack requestCallBack,
      {var page, String path}) async {
    final result = await _query(ARTICLE + '$path.json?page=$page');
    var bean = Article.fromJson(result);
    ArticleData list = bean.data;
    print('Postdetail $list');
    requestCallBack(list);
  }

  void getComments(RequestCallBack requestCallBack,
      {var page, String path}) async {
    final result = await _query(ARTICLE + '$path.json?page=$page');
    var bean = Comment.fromJson(result);
    CommentData list = bean.data;
    print('Commentdata $list');
    requestCallBack(list);
  }
}
