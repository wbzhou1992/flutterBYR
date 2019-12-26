import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';

class UserCenter extends StatefulWidget {
  final String id;
  UserCenter({Key key,this.id}) : super(key: key);

  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter> {
  var userDetail;
  @override
  void initState(){
    super.initState();
    requestAPI();
  }
  
  @override
  Widget build(BuildContext context) {
    if(userDetail == null) {
      return Text('加载中');
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 340,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(userDetail['face_url']),
              fit: BoxFit.cover
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.blue.withOpacity(0.4),
            ),
          ),
        ),
        _getAppBar(),
        _getUser(),
        _getBody()
      ],
    );
  }
  Widget _getAppBar(){
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
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(userDetail['id']),
      actions: [
        IconButton(
          icon: Icon(
            IconData(0xe617, fontFamily: 'MyIcons'),
            size: 28,
            color: Colors.white
          ), 
          onPressed: () {}
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
                padding: const EdgeInsets.all(10),
                child: Text('关注用户'),
              ),
              value: '关注用户',
            )
          ],
        )
      ]
    );
  }
  
  Widget _getUser(){
    return Positioned(
      top: 90.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(60.0),
              image: DecorationImage(
                  image: NetworkImage(userDetail['face_url']),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:20),
            child: Text(userDetail['user_name'], style: _getTextStyle(18))
          ),
          Container(
            width: 450,
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.only(top:30),
            color: Colors.blue.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('文章数',style: _getTextStyle(14.0)),
                    Text(userDetail['post_count'].toString(),style: _getTextStyle(16.0)),
                  ]
                ),
                Column(
                  children: [
                    Text('关注数',style: _getTextStyle(14.0)),
                    Text(userDetail['fans_num'].toString(),style: _getTextStyle(16.0)),
                  ]
                ),
                Column(
                  children: [
                    Text('粉丝数',style: _getTextStyle(14.0)),
                    Text(userDetail['follow_num'].toString(),style: _getTextStyle(16.0)),
                  ]
                )
              ]
            )
          )
        ]
      )
    );
  }
  TextStyle _getTextStyle(double size){
    return TextStyle(fontSize: size,color:Colors.white,decoration: TextDecoration.none,height:1.4,fontWeight: FontWeight.w400,fontFamily:'PingFangSC-Regular,PingFang SC;');
  }
  Widget _getBody() {
    var listLabel = ['等级','积分','生命力','关注状态','最后在线','星座','QQ','MSN','主页'];
    var listValue = [
      userDetail['level'],
      userDetail['score'],
      userDetail['life'],
      userDetail['is_follow'] ? '已关注' : '未关注',
      userDetail['last_login_time'],
      userDetail['astro'],
      userDetail['qq'],
      userDetail['msn'],
      userDetail['home_page']
    ];
    return Positioned(
      top: 340.0,
      left: 0.0,
      bottom: 0.0,
      right: 0.0,
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          padding: EdgeInsets.only(top: 6,bottom:6),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right:20,left:20,top:10,bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(listLabel[index],style: TextStyle(fontSize: 16.0,color:Colors.black,decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontFamily:'PingFangSC-Regular,PingFang SC;')),
                  Text(listValue[index].toString(),style: TextStyle(fontSize: 14.0,color:Colors.grey[500],decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontFamily:'PingFangSC-Regular,PingFang SC;')),
                ],
              )
            );
          },
          itemCount: listLabel.length,
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey[400]),
        ),
      )
    );
  }
  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.USER);
    var user = result['data'];
    setState(() {
      userDetail = user;
    });
  }
}