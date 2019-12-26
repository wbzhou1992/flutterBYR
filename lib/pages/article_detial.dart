import 'package:flutter/material.dart';
import 'package:flutterdemo/model/article.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/widgets/my_webview.dart';
import 'package:flutterdemo/pages/user_center.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;

class ArticleDetail extends StatefulWidget {
  final int id;
  final String boardName;
  final int colorIndex;

  ArticleDetail({Key key, this.boardName, this.id, this.colorIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticleDetailState();
}

class ArticleDetailState extends State<ArticleDetail> with AutomaticKeepAliveClientMixin{
  var userDetail;
  var articleDetail;
  var articleAll;
  var popularReplies;
  var commentList;
  var loading;
  var enabled = false;
  var inputPlaceholder = '';
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;
  final colorList = [Colors.green[400],Colors.blue[400],Colors.lightGreen,Colors.red[400],Colors.indigo,Colors.pink[400],Colors.brown[400],Colors.blueGrey[400],Colors.orange[400],Colors.red[100]];
  FocusNode _commentFocus = FocusNode();
  TextEditingController _controller =TextEditingController();

  @override
  void initState(){
    super.initState();
    requestAPI();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // 获取路由参数  
    return Scaffold(
      appBar: _getAppBar(widget.colorIndex),
      body: _getBody()
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
        IconButton(
          icon: Icon(Icons.star_border,color: Colors.white),
          onPressed: () {
            showDialog<Null>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[200],
                  content: Text('确定收录此文章吗？'),
                  contentPadding: const EdgeInsets.only(left:20,top:20,bottom:0),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('取消',style: TextStyle(color:Colors.black)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('确定'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
            );
          }
        ),
        IconButton(
          icon: Icon(Icons.share,color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return _showShare(context);
            });
          }
        ),
        PopupMenuButton<String>(
          onSelected: (String result) { 
            setState(() { 
              print(result); 
          });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              height:30,
              child: Padding(
                padding: const EdgeInsets.only(left:2,right:20,bottom:20),
                child: Text('返回版面'),
              ),
              value: 'return',
            ),
            PopupMenuItem(
              height:30,
              child: Padding(
                padding: const EdgeInsets.only(left:2,right:20),
                child: Text('翻页'),
              ),
              value: 'page',
            ),
          ],
        )
      ],
      backgroundColor: colorList[colorIndex],
    );
  }
  Widget _getBody() {
    if(userDetail == null) {
      return Center(
        child: _buildProgressIndicator()
      );
    }

    var poster = userDetail['poster'];
    var user = {
      'gender': poster['gender'],
      'userName': poster['id'],
      'avatar': poster['face_url'],
      'time': userDetail['time'],
      'thumbUp': userDetail['voteup_count'],
      'thumbDown': userDetail['votedown_count'],
      'pos': '楼主'
    };
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
              physics: ScrollPhysics(),
              slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _getUserDetail(10.0,user,context),
                      _getArticelDetail(context, user),
                      _getCommentDivider(1),
                      _getPopularReplies(popularReplies,context),
                      _getCommentDivider(2),
                      _getComment(commentList,context)
                    ],
                  ),
              ),
            ],
          )
        ),
        Container(
          height:50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
          ),
          child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10,right:10,bottom:8),
              child: Icon(
                IconData(0xe638, fontFamily: 'MyIcons'),
                size: 28,
                color: Colors.grey
              ),
            ),
            Expanded(
              child: Container(
                height:36,
                child:TextField(
                  controller: _controller,
                  focusNode: _commentFocus,
                  style: TextStyle(height:1.5),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: inputPlaceholder,
                    contentPadding: EdgeInsets.only(left:10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    suffixIcon: Icon(
                      IconData(0xe639, fontFamily: 'MyIcons'),
                      size: 20,
                      color: Colors.grey
                    )
                  ),
                  onChanged: (text) {//内容改变的回调
                    if (text != '') {
                      setState((){
                        enabled = true;
                      });
                    } else {
                      setState((){
                        enabled = false;
                      });
                    }
                  },
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0,left:8,bottom:2),
              child: Container(
                  width: 60,
                  height: 34,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: enabled ?  Colors.white : Colors.grey,
                    color: enabled ? colorList[widget.colorIndex] : Colors.grey[100],
                    child: Text("发送"),
                    onPressed: () {},
                  )
                ),
            ),
          ]
        )
        )
      ]
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
  Widget _getUserDetail(var padding,var user,var context) {
    var isDown = int.parse(user['thumbUp']) >= int.parse(user['thumbDown']);
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserCenter(id: user['userName']);
                   }
                 )
               );
            },
            child:  Container(
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
            )
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
                      color: user['gender'] == 'f' ? Color(0xFFFF6693) : Colors.blue,
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
                  isDown ? user['thumbUp'] : user['thumbDown'],
                  style: TextStyle(color: Colors.grey,fontSize:13)
                ),
                Container(
                  width: 28,
                  margin:  const EdgeInsets.only(right: 6.0),
                  child: IconButton(
                    padding:const EdgeInsets.only(left:1.0,bottom: 2.0),
                    icon: Icon(
                      isDown ? IconData(0xe619, fontFamily: 'MyIcons') : IconData(0xe618, fontFamily: 'MyIcons'),
                      size: 16,
                      color: Colors.grey
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return _showNomalWidList(context,user);
                        }
                      );
                    },
                  ),
                ),
                Text(
                  user['pos'],
                  style: TextStyle(color: Colors.grey,fontSize:12)
                ),
                Container(
                  width: 30,
                  child:IconButton(
                    padding: const EdgeInsets.only(right:8.0),
                    icon: Icon(Icons.expand_more,color: Colors.grey,size:20),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return _showNomalWidList(context,user);
                        }
                      );
                    },
                  ),
                ),              
              ]
            ),
          )
        ],
      )
    );
  }
   _showCollect(BuildContext context) {
    
  }
  Widget _showShare(BuildContext context) {
    List<String> nameItems = <String>['微博','微信','朋友圈','QQ','QQ空间'];
    List<String> iconList = <String>['weibo.png', 'weixin.png', 'pyq.png', 'qq.png', 'qqzone.png'];
    return Container(
      height: 110.0,
      padding: const EdgeInsets.only(right:10,left:10),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right:10,left:20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom:10),
                  child: Image.asset( 'assets/images/${iconList[index]}', width: 40.0, height: 40.0, fit: BoxFit.fill, ),
                ),
                Text(nameItems[index])
              ],
            )
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: nameItems.length,
      ),
    );
  }
  Widget _showNomalWidList(BuildContext context,var user) {
    var nameItems = ["赞 ${user['thumbUp']}","踩 ${user['thumbDown']}","取消"];
    _commentFocus.unfocus();
    return Container(
     height: 163.0,
      padding: const EdgeInsets.only(top:4.0),
      child: Column(
        children: [
          Container(
            height: 40,
            child: FlatButton(
              onPressed: () {
                setState((){});
                // showModalBottomSheet(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return _showNomalWid(context);
                    // });
              },
              child: Text(nameItems[0], style: TextStyle(fontSize:18)),
            ),
          ),
          Divider(),
          Container(
            height: 40,
            child: FlatButton(
              onPressed: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return _showNomalWid(context);
                //     });
              },
              child: Text(nameItems[1], style: TextStyle(fontSize:18)),
            ),
          ),
          Divider(thickness:6,color:Colors.grey[200]),
          Container(
            height: 40,
            child: FlatButton(
              onPressed: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return _showNomalWid(context);
                //     });
                Navigator.of(context).pop();
              },
              child: Text(nameItems[2], style: TextStyle(fontSize:18)),
            ),
          ),
        ]
      )
    );
  }
  Widget _getArticelDetail(var context,var user) {
    var content = articleDetail[0]['content'];
    var title = articleAll['title'];
    RegExp exp = RegExp(r'(href|src)\=\"(/att[/|\w|\d]*)\"');
    var con = content.replaceAllMapped(exp,(Match m){
      return '${m[1]}="https://bbs.byr.cn${m[2]}"';
    });
    var markdown = html2md.convert(con);
    return  GestureDetector (
      onTap: () {
        setState((){
          inputPlaceholder = '回复楼主 ' + user['userName'];
        });
      },
      child: Container(
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
    )
    );
  }
  
  Widget _getComment(var list,var context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length+1,
      itemBuilder: (BuildContext context, int index){
        if (index == list.length) {
          return _buildProgressIndicator();
        } else {
          return decodeArticle(list,index,context);
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
  Widget decodeArticle(List list, int index,var context){
    var currentUser = list[index]['poster'];
    var current = list[index];
    var content = current['content'];
    RegExp exp = RegExp(r'(【 在(.*)的大作中提到: 】)');
    var conList = content.replaceAll(RegExp(r'<br/>|<br>|<br\s/>|-|<img(.*)?>|<href(.*)?>'),'').split(exp);
    conList[0] == '' ?  conList = ['图片'] : '';
    var quto = '';
    var cont = content.replaceAllMapped(exp,(Match m){
      quto = m[1].isEmpty ? '' : m[1];
    });
    var user = {
      'gender': currentUser['gender'],
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
          setState((){
            inputPlaceholder = '回复'+ user['pos'] + ' ' + user['userName'];
          });
        },
        child: Container(
          alignment: Alignment(-1.0, 0),
          color: Colors.transparent,
          padding: EdgeInsets.only(left:10,right:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getUserDetail(0.0,user,context),
              _getCommentContent(user,conList,quto),
              Divider()
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
         setState((){
            inputPlaceholder = '回复'+ user['pos'] + ' ' + user['userName'];
          });
        },
        child: Container(
          alignment: Alignment(-1.0, 0),
          color: Colors.transparent,
          padding: EdgeInsets.only(left:10,right:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getUserDetail(0.0,user,context),
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
  Widget _getPopularReplies(var list,var context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index){
        return decodeArticle(list,index,context);
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
  Widget _getDialog(){
    return SimpleDialog(
      title: Text('选择'),
      children: <Widget>[
          SimpleDialogOption(
              child: Text('选项 1'),
              onPressed: () {
                  Navigator.of(context).pop();
              },
          ),
          SimpleDialogOption(
              child: Text('选项 2'),
              onPressed: () {
                  Navigator.of(context).pop();
              },
          ),
      ],
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
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut
          );
        }
      }
      setState(() {
        commentList.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }
  
  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.ARTICLE);
    var user = result['data']['head'];
    var articles = result['data']['articles'];
    var article = result['data'];
    var comment = articles.sublist(1,articles.length-1);
    setState(() {
      userDetail = user;
      articleDetail = articles;
      articleAll = article;
      popularReplies = result['data']['popularReplies'];
      commentList =  comment;
      isPerformingRequest = false;
    });
  }
  @override
  bool get wantKeepAlive => true;
}