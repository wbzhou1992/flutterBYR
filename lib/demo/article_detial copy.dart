import 'package:flutter/material.dart';
import 'package:flutterdemo/model/article.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/widgets/my_webview.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;

class ArticleDetail extends StatefulWidget {
  final String userName;
  final int colorIndex;

  ArticleDetail({Key key, this.userName, this.colorIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticleDetailState();
}

class ArticleDetailState extends State<ArticleDetail> {
  var userDetail;
  var articleDetail;
  var articleAll;
  var popularReplies;
  var commentList;
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;
  final colorList = [Colors.green[400],Colors.blue[400],Colors.lightGreen,Colors.red[400],Colors.indigo,Colors.pink[400],Colors.brown[400],Colors.blueGrey[400],Colors.orange[400],Colors.red[100]];
  @override
  void initState(){
    super.initState();
    // requestAPI();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // 获取路由参数  
    return Scaffold(
      appBar: _getAppBar(widget.colorIndex),
      body: getFutureBuilder()
    );
  }
  Widget getFutureBuilder() {
    return FutureBuilder<Map<String, dynamic>>(
      future: requestAPI(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
        if (snapshot.hasData) {
          Future.delayed(Duration(milliseconds: 200)).then((e) {
             setState(() {
                commentList =  snapshot.data['commentList'];
                isPerformingRequest = false;
              });
          });
          return _getBody(snapshot.data);
        } else {
          return _buildProgressIndicator();
        }
      }
    );
  }
  Widget _getAppBar(colorIndex){
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.keyboard_backspace,size: 30.0),
            onPressed: () { 
              Navigator.pop(context,"返回");
            },
          );
        },
      ),
      title: Text("阅读文章"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.star_border,color: Colors.white,)),
        IconButton(icon: Icon(Icons.share,color: Colors.white,)),
        IconButton(icon: Icon(Icons.more_vert,color: Colors.white,)),
      ],
      backgroundColor: colorList[colorIndex],
    );
  }
  Widget _getBody(var data){
    return Container(
      child: Stack(
        children: [
          _getSingleChildScrollView(data),
        ]
      )
    );
  }
  Widget _getSingleChildScrollView(var data) {
    var userDetail = data['userDetail'];
    var poster = userDetail['poster'];
    var user = {
      'userName': poster['user_name'],
      'avatar': poster['face_url'],
      'time': userDetail['time'],
      'thumbUp': userDetail['voteup_count'],
      'thumbDown': userDetail['votedown_count'],
      'pos': '楼主'
    };
    return CustomScrollView(
      controller: _scrollController,
        physics: ScrollPhysics(),
        slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _getUserDetail(10.0,user),
                _getArticelDetail(context, data),
                _getCommentDivider(1),
                _getPopularReplies(data['popularReplies']),
                _getCommentDivider(2),
                _getComment(commentList);
              ],
            ),
        ),
      ],
    );
  }
  Widget _getCommentDivider(int divider){
    return Padding(
      padding: const EdgeInsets.only(left:20,bottom:14),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: divider == 1 
            ? Icon(
                IconData(0xe60c, fontFamily: 'MyIcons'),
                size: 20,
                color: Colors.red
            ) : Icon(
                  IconData(0xe51a, fontFamily: 'MyIcons'),
                  size: 20,
                  color: Colors.orange
              ),
          ),
          divider == 1 ? Text(
            '精彩回复',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12
            )
          ) : Text(
            '全部回复',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 1,
              color: Colors.grey[300],
            )
          )
        ]
      )
    );
  }
  Widget _getUserDetail(var padding,var user) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: NetworkImage(user['avatar']),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    user['userName'],
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16
                    ),
                  ),
                ),
                Text(
                  user['time'],
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12
                  ),
                )
              ]
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  user['thumbUp'],
                  style: TextStyle(color: Colors.grey,fontSize:13)
                ),
                Container(
                  width: 28,
                  margin:  const EdgeInsets.only(right: 6.0),
                  child: IconButton(
                    padding:const EdgeInsets.only(left:1.0,bottom: 2.0),
                    icon: Icon(
                      IconData(0xe620, fontFamily: 'MyIcons'),
                      size: 13,
                      color: Colors.grey
                    ),
                  ),
                ),
                Text(
                  user['pos'],
                  style: TextStyle(color: Colors.grey,fontSize:12)
                ),
                Container(
                  width: 30,
                  child:IconButton(
                    padding:const EdgeInsets.only(right:8.0),
                    icon: Icon(Icons.expand_more,color: Colors.grey,size:20)
                  ),
                ),              
              ]
            ),
          )
        ],
      )
    );
  }
  
  Widget _getArticelDetail(var context,var data) {
    var articleDetail = data['articleDetail'];
    var articleAll = data['articleAll'];
    var content = articleDetail[0]['content'];
    var title = articleAll['title'];
    RegExp exp = new RegExp(r'(href|src)\=\"(/att[/|\w|\d]*)\"');
    var con = content.replaceAllMapped(exp,(Match m){
      return '${m[1]}="https://bbs.byr.cn${m[2]}"';
    });
    var markdown = html2md.convert(con);
    return Container(
      padding: EdgeInsets.only(right:20,left:20,bottom:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom:10),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize:18,
                fontWeight:FontWeight.w500,
              ),
            ),
          ),
          MarkdownBody(
            onTapLink: (url){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Container(
                      width: 100,
                      child: MyWebview(
                          url: url,
                          title: '浏览网页'
                        )
                      );
                   }
                 )
               );
            },
            data: markdown,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(fontSize: 16,color: Colors.grey[900],height: 1.6)
            )
          )
        ]
      )
    );
  }
  
  Widget _getComment(var list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemCount: list.length+1,
      itemBuilder: (BuildContext context, int index){
        if (index == list.length) {
          return _buildProgressIndicator();
        } else {
          return decodeArticle(list,index);
        }
      }
    );
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
    );
  }
  Widget decodeArticle(List list, int index){
    var currentUser = list[index]['poster'];
    var current = list[index];
    var content = current['content'];
    RegExp exp = new RegExp(r'(【 在(.*)的大作中提到: 】)');
    var conList = content.replaceAll(RegExp(r'<br/>|<br>|<br\s/>|-|<img(.*)?>|<href(.*)?>'),'').split(exp);
    conList[0] == '' ?  conList = ['图片'] : '';
    var quto = '';
    var cont = content.replaceAllMapped(exp,(Match m){
      quto = m[1].isEmpty ? '' : m[1];
    });
    var user = {
      'userName': currentUser['id'],
      'avatar': currentUser['face_url'],
      'time': current['time'],
      'thumbUp': current['voteup_count'],
      'thumbDown': current['votedown_count'],
      'pos': current['pos'].toString()+'楼'
    };
    if(quto != '') {
      return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return ArticleDetail(userName:"Li peng",colorIndex: index);
          //     }
          //   )
          // );
        },
        child: Container(
          alignment: Alignment(-1.0, 0),
          color: Colors.transparent,
          padding: EdgeInsets.only(left:10,right:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getUserDetail(0.0,user),
              _getCommentContent(user,conList,quto),
              Divider()
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return ArticleDetail(userName:"Li peng",colorIndex: index);
          //     }
          //   )
          // );
        },
        child: Container(
          alignment: Alignment(-1.0, 0),
          color: Colors.transparent,
          padding: EdgeInsets.only(left:10,right:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getUserDetail(0.0,user),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  conList[0],
                  style: TextStyle(fontSize: 16,)
                )
              ),
              index != list.length-1 ? Padding(
                padding: EdgeInsets.only(left: 50),
                child: Divider()
              ) : Text('')
            ],
          ),
        ),
      );
    }
  }
  Widget _getPopularReplies(var list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index){
        return decodeArticle(list,index);
      }
    );
  }

  Widget _getCommentContent(var user, var conList,var quto){
    return Padding(
      padding: EdgeInsets.only(left:10,right:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              conList[0],
              style: TextStyle(fontSize: 16)
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,bottom:0,top:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      IconData(0xe70d, fontFamily: 'MyIcons'),
                      size: 20,
                      color: Colors.blue
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1,
                        color: Colors.grey[300]
                      )
                    )
                  ]
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    quto,
                    style: TextStyle(fontSize: 14,color: Colors.grey[400]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(conList[1],style:TextStyle(fontSize: 14,color: Colors.grey[400])),
                ),
              ]
            )
          ),                      
        ]
      )
    );
  }
  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var _request = MockRequest();
      final Map result = await _request.get(API.ARTICLE);
      var newEntries = result['data']['articles'];
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
            _scrollController.offset - (edge -offsetFromBottom),
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeOut
          );
        }
      }
      Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
          commentList.addAll(newEntries);
          isPerformingRequest = false;
        });
      });
    }
  }
  
  Future<Map<String, dynamic>> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.ARTICLE);
    var user = result['data']['head'];
    var articles = result['data']['articles'];
    var article = result['data'];
    var comment = articles.sublist(1,articles.length-1);
    var data = {
      'userDetail': user,
      'articleDetail': articles,
      'articleAll': article,
      'popularReplies': result['data']['popularReplies'],
      'commentList':  comment,
      'isPerformingRequest': false
    };
    // setState(() {
    //   userDetail = user;
    //   articleDetail = articles;
    //   articleAll = article;
    //   popularReplies = result['data']['popularReplies'];
    //   commentList =  comment;
    //   isPerformingRequest = false;
    // });
    return data;
  }
}