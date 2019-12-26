import 'package:flutter/material.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/pages/article_detial.dart';

class BoardList  extends StatefulWidget{
  BoardList({Key key}):super(key:key);
  @override
   State<StatefulWidget> createState() {
    return BoardListState();
  }
}

class BoardListState extends State<BoardList>  with AutomaticKeepAliveClientMixin{
  var lists = [];
  var colorList = [Colors.green[400],Colors.blue[400],Colors.lightGreen,Colors.red[400],Colors.grey[400],Colors.pink[400],Colors.brown[400],Colors.blueGrey[400],Colors.orange[400],Colors.red[100],Colors.indigo];

  @override
  void initState() {
    super.initState();
    requestAPI();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody()
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
      title: Text("分区列表"),
      backgroundColor: Colors.blue,
    );
  }

  Widget _getBody() {
    if(lists.length == 0) return Text('');
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top:10,bottom:10),
      itemCount: lists.length,
      itemBuilder: (BuildContext context, int index){
        var bean = lists[index];
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
          child: Row(
            children:[
              Container(
                width: 50,
                height: 68,
                margin: EdgeInsets.only(left:20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorList[index],
                ),
                child: Center(
                  child:Text(bean['name'].substring(0,1), style: TextStyle(color:Colors.white,fontSize:20))
                )
              ),
              Padding(
                padding: EdgeInsets.only(right: 20,left:20),
                child: Text(bean['name'], style: TextStyle(color:Colors.black,fontSize:20)),
              ),
              Text(bean['desc'], style: TextStyle(color:Colors.grey,fontSize:16)),
            ]
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.BOARDS);
    var resultList = result['data']['boards'];
    setState(() {
      lists = resultList;
    });
  }
  @override
  bool get wantKeepAlive => true;
}

