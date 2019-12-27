import 'package:flutter/material.dart';
import 'package:flutterdemo/model/timeline.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/pages/article_detial.dart';
import 'package:intl/intl.dart';

class Timeline extends StatefulWidget {
  Timeline({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends State<Timeline> with AutomaticKeepAliveClientMixin {
  var lists = [];
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    requestAPI();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          onRefresh: requestAPI,
          displacement: 20,
          backgroundColor: Colors.white,
          child: _getListView()),
    );
  }

  Widget _getListView() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: lists.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          var bean = lists[index];

          if (index == lists.length - 1) {
            return _buildProgressIndicator();
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ArticleDetail(
                      boardName: bean['board_name'],
                      id: bean['id'],
                      colorIndex: index);
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
            );
          }
        });
  }

  String _getDateTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-dd HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 0.0 : 1.0,
          child: CircularProgressIndicator(
            strokeWidth: 4.0,
            backgroundColor: Color(0xffff),
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
    );
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
    return Row(
      children: [
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
      ],
    );
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

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var _request = MockRequest();
      final Map result = await _request.get(API.TOP_10);
      var newEntries = result['data'];
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        lists.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.TIMELINE);
    var resultList = result['data']['article'];
    setState(() {
      lists = resultList;
      isPerformingRequest = false;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
