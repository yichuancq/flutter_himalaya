import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_himalaya/albums/albums_cardview_list.dart';
import 'package:flutter_himalaya/albums/hot_recommends.dart';
import 'package:flutter_himalaya/util/my_painter.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPageStateful();
  }
}

class _MenuPageStateful extends State<MenuPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController; //需要定义一个Controller

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

  int index = 0;

  buildBodyPage() {
    if (index == 0) {
      return AlbumsList();
    }
    if (index == 1) {
      //return HotRecommends();
    }
    if (index == 2) {
      return HotRecommends();
    }
  }

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
      padding: EdgeInsets.only(top: 5, bottom: 0),
      //控制唱片的大小
      width: 50.0,
      height: 50.0,
      child: RotationTransition(
        alignment: Alignment.center,
        turns: animation,
        child: new CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.white,
              completeColor: Colors.deepOrangeAccent,
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

  void onTabPageRoute() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new HotRecommends();
      // return new MePage();
    }));
    print("me..");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: _albumsPlayer(),
      body: buildBodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: index,
        onTap: (int index) {
          if (index != 1)
            setState(() {
              this.index = index;
            });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          // 动画按钮
          BottomNavigationBarItem(icon: _albumsPlayer(), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('推荐')),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
