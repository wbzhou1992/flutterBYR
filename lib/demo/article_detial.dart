import 'package:flutter/material.dart';
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
  var articleDetail = [];
  var articleAll;
  var popularReplies = [];
  final colorList = [Colors.green[400],Colors.blue[400],Colors.lightGreen,Colors.red[400],Colors.indigo,Colors.pink[400],Colors.brown[400],Colors.blueGrey[400],Colors.orange[400],Colors.red[100]];
  @override
  void initState(){
    super.initState();
    requestAPI();
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
        IconButton(icon: Icon(Icons.star_border,color: Colors.white,)),
        IconButton(icon: Icon(Icons.share,color: Colors.white,)),
        IconButton(icon: Icon(Icons.more_vert,color: Colors.white,)),
      ],
      backgroundColor: colorList[colorIndex],
    );
  }
  Widget _getBody(){
    return _getSingleChildScrollView();
  }

  Widget _getSingleChildScrollView() {

    var user = {
      'userName': userDetail['poster']['user_name'],
      'avatar': userDetail['poster']['face_url'],
      'time': userDetail['time'],
      'thumbUp': userDetail['voteup_count'],
      'thumbDown': userDetail['votedown_count']
    };
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _getUserDetail(10.0,user),
                _getArticelDetail(context),
                Container(
                  alignment: Alignment(-1.0, 0),
                  margin: const EdgeInsets.only(left: 20,top: 20,bottom: 14),
                  child: Text(
                    '--',
                    textAlign: TextAlign.left,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,bottom:14),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child:Icon(Icons.favorite,color: Colors.red,size:16),
                      ),
                      Text(
                        '精彩回复',
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
                ),
                _getPopularReplies()
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _getUserDetail(var padding,var user) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getImage(user['avatar']),
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
                  style: TextStyle(color: Colors.grey,fontSize:12)
                ),
                Container(
                  width: 28,
                  margin:  const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    padding:const EdgeInsets.only(left:1.0,bottom: 2.0),
                    icon: Icon(Icons.thumb_up, color: Colors.grey,size:15)
                  ),
                ),
                Text(
                  '楼主',
                  style: TextStyle(color: Colors.grey,fontSize:12)
                ),
                Container(
                  width: 28,
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
  Widget _getImage(String avatar) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
            image: NetworkImage(avatar),
            fit: BoxFit.cover),
      ),
    );
  }
  Widget _getArticelDetail(context) {
    var content = articleDetail[0]['content'];
    var title = articleAll['title'];
    // var content = '之前是希望自己工作稳定之后，能遇到合适的人，但是工作后圈子也越来越固定，接触到的异性朋友有限，来论坛试试运气，征不到就顺其自然，或者交给朋友和爸妈了<br/><br/><br/>1、关于自己<br/>92年11出生，裸高169，体重67kg浮动。<br/>北邮本硕，18年毕业，目前在望京上班，从事算法开发工作，收入尚可。<br/>性格乐观沉稳，坚持运动，坚持吃早饭，发际线正常，不抽烟，不近视。<br/><br /><a target="_blank" href="/att/Friends/1947344/366512">单击此查看原图(205.2KB)</a><br /><img border="0" src="/att/Friends/1947344/366512/middle" alt="3.jpg" class="resizeable" title="3.jpg"/><br/><br /><a target="_blank" href="/att/Friends/1947344/657547">单击此查看原图(203KB)</a><br /><img border="0" src="/att/Friends/1947344/657547/middle" alt="5.jpg" class="resizeable" title="5.jpg"/><br/><br/><br/>2、关于家庭<br/>来自江西小乡村的一个普通三口之家，家庭和睦，家境普通。老爸在省内务工，老妈是个老裁缝，思想开明。<br/>和大多数南方农村房子一样，独栋，前后带院，有禽有树，背靠青山，梯田环绕，假期回家不亚于一趟旅游。<br/>长期在外，一年回两三次家，平时也就周末和爸妈视频聊聊天。<br/>从大三拿到第一份暑假实习工资起，每年都会在老妈生日那天邮递一束花回去，就当是不能陪伴爸妈的一种补偿吧（老妈每次收到花都说费钱，转身就发朋友圈去了）。现在是计划每年错峰带父母出去玩一趟，去年去的云南，今年又来了次北京。<br/>虽然不能常伴爸妈左右，但是尽己所能去更新关于亲情生活的续集。<br/><br /><a target="_blank" href="/att/Friends/1947344/3638">单击此查看原图(181.8KB)</a><br /><img border="0" src="/att/Friends/1947344/3638/middle" alt="1.jpg" class="resizeable" title="1.jpg"/><br/><br /><a target="_blank" href="/att/Friends/1947344/189846">单击此查看原图(172.5KB)</a><br /><img border="0" src="/att/Friends/1947344/189846/middle" alt="2.jpg" class="resizeable" title="2.jpg"/><br/><br /><a target="_blank" href="/att/Friends/1947344/576617">单击此查看原图(79KB)</a><br /><img border="0" src="/att/Friends/1947344/576617/middle" alt="4.jpg" class="resizeable" title="4.jpg"/><br/><br/><br/>3、关于过去<br/>有些人祖上三代才是农民，而我是农民本人，插秧除草割稻，放牛采桑赶鸭。小学五一和十一假期，对我来讲都是“劳动节”，因为赶上农忙，除了完成作业还得干农活。家里就我一个孩子，集万千宠爱，也集各种农活。当然，除了面朝黑土背朝天的辛苦，童年的乐趣还是很富足的，小伙伴多，扛个锅去野炊，用地笼收小龙虾，晚上拿个手电筒和钳子去夹泥鳅，去河里游泳钓鱼，放风筝满田地地跑。小时候的生活，披星戴月，无拘无束。后来，就是很普通的去镇里、县里、北京读书，以及工作。每个阶段都过得很快，每个阶段都在开阔眼界，来不及消化就走向了下一个路口。一路走来最大的收获，一是知识，二是良师益友。每个阶段都幸运地结识到了一两个知心好友，有的已成家在小镇上班，有的在美帝深造，有的也在北京工作，平时各自忙碌，偶尔碰面或聊天也能相谈甚欢，互相开玩笑。<br/><br/>饮食生活方面，注重规律健康。起因是这样的，报考军校体检查出了胆囊结石，医生说能震碎但不能彻底清除，干脆直接把胆囊切除了。老妈总担心变成急性病，大一的寒假就把手术做了。虽然是个小手术，在医院只呆了一周，但是真的很痛苦（电视剧里都是骗人的），不想再因为疾病住院了，身体才是革命的本钱。手术恢复后，最开始的运动是在操场上跑步，断断续续，习惯之后坚持了下来，到如今差不都有八年的时间吧。考虑到保护膝盖，现在运动种类多一点，骑行、健身、游泳，每周差不多运动四次左右吧。现在的理念是，把花在感冒生病上的时间和钱，用在日常的锻炼上，还是很划算的。每天运动一小时，一个月也就30个小时；但是病一次都得好几天，人还蔫了。运动多了，身体抵抗力强，近几年都很少感冒。身体好，胃口好，继续保持。<br/><br/>在感情方面，有幸运，也有遗憾。幸运的是，曾经遇到过我喜欢的人，也遇到过喜欢我的人，互吐心声，虽有遗憾，但是不后悔吧，自己做到问心无愧。<br/><br/>小桥流水、农家小院的舒心，车水马龙、高楼大厦的舒适，都有体验。<br/>目前，空口一张嘴，无房无车，对未来有信心，期待能遇到另一半，在日常生活中能互相理解，互相包容，互生情愫吧。<br/><br/><br/>4、关于未来<br/>能力有限，毕业时也曾在户口和高薪之间犹豫过，每个人情况都不一样。喜欢大海，可以玩水玩沙，就像小时候玩水玩泥巴一样，于是暂时把户口迁到了深圳，一心赚钱了。可能自己考虑问题过于简单随性，就跟当时高考填志愿时不知道985、211，只知道清北复交厉害，然后凭差不多的分数报了北邮。很难判断选择正确与否，在十字路口遵从内心渴望和原则就好，剩下的认真努力就好了，虽然会走弯路，但是体验也不一样，正如马丁老爷子在冰火里写着“different roads sometimes lead to the same castle”。<br/><br/>朝着未知的终点，保持自驱力，保持平常心，现在的努力，都是给未来赢取选择权的筹码。<br/><br/><br/><br/>5、关于她<br/>希望她92年以后出生，本科及以上学历，南方女孩，乐观善良，孝敬父母。<br/>有自己的爱好，喜欢运动就更好了，一起为身体充值，为未来充值。<br/>目前还在北京发展，所以希望对方也在北京工作。<br/><br/><br/>6、联系方式<br/>byr_friend@163.com<br>--';
    RegExp exp = new RegExp(r'(href|src)\=\"(/att[/|\w|\d]*)\"');
    print('content $content');
    var con = content.replaceAllMapped(exp,(Match m){
      return '${m[1]}="https://bbs.byr.cn${m[2]}"';
    });
    // Iterable<Match> matches = exp.allMatches(content);
    // matches.toList().forEach((item) {
    //   con = 'https://bbs.byr.cn/n${item[2]}';
    //   print('MMMMMMMMMMM ${item[2]}');
    // });
    var markdown = html2md.convert(con);
    return Container(
      padding: EdgeInsets.only(right:20,left:20),
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

  Widget _getPopularReplies() {
    // var con = '看下面这个图，我好像在楼道里见过，确实还行<br/><br/>【 在 tobyme (涂布) 的大作中提到: 】<br/>: 有人认识乐队男主唱吗？感觉挺帅的，想认识一下<img src=\"/img/ubb/ema/3.gif\" alt=\"ema3\" style=\"display:inline;border-style:none\"/><br>--';
    // var deStr = con.replaceAll(RegExp(r'【 在(.*?)的大作中提到: 】'),'<p><br/><br/>');
    // var cont = con.replaceAllMapped(exp,(Match m){
    //   print('MMMMMM ${m[1]}');
    // });
    // print(con.split(exp));        // ['a', 'a']
    // var deStr = con.split(exp).join('<br /><blockquote>【 在(.*)的大作中提到: 】').replaceAll(RegExp(r'<br/>|<br>'),'')+'</blockquote>';
    // var deStr = con.split(exp).join('<br /><blockquote>【 在(.*)的大作中提到: 】').replaceAll(RegExp(r'<br/>|<br>'),'')+'</blockquote>';
    
            print('popularReplies ${popularReplies.length}');

    // print('MMMMMM $cont');
    // Iterable<Match> matches = exp.allMatches(content);
    // matches.toList().forEach((item) {
    //   con = 'https://bbs.byr.cn/n${item[2]}';
    //   print('MMMMMMMMMMM ${item[2]}');
    // });
    // var markdown = html2md.convert(deStr);
    return ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemCount: popularReplies.length,
      itemBuilder: (BuildContext context, int index){
        var currentUser = popularReplies[index]['poster'];
        var current = popularReplies[index];
        var content = current['content'];
        RegExp exp = new RegExp(r'(【 在(.*)的大作中提到: 】)');
        var conList = content.replaceAll(RegExp(r'<br/>|<br>|<br\s/>'),'\n').replaceAll(RegExp(r'<img(.*)?>|<href(.*)?>|-'),'').split(exp);
        var quto = '';
        var cont = content.replaceAllMapped(exp,(Match m){
        print('MMMM ${m[1]}');
          quto = m[1].isEmpty ? '' : m[1];
        });
        var user = {
          'userName': currentUser['id'],
          'avatar': currentUser['face_url'],
          'time': current['time'],
          'thumbUp': current['voteup_count'],
          'thumbDown': current['votedown_count']
        };
        if(quto != '') {
          _getReplyWithQuote(user, conList, quto);
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
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Divider()
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }

  Widget _getReplyWithQuote(var user, var conList,var quto){
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
              padding: EdgeInsets.only(left:10,right:10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      conList[0],
                      style: TextStyle(fontSize: 16,)
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
            //   child:MarkdownBody(
            //   onTapLink: (url){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return Container(
            //             width: 100,
            //             child: MyWebview(
            //                 url: url,
            //                 title: '浏览网页'
            //               )
            //             );
            //         }
            //       )
            //     );
            //   },
            //   data: markdown,
            //   styleSheet: MarkdownStyleSheet(
            //     blockquote: TextStyle(fontSize: 12,color: Colors.red)
            //   )
            // ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Future<Null> requestAPI() async {
    var _request = MockRequest();
    final Map result = await _request.get(API.ARTICLE);
    var user = result['data']['head'];
    var articles = result['data']['articles'];
    var article = result['data'];
    // print('user $user');
    print('articles ${articles}');
    setState(() {
      userDetail = user;
      articleDetail = articles;
      articleAll = article;
      popularReplies = result['data']['popularReplies'];
    });
  }

  getCommentList() {
    return Container(

    );
  }
}