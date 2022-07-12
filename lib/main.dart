// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScaffoldRoute());
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("App Name"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Cupertino Demo"),
            ),
            child: Center(
              child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text("Press"),
                  onPressed: () {}),
            ),
          ),
          MyTabbarView1(),
          FutureBuilderRoute(),
        ],
      ),
      drawer: MyDrawer(), //抽屉
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        // ignore: prefer_const_literals_to_create_immutables
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          // ignore: duplicate_ignore, duplicate_ignore
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              icon: Icon(Icons.school),
              title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/pic1.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTabbarView1 extends StatefulWidget {
  const MyTabbarView1({Key? key}) : super(key: key);

  @override
  _MyTabbarView1State createState() => _MyTabbarView1State();
}

class _MyTabbarView1State extends State<MyTabbarView1>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ['新闻', '热点', '校园'];
  late TabController tabController;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TabbarView',
          textAlign: TextAlign.center,
        ),
        bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const UnderlineTabIndicator(),
            controller: tabController,
            tabs: tabs.map((e) {
              return Tab(
                text: e,
              );
            }).toList()),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: TabBarView(
                controller: tabController,
                children: tabs.map((e) {
                  return NewWidget(e);
                }).toList()),
          )
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget(
    String e, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return newslist();
            }));
  }
}

class newslist extends StatelessWidget {
  const newslist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Image.network(
            "https://n.sinaimg.cn/spider20220711/737/w978h559/20220711/59ea-fbfc5aa1b649a97ea31173be592e99db.png"),
        title: Text(
          '斯里兰卡国家破产，布林肯果然“甩锅”俄罗斯',
          maxLines: 2,
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
        subtitle: Text(
          '（观察者网讯）在经过数月的经济动荡后，南亚岛国斯里兰卡日前正式宣布“国家破产”，成千上万的抗议者冲入首都科伦坡的总统府和秘书处，要求国家领导人下台。',
          maxLines: 3,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return NewRoute(receiver: '斯里兰卡国家破产，布林肯果然“甩锅”俄罗斯');
          }),
        );
      },
    );
  }
}

class NewRoute extends StatelessWidget {
  String receiver;
  NewRoute({Key? key, required this.receiver}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news1"),
      ),
      body: Column(
          //显式指定对齐方式为左对齐，排除对齐干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Image.network(
                  "https://n.sinaimg.cn/spider20220711/737/w978h559/20220711/59ea-fbfc5aa1b649a97ea31173be592e99db.png"),
            ),
            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                    '（观察者网讯）在经过数月的经济动荡后，南亚岛国斯里兰卡日前正式宣布“国家破产”，成千上万的抗议者冲入首都科伦坡的总统府和秘书处，要求国家领导人下台。但不出意料地是，当地时间7月10日，正在泰国访问的美国国务卿布林肯将斯里兰卡的局势动荡“甩锅”给俄罗斯，声称这一局面可能是由俄罗斯“封锁乌克兰粮食出口”所促成。')),
          ]),
    );
  }
}

class FutureBuilderRoute extends StatefulWidget {
  const FutureBuilderRoute({Key? key}) : super(key: key);

  @override
  _FutureBuilderRouteState createState() => _FutureBuilderRouteState();
}

// ignore: unused_element
class _FutureBuilderRouteState extends State<FutureBuilderRoute> {
  // ignore: prefer_final_fields
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                    .toList(),
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
