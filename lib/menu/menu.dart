import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_himalaya/albums/albums_cardview_list.dart';
import 'package:flutter_himalaya/albums/my_painter.dart';
import 'package:flutter_himalaya/me/me_page.dart';
import 'package:flutter_himalaya/menu/expand_down_menu.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPageStateful();
  }
}

class _MenuPageStateful extends State<MenuPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

//动画控制器
  AnimationController albumController;

  bool playFlag = false;

//进度条
  AnimationController percentageAnimationController;
  Animation animation;
  double sliderProcessValue = 0;
  double processBarValue = 0.0;

  ///唱片进度
  double percentage = 0.0;
  double newPercentage = 0.0;

  final List<Widget> _children = [
    AlbumsList(),
    AlbumsList(),
    AlbumsList(),
    AlbumsList()
  ];

  void initAnimationController() {
    percentage = 0.0;

    percentageAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {
          percentage = lerpDouble(
              percentage, newPercentage, percentageAnimationController.value);
        });
      });
    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.

    albumController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
//    animation = Tween(begin: 0.0, end:0.5).animate(controller);
    animation = Tween(begin: 0.0, end: 1.0).animate(albumController);

//    /动画开始、结束、向前移动或向后移动时会调用StatusListener
    albumController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
//        print("status is completed");
        //重置起点
        albumController.reset();
        //开启
        albumController.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
//        print("status is dismissed");
      } else if (status == AnimationStatus.forward) {
//        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
//        print("status is reverse");
      }
      setState(() {});
    });
    //开启
    albumController.forward();
  }

  @override
  void initState() {
    super.initState();
    initAnimationController();
  }

  ///
  Widget _albumsPlayer() {
    return new Container(
      padding: EdgeInsets.only(top: 10),
      //控制唱片的大小
      width: 60.0,
      height: 60.0,
      child: RotationTransition(
        alignment: Alignment.center,
        turns: animation,
        child: new CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.black45,
              completeColor: Colors.deepOrangeAccent,
              // completePercent: percentage,
              completePercent: percentage,
              width: 5),
          child: new Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0), // 圆角
              child: FloatingActionButton(
                onPressed: () {
                  print("controlPlay...");
                  controlPlay();
                },
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      child: ClipRRect(
                        //圆弧处理
                        borderRadius: BorderRadius.circular(5.0),
                        child: playFlag == true
                            ? Image.asset("assets/images/pause.png")
                            : Image.asset("assets/images/play.png"),
                        //hart的背景图,
                      ),
                    ),
                  ],
                ),
                //Image.asset("assets/images/truck.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
      //backgroundColor: Colors.orange
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      title: Text('订阅'),
      //backgroundColor: Colors.orange
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.music_video),
      title: Text('Music'),
      //backgroundColor: Colors.orange
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Me'),
      //backgroundColor: Colors.orange
    ),
  ];

  ///暂停
  void stop() {
    albumController.stop();
  }

  ///播放
  void play() {
    albumController.forward();
  }

  ///点击唱片控制运行
  void controlPlay() {
    setState(() {
      playFlag = !playFlag;
      if (playFlag) {
        stop();
      } else {
        play();
      }
    });
  }

  Widget _widgetBottom() {
    return Container(
      color: Colors.white,
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 15,
                child: Icon(
                  Icons.home,
                  size: 20,
                ),
              ),
              Text(
                "首页",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              _albumsPlayer(),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 15,
                child: Icon(
                  Icons.person,
                  size: 20,
                ),
              ),
//              Icon(
//                Icons.person,
//                size: 20,
//              ),
              Text(
                "我",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: AlbumsList(),
//        //
//        bottomNavigationBar: new ButtonBar(
//          children: <Widget>[
//            //_widgetContent(),
//            //
//            _widgetBottom(),
//          ],
//        ));
//  }

  //MePage

  ///onTabPageRoute
  void onTabPageRoute() {
    ///ReportPage
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ExpandDownMenuPage();
      // return new MePage();
    }));
    print("me..");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//          //悬浮按钮
//          child: Icon(Icons.music_video),
//          onPressed: () {}),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _albumsPlayer(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          children: [
            IconButton(icon: Icon(Icons.home)),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.person),
              onPressed: onTabPageRoute,
            ),
          ],
        ),
      ),
      body: AlbumsList(),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: _albumsPlayer(),
//      bottomNavigationBar: BottomNavigationBar(
//        backgroundColor: Colors.white70,
//        selectedFontSize: 12,
//        unselectedFontSize: 12,
//        items: [
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
//          BottomNavigationBarItem(icon: Icon(null), title: Text('')),
//          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('B')),
//        ],
//      ),
//    );
//  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
