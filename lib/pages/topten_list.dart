import 'package:flutter/material.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/api/http_request.dart';
import 'package:flutterdemo/pages/article_detial.dart';

class ToptenList extends StatefulWidget {
  ToptenList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ToptenListState();
  }
}

final API _api = API();

class ToptenListState extends State<ToptenList>
    with AutomaticKeepAliveClientMixin {
  var lists = [];

  @override
  void initState() {
    super.initState();
    requestAPI();
    // _api.getTopten((result) {
    //   var resultList = result;
    //   setState(() {
    //     lists = resultList;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          onRefresh: requestAPI,
          displacement: 20,
          backgroundColor: Colors.white,
          child:
              lists.length == 0 ? _buildProgressIndicator() : _getListView()),
    );
  }

  Widget _getListView() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: lists.length,
        itemBuilder: (BuildContext context, int index) {
          var bean = lists[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, 
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => 
                  ArticleDetail(
                    boardName: bean['board_name'],
                    id: bean['id'],
                    colorIndex: index
                  ),
                  transitionsBuilder:(context, animation, secondaryAnimation, child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }
                )
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getUsesrView(index + 1, bean),
                  _getContentView(bean),
                  index != lists.length - 1 ? Divider() : Text('')
                ],
              ),
            ),
          );
        });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Opacity(
          opacity: 1.0,
          child: CircularProgressIndicator(
            strokeWidth: 4.0,
            backgroundColor: Color(0xffff),
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _getUsesrView(var no, var article) {
    var board = article['board'].substring(0, 1);
    var id = article['user']['id'];
    var count = article['count'].toString();
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Center(
            child: Text(
              board,
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
            color: colorList[no - 1],
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(left: 20, top: 10, right: 10),
          width: 30,
          height: 30,
        ),
        Expanded(
            child: Container(
          child: Text(id, style: TextStyle(color: Colors.grey)),
          margin: EdgeInsets.only(top: 10),
        )),
        Expanded(
            flex: 1,
            child: Container(
              child: Text(count + '人参与',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.grey)),
              margin: EdgeInsets.only(top: 10, right: 20),
            )),
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
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
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
            padding: EdgeInsets.only(bottom: 14, top: 6),
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
          child: Padding(
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
    final Map result = await _request.get(API.TOP_10);
    var resultList = result['data'];
    setState(() {
      lists = resultList;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
