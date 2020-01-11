import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/player/player_manager.dart';

import 'album_songs_data.dart';

Albums _albums;
Tracks _tracks;
List<Tracks> _trackList;

///专辑明细
class TrackItemPlay3 extends StatefulWidget {
  final Tracks tracks;
  final Albums albums;
  final List<Tracks> trackList;

  // @required 必须带带参数
  const TrackItemPlay3(
      {Key key,
      @required this.tracks,
      @required this.albums,
      @required this.trackList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //断言不为空
    assert(tracks != null);
    assert(albums != null);
    assert(trackList != null);
    _albums = this.albums;
    _tracks = this.tracks;
    _trackList = this.trackList;
    return _TrackItemPlayState();
  }
}

class _TrackItemPlayState<Albums> extends PlayerManager {
  ///
  @override
  void initState() {
    // 初始化数据
    this.initPlayerManager(playTracks: _tracks, songData: SongData(_trackList));
    //
    super.initState();
  }

  void _prev() {
    super.prev();
  }

  void _next() {
    super.next();
  }

// 专辑列表
  Widget _albumItemContentBuilder(int position) {
    //Tracks
    Tracks tracks = _trackList[position];
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        //序号居中
        leading: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${tracks.index}"),
          ],
        )),
        title: Text(
          "${tracks.title}",
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Text("  更新时间：${tracks.createDateFormat}"),
        trailing: IconButton(
          onPressed: () {
            //
            changePlayItem(position);
          },
          icon: Icon(Icons.play_circle_outline),
        ),
      ),
    );
  }

  Widget _albumConver() {
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

  Widget _body() {
    var process = processWidget();
    var slider = sliderWidget;
    return Container(
      alignment: Alignment.topCenter,
      //头部整个背景颜色
      height: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "${this.playTracks.title}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          _albumConver(),

          //
          SizedBox(
            height: 10,
          ),
          process,
          //process bar
          SizedBox(
            height: 30,
            child: slider(),
          ),
          //

          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.reorder, color: Colors.black),
                  onPressed: () {
                    showModalSheet();
                  },
                ),

                //返回前一首
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.black),
                  onPressed: () {
                    _prev();
                  },
                ),
                // 播放，暂停
                IconButton(
                  //判断是否播放中，返回不同按钮状态
                  icon: playFlag == true
                      ? Icon(Icons.pause, color: Colors.red) //暂停
                      : Icon(Icons.play_arrow, color: Colors.black),
                  // 播放
                  onPressed: () {
                    setState(() {
                      controlPlay();
                    });
                  },
                ),
                //一下首
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.black),
                  onPressed: () {
                    _next();
                  },
                ),

                IconButton(
                  icon: Icon(Icons.timer, color: Colors.black),
                  onPressed: () {
                    // _showModalSheet();
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
  void dispose() {
    super.dispose();
  }

  ///逆序
  void _reversOrder() {
    Iterable iterable = _trackList.reversed;
    setState(() {
      _trackList = iterable.toList();
      this.initPlayerManager(
          playTracks: playTracks, songData: SongData(_trackList));
    });
  }

  ///
  void showModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          //在这里为了区分，在构建builder的时候将setState方法命名为了setBottomSheetState。
          builder: (context, setBottomSheetState) {
            return new Container(
              height: 500,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.format_line_spacing,
                              color: Colors.black),
                          onPressed: () {
                            // 排序
                            _reversOrder();
                            //
                            setBottomSheetState(() {});
                            // _reversOrder();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: new ListView.separated(
                        itemCount: _trackList.length,
                        separatorBuilder: (BuildContext context, int position) {
                          return new Container(height: 0.5, color: Colors.grey);
                        },
                        itemBuilder: (BuildContext context, int position) {
                          return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: _albumItemContentBuilder(
                                  position)); //_albumItemContentBuilder(position);
                        }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${this.playTracks.index}", style: TextStyle(fontSize: 15)),
      ),
      body: _body(),
    );
  }
}
