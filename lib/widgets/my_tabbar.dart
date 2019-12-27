import 'package:flutter/material.dart';
import 'package:flutterdemo/model/topten.dart';
import 'package:flutterdemo/api/list.dart';
import 'package:flutterdemo/widgets/toptenlist.dart';
import 'package:flutterdemo/pages/timeline.dart';

final API _api = API();

class MyTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTabBarrState();
  }
}

class MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _pushSaved() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            IconButton(icon: Icon(Icons.message), onPressed: _pushSaved),
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
          )),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Center(child: Timeline()),
        Center(child: ToptenList()),
        Center(child: Text('汽车')),
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
