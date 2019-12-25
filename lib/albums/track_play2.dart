import 'dart:ui';

import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter/material.dart';

Albums _albums;
Tracks _tracks;

///专辑明细
class TrackItemPlay2 extends StatefulWidget {
  final Tracks tracks;
  final Albums albums;

  // @required 必须带带参数
  const TrackItemPlay2({Key key, @required this.tracks, @required this.albums})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //断言不为空
    assert(tracks != null);
    assert(albums != null);
    _albums = this.albums;
    _tracks = this.tracks;
    return _TrackItemPlayState();
  }
}
//
//final url = "${_albums.coverUrlMiddle}";
//final imageProvider = NetworkImage(url);
//final imageProvider2 = AssetImage('assets/images/bg01.jpeg');

class _TrackItemPlayState<Albums> extends State<TrackItemPlay2>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  Widget _ablumConver() {
    return Container(
//      color: Color.fromARGB(10, 36, 28, 28),
      alignment: Alignment.center,
      width: 150,
      height: 150,
      child: ClipRRect(
        //圆角
        borderRadius: BorderRadius.circular(6.0),
        child: Image.network(
          "${_albums.coverUrlMiddle}",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _header() {
    return SliverAppBar(
//      backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
//            color: Color.fromARGB(200, 40, 84, 140),
            image: DecorationImage(
              image: new AssetImage('assets/images/bg01.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(0.0), //容器内补白
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: _ablumConver(),
              ),
              SizedBox(
                height: 50,
                child: Text(
                  '${_tracks.title}',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              // 线性进度条高度指定为3
              SizedBox(
                height: 5,
                child: _widgetProcessBar(),
              ),
              SizedBox(
                height: 50,
                child: _widgetPlayBar(), //_widgetPlayBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetProcessBar() {
    return Slider(
      value: 29,
      max: 100.0,
      min: 0.0,
      activeColor: Colors.white,
      inactiveColor: Colors.grey,
      onChanged: (double val) {
        this.setState(() {});
      },
    );
  }

  Widget _widgetPlayBar() {
    return Container(
//      height: 80,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.reorder, color: Colors.white),
            onPressed: () {},
          ),

          //返回前一首
          IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () {},
          ),
          // 播放，暂停
          IconButton(
            //判断是否播放中，返回不同按钮状态
            icon: Icon(Icons.play_arrow, color: Colors.white), // 播放
            onPressed: () {
              print("play...");
            },
          ),
          //一下首
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.timer, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _body() {
    //List
    return new SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //创建列表项
          return new Container(
            alignment: Alignment.center,
            color: Colors.grey,
            child: new Text('list item $index'),
          );
        },
        childCount: 20,
      ),
    );
  }

  ///
  Widget _viewBuild() {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          _header(),
          _body(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _viewBuild(),
    );
  }
}
