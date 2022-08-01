
//Material是一种标准的移动端和web端的视觉设计语言
//Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性
//widget的主要工作是提供一个build()方法来描述如何根据其他较低级别的widget来显示自己

// 导入相关的控件(material:材料)
import 'package:flutter/material.dart';
// 导入电影列表页面
import './movie/list.dart';

// 入口函数
void main() {
  runApp(MyApp());
}

// 无状态控件（纯展示，无私有数据和业务逻辑），有状态控件（有私有数据和业务逻辑）
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 每个项目最外层，必须有MaterialApp
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // 通过Home指定首页
      // home: new MyHome(),
      // 在flutter中 new 可以省略
      home: MyHome(),
    );
  }
}

// 自定义MyHome类
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在flutter中，每个控件都是一个类
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          // 导航条
          appBar: AppBar(
            title: Text('电影列表~'),
            centerTitle: true,
            // 右侧行为按钮
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          // 抽屉（侧边栏）
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('酸奶'),
                  accountEmail: Text('517314473@qq.com'),
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316')),
                  // 美化当前控件的
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        'http://www.liulongbin.top:3005/images/bg1.jpg'),
                    fit: BoxFit.cover,
                  )),
                ),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(Icons.feedback),
                ),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('我要发布'),
                  trailing: Icon(Icons.send),
                ),
                // 分割线控件
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          // 底部的tabBar
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            height: 50,
            child: TabBar(
                labelStyle: TextStyle(
                  height: 0,
                  fontSize: 10,
                ),
                tabs: <Widget>[
                  Tab(
                    text: '正在热映',
                    icon: Icon(Icons.movie_filter),
                  ),
                  Tab(
                    text: '即将上映',
                    icon: Icon(Icons.movie_creation),
                  ),
                  Tab(
                    text: 'Top250',
                    icon: Icon(Icons.local_movies),
                  ),
                ]),
          ),
          // 页面主体区域
          body: TabBarView(children: <Widget>[
            MovieList(mt: 'in_theaters'),
            MovieList(mt: 'coming_soon'),
            MovieList(mt: 'top250'),
          ]),
        ));
  }
}
