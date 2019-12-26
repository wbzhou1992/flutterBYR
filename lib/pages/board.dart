import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterdemo/model/boardhome.dart';
import 'package:flutterdemo/model/banner.dart';
import 'package:flutterdemo/api/API.dart';
import 'package:flutterdemo/api/mock_request.dart';
import 'package:flutterdemo/pages/board_list.dart';

class Boardsection extends StatefulWidget{
  Boardsection({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() => BoardsectionState();
}
class BoardsectionState extends State<Boardsection> with AutomaticKeepAliveClientMixin{
  var boards;
  var banners;
  var colorList = [Colors.green[400],Colors.blue[400],Colors.lightGreen,Colors.red[400],Colors.grey[400],Colors.pink[400],Colors.brown[400],Colors.blueGrey[400],Colors.orange[400],Colors.red[100],Colors.indigo];

  @override
  void initState() {
    super.initState();
    requestAPI();
  }
  
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        _getBanner(),
        _getBoard()
      ]
    );
  }
   
  Widget _getBanner(){
    if(banners != null) {
      return Container(
        height: 100.0,
        child: Swiper(
          scale:0.8,
          fade:0.8,
          autoplay: true,
          itemBuilder: (BuildContext context,int index){
            return Image.network(banners[index]['image_url'],fit: BoxFit.fill,);
          },
          itemCount: banners.length,
          pagination: SwiperPagination(
            alignment: Alignment.bottomRight
          )
        ),
      );
    } else {
      return Text('');
    }
  }
  Widget _getBoard(){
    return Padding(
      padding: const EdgeInsets.only(left:10,top:10),
        child: Wrap(
          // spacing: 36.0, // 主轴(水平)方向间距
          runSpacing: 20.0, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.start, //沿主轴方向居中
          children: [
            ..._getChipList(),
            GestureDetector (
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BoardList();
                    }
                  )
                );
              },
              child: Container(
                child: Chip(
                  avatar: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0F0F0),
                    ),
                    child: Center(
                      child:Text('+', style: TextStyle(color:Colors.white,fontSize:20))
                    )
                  ),
                  backgroundColor: Colors.white,
                  label: Container(
                    height:46,
                    width:80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('添加新版面', style: TextStyle(color:Colors.grey,fontSize:16))
                      ]
                    )
                  )
                )
              )
            )
          ]
        )
    );
  }
  _getChipList(){
    List<Widget> chipList= [];
    int i = 0;
    if(boards != null){
      boards.forEach((board){
        var chip = Chip(
          avatar: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorList[i],
            ),
            child: Center(
              child:Text(board['desc'].substring(0,1),style: TextStyle(color:Colors.white,fontSize:20))
            )
          ),
          backgroundColor: Colors.white,
          label: Container(
            height:46,
            width:120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(board['desc'],style: TextStyle(color:Colors.black,fontSize:16,height:1.5)),
                Text('今日没有新帖',style: TextStyle(color:Colors.grey,fontSize:12,height:1.5)),
              ]
            )
          )
        );
        chipList.add(chip);
        i++;
      });
    } else {
      _buildProgressIndicator();
    }
    return chipList;
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
    );
  }
  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.BOARD);
    final Map banneRes = await _request.get(API.BANNER);
    var boardData = result['data']['boards'];
    var bannerData = banneRes['data']['banners'];
    setState(() {
      boards = boardData;
      banners = bannerData;
    });
  }
  @override
  bool get wantKeepAlive => true;
}