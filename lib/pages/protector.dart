import 'package:flutter/material.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';

class Protector extends StatefulWidget {
  final String id;
  Protector({Key key, this.id}) : super(key: key);

  @override
  _ProtectorState createState() => _ProtectorState();
}

class _ProtectorState extends State<Protector> {
  var userDetail;
  EasyRefreshController _controller;
  ScrollController _scrollController;
// 条目总数
  int _count = 20;
  // 反向
  bool _reverse = false;
  // 方向
  Axis _direction = Axis.vertical;
  // Header浮动
  bool _headerFloat = false;
  // 无限加载
  bool _enableInfiniteLoad = true;
  // 控制结束
  bool _enableControlFinish = false;
  // 任务独立
  bool _taskIndependence = false;
  // 震动
  bool _vibration = true;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;
  // 顶部回弹
  bool _topBouncing = true;
  // 底部回弹
  bool _bottomBouncing = true;
  String _updatedTime = '';

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
    _updatedTime = _getDateTime();
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    if (userDetail == null) {
      return Text('加载中');
    }
    return Scaffold(
      appBar: _getAppBar(),
      body: _getRefresh(),
      backgroundColor: Color.fromRGBO(112, 136, 255, 1),
    );
  }

  Widget _getRefresh() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.9, -1.2), // near the top right
          radius: 0.6,
          colors: [
            const Color.fromRGBO(175, 225, 255, 1), // yellow su
            Colors.white, // blue sky
          ],
          stops: [0.4, 1.0],
        ),
        shape: BoxShape.rectangle,
        color: Colors.white,
        // padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      height: double.infinity,
      child: EasyRefresh.custom(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        taskIndependence: _taskIndependence,
        controller: _controller,
        scrollController: _scrollController,
        topBouncing: _topBouncing,
        bottomBouncing: _bottomBouncing,
        header: ClassicalHeader(
          refreshText: '下拉刷新',
          refreshingText: '正在刷新',
          refreshReadyText: '释放立即刷新',
          refreshedText: '刷新完成',
          infoText: '上次更新 ${_updatedTime}',
          enableInfiniteRefresh: false,
          bgColor: _headerFloat ? Theme.of(context).primaryColor : null,
          infoColor: _headerFloat ? Colors.black87 : Colors.teal,
          float: _headerFloat,
          enableHapticFeedback: _vibration,
        ),
        footer: ClassicalFooter(
          loadingText: '正在加载',
          noMoreText: '没有更多了',
          showInfo: false,
          enableInfiniteLoad: _enableInfiniteLoad,
          enableHapticFeedback: _vibration,
        ),
        onRefresh: _enableRefresh
            ? () async {
                await Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    _count = 20;
                  });
                  if (!_enableControlFinish) {
                    _controller.resetLoadState();
                    _controller.finishRefresh();
                    _updatedTime = _getDateTime();
                  }
                });
              }
            : null,
        onLoad: _enableLoad
            ? () async {
                await Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    _count += 20;
                  });
                  if (!_enableControlFinish) {
                    _controller.finishLoad(noMore: _count >= 80);
                  }
                });
              }
            : null,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(children: [
                  _getList(index),
                  index != 19 ? Divider() : Text('')
                ]);
              },
              childCount: _count,
            ),
          ),
        ],
      ),

      ///
    );
  }

  String _getDateTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-dd HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  Widget _getAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(AssetImage("assets/images/arrow.png"), size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      backgroundColor: Color.fromRGBO(112, 136, 255, 1),
      elevation: 0.0,
      centerTitle: true,
      title: Text('我的守护'),
    );
  }

  TextStyle _getTextStyle(double size, {Color color}) {
    return TextStyle(
        fontSize: size,
        color: color,
        decoration: TextDecoration.none,
        height: 1.4);
  }

  Widget _getList(int index) {
    var i = index;
    if (index >= 5) {
      i = 0;
      i++;
    }
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/${i + 1}.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('迪丽冻吧啦',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontFamily: 'PingFangSC-Regular,PingFang SC;')),
                      Image.asset('assets/images/vip.png',
                          width: 23.0, height: 14.0, fit: BoxFit.fill),
                    ]),
                Text('2020年3月30日到期',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.5),
                        decoration: TextDecoration.none,
                        fontFamily: 'PingFangSC-Regular,PingFang SC;')),
              ]),
        ),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(60.0),
            image: DecorationImage(
                image: AssetImage('assets/images/weibo.png'),
                fit: BoxFit.cover),
          ),
        ),
      ],
    ));
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
