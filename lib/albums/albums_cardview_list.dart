import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_painter.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsListState();
  }
}

class _AlbumsListState extends State<AlbumsList> with TickerProviderStateMixin {
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
  List flagsList = [false, false, false, false, false];

  ///item cell
  Widget _albumItemBuilder(final String headImageUrl, final String titleText,
      final String subTitleText, final int index) {
    return GestureDetector(
      onTap: () {
//        flagsList[index] = !flagsList[index];
//        setState(() {});
      },
      child: Container(
        height: 110,
        //内边距
        padding: EdgeInsets.all(1),
        child: Card(
          child: Row(
            //对齐方式
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //弹性布局
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      headImageUrl,
                      fit: BoxFit.fill,
                      width: 80,
                      height: 80, //图片高度
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(titleText),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      subTitleText,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.surround_sound,
                            size: 20, color: Colors.orangeAccent),
                        Text("播放量 10000"),
                        Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.orangeAccent,
                        ),
                        Text("订阅量 112"),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: flagsList[index],
                    onChanged: (value) {
                      flagsList[index] = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _albumsList() {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.8,
//      height: 600,
      child: ListView(
        children: <Widget>[
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group29/M05/00/14/wKgJXVlQ7vmBi-__AAFgYj4HfQ0789.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "每晚一个睡前故事",
              "啊~啊~困了吗！来吧，闭上你的眼睛，来听可乐姐姐专门为你讲的睡前故事吧，让我们一起进入甜美的梦乡~",
              0),
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group4/M02/11/BF/wKgDs1MoE13Cbd5aAADbM_v7Sf0531.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "宝宝经典儿歌",
              "网趣宝贝经典儿歌，是把中国最经典的儿歌制作成小朋友喜欢的童趣、可爱、诙谐的动漫，这样不仅能使宝贝的语言能力有很大提高，更能使他们的小头脑思维活跃。网趣儿歌是培养宝宝语言能力的最佳选择。",
              1),
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "睡前故事：一千零一夜",
              "儿童读物,儿童故事,童话,睡前故事,晚安故事",
              2),
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "《夜色钢琴曲》",
              "咖啡,日韩,流行,纯音乐,钢琴曲",
              3),
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group28/M03/97/CD/wKgJSFlJClGSLIgiAAPirlGyzwg510.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "现代诗歌",
              "现代诗歌集锦，一次收齐经典",
              4),
          _albumItemBuilder(
              "http://imagev2.xmcdn.com/group28/M03/97/CD/wKgJSFlJClGSLIgiAAPirlGyzwg510.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
              "现代诗歌",
              "现代诗歌集锦，一次收齐经典",
              4),
          //
        ],
      ),
    );
  }

  Widget _albumsBuilder() {
    return Container(
      child: ListView(
        children: <Widget>[
          _albumsList(),
        ],
      ),
    );
  }

  ///
  Widget _widgetAlbumsPlayer() {
    return Container(
      //控制唱片的大小
      width: 100.0,
      height: 100.0,
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
              borderRadius: BorderRadius.circular(40.0), // 圆角
              child: FloatingActionButton(
                onPressed: () {
                  print("controlPlay...");
                  controlPlay();
                },
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      //圆弧处理
                      borderRadius: BorderRadius.circular(30.0),
                      child:
                          Image.asset("assets/images/black-disk.png"), //唱片的背景图
                    ),
                    Container(
                      //内图片的的尺寸
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        //圆弧处理
                        borderRadius: BorderRadius.circular(40.0),
                        // 唱片内部的图片
                        child: Image.network(
                          "http://imagev2.xmcdn.com/group4/M02/11/BF/wKgDs1MoE13Cbd5aAADbM_v7Sf0531.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png",
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
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

//
//  Widget _widgetAlbumsPlayer() {
////    setState(() {
////
////    });
//    return Container(
//      //控制唱片的大小
//      width: 80.0,
//      height: 80.0,
//      child: RotationTransition(
//        alignment: Alignment.center,
//        turns: animation,
//        child: new CustomPaint(
//          foregroundPainter: new MyPainter(
//              lineColor: Colors.black45,
//              completeColor: Colors.red,
//              // completePercent: percentage,
//              completePercent: percentage,
//              width: 5),
//          child: new Padding(
//            padding: const EdgeInsets.all(2.0),
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(40.0), // 圆角
//              child: FloatingActionButton(
//                onPressed: () {
//                  print("controlPlay...");
//                  controlPlay();
//                },
//                child: Image.asset("assets/images/truck.png"),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//

  @override
  void initState() {
    super.initState();
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
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
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

  ///快退
  void fastRewindPlay() {
    if (newPercentage == 0 || processBarValue == 0) {
      return;
    }
    setState(() {
      percentage = newPercentage;
      newPercentage -= 5;
      if (newPercentage <= 0) {
        percentage = 0.0;
        newPercentage = 0.0;
      }
      percentageAnimationController.reverse(from: 0.0);
      //
      processBarValue = newPercentage * 0.01;
      print("percentage=${percentage}");
      print("newPercentage=${newPercentage}");
      print("processBarValue=${processBarValue}");
    });
  }

  /// 快进
  void fastForwardPlay() {
    if (newPercentage == 100 || processBarValue == 1) {
      return;
    }
    setState(() {
      percentage = newPercentage;
      newPercentage += 5;
      if (newPercentage > 100.0) {
        percentage = 100.0;
        newPercentage = 100.0;
      }
      percentageAnimationController.forward(from: 0.0);
      //
      processBarValue = newPercentage * 0.01;
      print("percentage=${percentage}");
      print("newPercentage=${newPercentage}");
      print("processBarValue=${processBarValue}");
    });
  }

  ///拖动改变进度
  void changePlayProcess(final double precess) {
    setState(() {});
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

  ///
  void sliderChangePlay(double val) {
    setState(() {
      processBarValue = val * 0.01;
      percentage = val;
//      print("processBarValue== ${processBarValue}");
    });
  }

  ///
  Widget _bottomBar() {
    return Container(
//      color: Colors.white,
      height: 50,
      child: Column(
        children: <Widget>[
          // 线性进度条高度指定为3
          SizedBox(
            height: 10,
            child: Slider(
              min: 0.0,
              max: 100.0,
              value: processBarValue * 100,
              onChanged: sliderChangePlay,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //快退
                IconButton(
                  icon: Icon(Icons.fast_rewind),
                  onPressed: () {
                    fastRewindPlay();
                  },
                ),
                //返回前一首
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                // 播放，暂停
                IconButton(
                  //判断是否播放中，返回不同按钮状态
                  icon: playFlag == true
                      ? Icon(Icons.stop) //暂停
                      : Icon(Icons.play_arrow, color: Colors.red), // 播放
                  onPressed: () {
                    setState(() {});
                    controlPlay();
                  },
                ),
                //一下首
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {},
                ),
                // 快进
                IconButton(
                  icon: Icon(Icons.fast_forward),
                  onPressed: () {
                    fastForwardPlay();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<dynamic> pickList = flagsList.where((e) => (e == true));
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () {
//          print("添加播放进度");
//          setState(() {
//            fastForwardPlay();
//          });
//        },
//      ),
      backgroundColor: Colors.grey,
      bottomSheet: _bottomBar(),
      appBar: AppBar(
        actions: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: <Widget>[
                    Text("${pickList.length} pick"),
                    IconButton(
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        centerTitle: true,
        title: Text("专辑"),
      ),
      body: Container(
        child: new Stack(
          //Alignment.center会居中显示
          alignment: Alignment.center,
          children: <Widget>[
            _albumsBuilder(),
            Positioned(
              bottom: 80,
              child: _widgetAlbumsPlayer(),
            )
          ],
        ),
        // child: _albumsBuilder(),
      ),
    );
  }

  @override
  dispose() {
    albumController.dispose();
    super.dispose();
  }
}
