import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsListState();
  }
}

class _AlbumsListState extends State<AlbumsList> with TickerProviderStateMixin {
  //动画控制器
  AnimationController controller;
  Animation animation;
  double percentage = 30.0;
  double newPercentage = 100.0;
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
      height: size.height,
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

  Widget _widgetAlbumsPlayer2() {
    return Container(
      //控制唱片的大小
      height: 100.0,
      width: 100.0,
      child: new CustomPaint(
        foregroundPainter: new MyPainter(
            lineColor: Colors.blueGrey,
            completeColor: Colors.redAccent,
            completePercent: percentage,
            width: 5),
        child: new Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0), // 圆角
            child: FloatingActionButton(
              onPressed: () {},
              // 唱片封面
              child: Image.network(
                "http://imagev2.xmcdn.com/group28/M03/97/CD/wKgJSFlJClGSLIgiAAPirlGyzwg510.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png",
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetAlbumsPlayer() {
    return Container(
      //控制唱片的大小
      height: 100.0,
      width: 100.0,
      child: RotationTransition(
        alignment: Alignment.center,
        turns: animation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60.0), // 圆角
          child: FloatingActionButton(
            onPressed: () {},
            // 唱片封面
            child: Image.network(
              "http://imagev2.xmcdn.com/group28/M03/97/CD/wKgJSFlJClGSLIgiAAPirlGyzwg510.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png",
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.

    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
//    animation = Tween(begin: 0.0, end:0.5).animate(controller);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

//    /动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //重置起点
        controller.reset();
        //开启
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
      setState(() {});
    });
    //开启
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Iterable<dynamic> pickList = flagsList.where((e) => (e == true));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.music_note),
        onPressed: () {},
      ),
      backgroundColor: Colors.grey,
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
              //_widgetAlbumsPlayer2
              //_widgetAlbumsPlayer
              child: _widgetAlbumsPlayer2(),
            )
          ],
        ),
        // child: _albumsBuilder(),
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  MyPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    double radius = min(size.width / 2, size.height / 2); //  半径
    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, //  从正上方开始
        arcAngle,
        false,
        complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
