import 'package:flutter/material.dart';
import 'package:flutterdemo/model/topten.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/pages/topten_list.dart';
import 'package:flutterdemo/pages/timeline.dart';
import 'package:flutterdemo/pages/board.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<String> _tabs = ['时间线','今日十大','收藏版面'];
  
  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  void _pushSaved() {

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _getAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(child: Timeline()),
          Center(child: ToptenList()),
          Center(child: Boardsection()),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: null,
      ),
      backgroundColor: Colors.white,
    );
  }
  _getAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text('北邮人论坛'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: _pushSaved),
        IconButton(icon: Icon(Icons.message), onPressed: _pushSaved),
      ],
      backgroundColor: Colors.blue,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Material(
          color: Colors.grey[200],
          child: TabBar(
            // indicator: ColorTabIndicator(Colors.black),//选中标签颜色
            indicatorColor: Colors.blue,//选中下划线颜色,如果使用了indicator这里设置无效
            controller: _tabController,
            labelColor: Colors.black,
            // unselectedLabelColor: Colors.yellow,
            tabs: _tabs.map((item)=>Tab(text: item,)).toList(),
          ),
        ),
      )
    );
  }
}