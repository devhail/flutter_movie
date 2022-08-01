import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  // 固定写法
  // MovieList({Key key}) : super(key:key);

  // 电影类型
  // final：用于修饰变量，表示单赋值（single-assignment）
  // 使用final修饰的变量必须进行初始化，一旦被赋值之后，不能够再次被赋值,否则编译会报错。
  final String mt;
  MovieList({Key key, @required this.mt}) : super(key: key);

  @override
  _MovieListState createState() {
    return new _MovieListState();
  }
}

// 有状态控件必须结合一个状态管理类来进行实现
class _MovieListState extends State<MovieList> with AutomaticKeepAliveClientMixin {
  // 默认显示第一页数据
  int page = 1;
  // 每页显示的数据条数
  int pagesize = 10;
  // 电影列表数据
  var mlist = [];
  // 总数据条数，实现分页效果
  int total = 0;

   //保持当前的状态（列如滚动位置等）
  @override
  bool get wantKeepAlive => true;

  // 控件被创建的时候会执行 initState (生命周期函数)
  @override
  void initState() {
    super.initState();
    print('---initState--start');
    getMovieList();
    print('---initState--end');
  }

  // 渲染当前这个MovieList控件的UI结构
  @override
  Widget build(BuildContext context) {
    print('---build--count=' + mlist.length.toString());
    return ListView.builder(
      itemCount: mlist.length,
      itemBuilder: (BuildContext ctx, int i) {
        var mitem = mlist[i];
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ctx) {
              return MovieDetail(
                id:mitem['id'] ,
                title: mitem['title'],
              );
            }));
          },
          child: Container(
            height: 200,
            // 加分割线
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12),
              ),
            ),
            child: Row(
              // 水平布局
              children: <Widget>[
                Image.network(
                  // mitem['images']['medium'],
                  'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2546363876.webp',
                  width: 130,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 200,
                  child: Column(
                    // 垂直布局
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('电影名称：' + mitem['title']),
                      Text('上映年份：' + mitem['year'].toString() + '年'),
                      Text('电影类型：' + mitem['genres'].join('，')),
                      Text('豆瓣评分：' +
                          mitem['rating']['average'].toString() +
                          '分'),
                      Text('电影名称：' + mitem['title']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //从网络上获取电影列表数据
  getMovieList() async {
    print('---getMovieList');
    // 计算偏移量
    int offset = (page - 1) * pagesize;
    String url =
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize';
    print('---http--start');
    var response = await dio.get(url);
    // 服务器返回的数据
    var result = response.data;
    print(result);
    print('---http--end');

    // 只要为私有数据赋值，都需要把赋值的操作放到 setState 函数中，否则页面不会更新
    setState(() {
      mlist = result['subjects'];
      total = result['total'];
      print('---setState');
    });
  }
}

// 执行顺序
// 1 ---initState
// 2 ---build
// 3 ---setState

// flutter: ---initState--start
// flutter: ---getMovieList
// flutter: ---http--start
// flutter: ---initState--end
// flutter: ---build--count=0
// flutter: ---http--end
// flutter: ---setState
// flutter: ---build--count=10
