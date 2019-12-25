import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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

class _TrackItemPlayState<Albums> extends State<TrackItemPlay2> {
  Widget _ablumConver() {
    return Container(
//      color: Colors.grey,
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

  Widget _header() {
    return SliverAppBar(
//      backgroundColor: Colors.transparent,
      title: Text(
        '${_tracks.title}',
        maxLines: 1,
        style: TextStyle(fontSize: 15),
      ),
      centerTitle: true,
      pinned: true,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                alignment: AlignmentDirectional.center,
                overflow: Overflow.clip,
                // AlignmentDirectional.topStart,
                children: <Widget>[
                  Image.asset(
                    "assets/images/bg01.jpeg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  _ablumConver(),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: _widgetPlayBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetPlayBar() {
    return Container(
      height: 80,
      color: Colors.black45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.reorder),
            onPressed: () {},
          ),

          //返回前一首
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {},
          ),
          // 播放，暂停
          IconButton(
            //判断是否播放中，返回不同按钮状态
            icon: Icon(Icons.play_arrow, color: Colors.black45), // 播放
            onPressed: () {
              setState(() {
//                      play();
              });
            },
          ),
          //一下首
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  ///
  Widget _controlBar() {
    return Container(
//      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Column(
        children: <Widget>[
          // 线性进度条高度指定为3
          SizedBox(
            height: 10,
            child: Slider(
              value: 30,
              onChanged: (newValue) {},
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //返回前一首
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                // 播放，暂停
                IconButton(
                  //判断是否播放中，返回不同按钮状态
                  icon: Icon(Icons.play_arrow, color: Colors.red), // 播放
                  onPressed: () {
                    setState(() {
//                      play();
                    });
                  },
                ),
                //一下首
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {},
                ),
              ],
            ),
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

  /////因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
  //    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
  Widget _viewBuild() {
    return Material(
      child: CustomScrollView(slivers: <Widget>[
        //AppBar，包含一个导航栏
        _header(),
//        _controlBar()
        _body(),
        //_controlBar(),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: AppBar(
//        title: Text("truck", style: TextStyle(fontSize: 15)),
//      ),
      body: _viewBuild(),
    );
  }
}
