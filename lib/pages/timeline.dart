import 'package:flutter/material.dart';
import 'package:flutterdemo/model/timeline.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/pages/article_detial.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';

class Timeline extends StatefulWidget {
  Timeline({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends State<Timeline> with AutomaticKeepAliveClientMixin {
  List lists;
  EasyRefreshController _controller;
  ScrollController _scrollController;
  String _updatedTime;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
    _updatedTime = _getDateTime();
    lists = [];
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyRefresh.custom(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        controller: _controller,
        scrollController: _scrollController,
        topBouncing: true,
        bottomBouncing: true,
        header: ClassicalHeader(
          refreshText: '下拉刷新',
          refreshingText: '正在刷新',
          refreshReadyText: '释放立即刷新',
          refreshedText: '刷新完成',
          infoText: '上次更新 ${_updatedTime}',
          enableInfiniteRefresh: false,
        ),
        footer: ClassicalFooter(
          enableInfiniteLoad: true,
          loadingText: '正在加载',
          noMoreText: '没有更多了',
          showInfo: false,
        ),
        onRefresh: () async {
          var _request = MockRequest();
          final Map result = await _request.get(API.TIMELINE);
          var resultList = result['data']['article'];
          setState(() {
            lists = resultList;
          });
          _controller.resetLoadState();
          _controller.finishRefresh();
          _updatedTime = _getDateTime();
        },
        onLoad: () async {
          var _request = MockRequest();
          final Map result = await _request.get(API.TIMELINE);
          var resultList = result['data']['article'];
          setState(() {
            lists.addAll(resultList);
          });
          _controller.finishLoad(noMore: lists.length >= 80);
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var bean = lists[index];
                return _getListItem(bean, index);
              },
              childCount: lists.length,
            ),
          ),
        ],
      ),

      ///
    );
  }

  Widget _getListItem(var bean, int index) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ArticleDetail(
                boardName: 'eee', id: 11111, colorIndex: index);
          }));
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getBoard(index + 1, bean),
              _getContentView(bean),
              index != lists.length - 1 ? Divider() : Text('')
            ],
          ),
        ),
      ),
      index != lists.length - 1 ? Divider() : Text('')
    ]);
  }

  String _getDateTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-dd HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  Widget _getBoard(var no, var article) {
    var board = article['board_description'];
    var time = article['post_time'].toString();
    var postTime = DateTime.fromMillisecondsSinceEpoch(article['post_time']);
    var formatter = new DateFormat('MM-dd');
    String formatted = formatter.format(postTime);
    var colorList = [
      Colors.green[400],
      Colors.blue[400],
      Colors.lightGreen,
      Colors.red[400],
      Colors.grey[400],
      Colors.pink[400],
      Colors.brown[400],
      Colors.blueGrey[400],
      Colors.orange[400],
      Colors.red[100],
      Colors.indigo
    ];
    return Row(children: [
      Container(
        child: Text(
          board,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(left: 20, top: 0, right: 10),
      ),
      Expanded(
        child: Container(child: Text('')),
      ),
      Padding(
          padding: EdgeInsets.only(top: 6, right: 10),
          child: Container(
            child: Text(formatted, style: TextStyle(color: Colors.grey)),
          ))
    ]);
  }

  Widget _getContentView(var article) {
    var title = article['title'];
    var content =
        article['content'].replaceAll(RegExp(r'\n|-|\[b\]|\[/b\]'), '');
    var hasAttachment =
        (article['attachment'] == null || article['attachment'] == '')
            ? false
            : true;
    var attachment =
        hasAttachment ? 'https://bbs.byr.cn' + article['attachment'] : '';
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontFamily: "PingFang",
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            margin: EdgeInsets.only(bottom: 14, top: 6),
          ),
          hasAttachment ? _getImage(content, attachment) : _getText(content)
        ],
      ),
    );
  }

  Widget _getImage(String content, String attachment) {
    return Row(children: <Widget>[
      Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(attachment), fit: BoxFit.cover),
        ),
      ),
      Expanded(
          child: Container(
              padding: EdgeInsets.only(right: 8.0), child: _getText(content)))
    ]);
  }

  Widget _getText(String content) {
    return Text(
      content,
      style: TextStyle(color: Colors.grey[700], height: 1.5),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }

  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.TIMELINE);
    var resultList = result['data']['article'];
    setState(() {
      lists.addAll(resultList);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
