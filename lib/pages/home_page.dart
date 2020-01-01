import 'package:flutter/material.dart';
import 'package:flutterdemo/model/topten.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/pages/topten_list.dart';
import 'package:flutterdemo/pages/timeline.dart';
import 'package:flutterdemo/pages/board.dart';
import 'package:flutterdemo/pages/protector.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutterdemo/demo/file_picker_demo.dart';
import 'package:flutter/widgets.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<String> _tabs = ['时间线', '今日十大', '收藏版面'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  void _pushSaved() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Center(child: Timeline()),
        Center(child: ToptenList()),
        Center(child: Boardsection()),
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FilePickerDemo();
          }));
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Protector(id: 'wbzhou');
          // }));
        },
      ),
      backgroundColor: Colors.white,
      drawer: _getDrawer(),
      //右侧边栏
      endDrawer: Drawer(
        child: Text("右侧侧边栏"),
      ),
    );
  }
  _getAppBar() {
    return AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text('北邮人论坛'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: _pushSaved),
          IconButton(
              icon: Icon(IconData(0xe630, fontFamily: 'MyIcons'),
                  size: 22, color: Colors.white),
              onPressed: _pushSaved),
        ],
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Material(
            color: Colors.grey[200],
            child: TabBar(
              // indicator: ColorTabIndicator(Colors.black),//选中标签颜色
              indicatorColor: Colors.blue, //选中下划线颜色,如果使用了indicator这里设置无效
              controller: _tabController,
              labelColor: Colors.black,
              // unselectedLabelColor: Colors.yellow,
              tabs: _tabs
                  .map((item) => Tab(
                        text: item,
                      ))
                  .toList(),
            ),
          ),
        ));
  }

  Widget _getDrawer() {
    return Drawer(
        child: Column(children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    NetworkImage("https://www.itying.com/images/flutter/2.png"),
                fit: BoxFit.cover)),
      ),
      Row(children: <Widget>[
        Expanded(
            child: DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.itying.com/images/flutter/2.png"),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.itying.com/images/flutter/2.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text('wbzhou1992',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, height: 1.5)),
                      Row(children: [
                        Text('是前一棵大白菜',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                height: 1.5)),
                        IconButton(
                          padding: const EdgeInsets.only(right: 8.0),
                          icon: Icon(Icons.expand_more,
                              color: Colors.grey, size: 20),
                          onPressed: () {},
                        ),
                      ]),
                    ]))),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(children: [
          Icon(Icons.home, color: Colors.grey, size: 30),
          Text(
            '关注',
            style: TextStyle(height: 1.5, fontSize: 18),
          )
        ]),
        Column(children: [
          Icon(Icons.home, color: Colors.grey, size: 30),
          Text(
            '关注',
            style: TextStyle(height: 1.5, fontSize: 18),
          )
        ]),
        Column(children: [
          Icon(Icons.home, color: Colors.grey, size: 30),
          Text('关注', style: TextStyle(height: 1.5, fontSize: 18)),
        ])
      ]),
      Divider(),
      ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.home),
        ),
        title: Text("投票", style: TextStyle(height: 1.5, fontSize: 18)),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.home),
        ),
        title: Text("竞猜", style: TextStyle(height: 1.5, fontSize: 18)),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.home),
        ),
        title: Text("分区", style: TextStyle(height: 1.5, fontSize: 18)),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.people),
        ),
        title: Text("设置", style: TextStyle(height: 1.5, fontSize: 18)),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.settings),
        ),
        title: Text("夜间", style: TextStyle(height: 1.5, fontSize: 18)),
      ),
    ]));
  }
}
