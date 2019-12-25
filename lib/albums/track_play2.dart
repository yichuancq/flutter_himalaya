import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/me/announcer_page.dart';
import 'package:flutter_himalaya/me/content_page.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/tracks.dart';

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
  ScrollController _scrollViewController;

  Widget _ablumConver() {
    return new Opacity(
      //透明度
      opacity: 1,
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                blurRadius: 15.0, //阴影模糊程度
                spreadRadius: 10.0 //阴影扩散程度
                ),
          ],
        ),
        child: ClipRRect(
          //圆角
          borderRadius: BorderRadius.circular(6.0),
          child: Image.network(
            "${_albums.coverUrlMiddle}",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 4);
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
            onPressed: () {
              _showModalSheet();
            },
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
            onPressed: () {
              _showModalSheet();
            },
          ),
        ],
      ),
    );
  }

  ///
  StatefulWidget _nestedScrollView() {
    return new NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 440,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/images/bg01.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                //头部整个背景颜色
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    _ablumConver(),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 50,
                      child: Text(
                        '${_tracks.title}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                    // 线性进度条高度指定为3
                    SizedBox(
                      height: 5,
                      child: _widgetProcessBar(),
                    ),
                    SizedBox(
                      height: 80,
                      child: _widgetPlayBar(),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              //指示器厚度
              indicatorWeight: 2,
              //展示器颜色
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.blue,
              //
              labelColor: Colors.white,
              //没有被选中的颜色
              unselectedLabelColor: Colors.black,
              //没有被选中的样式
              unselectedLabelStyle: new TextStyle(fontSize: 13),
              tabs: [
                Tab(text: "介绍"),
                Tab(text: "主播"),
                Tab(text: "评论"),
                Tab(text: "相关"),
              ],
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          ContentPage(
            albums: _albums,
            tracks: _tracks,
          ),
          AnnouncerPage(
            albums: _albums,
            tracks: _tracks,
          ),
          ContentPage(
            albums: _albums,
            tracks: _tracks,
          ),
          AnnouncerPage(
            albums: _albums,
            tracks: _tracks,
          ),
        ],
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return new Container(
            height: 300,
            child: new ListView(
              children: <Widget>[
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
                ListTile(
                  title: Text("${_tracks.title}"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _nestedScrollView(),
    );
  }
}
