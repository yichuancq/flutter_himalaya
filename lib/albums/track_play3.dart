import 'dart:ui';
import 'dart:async';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/me/announcer_page.dart';
import 'package:flutter_himalaya/me/content_page.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/track_item.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_himalaya/player/player_manager.dart';
import 'package:flutter_himalaya/vo/track_item_service.dart';
import 'album_songs_data.dart';
import 'my_painter.dart';
import 'dart:math' as math;

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
  @override
  void initState() {
    super.context = context;
    //
    this.setSongData(new SongData(_trackList));
    //
    this.playTracks = _tracks;

    //
    super.initState();
    setState(() {});
  }

  void _prev() {
    print("_prev");
    super.prev();
  }

  void _next() {
    print("_next");
    super.next();
  }

  void _play() {
    print("play");
    super.play(_tracks);
  }

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

  Widget _body() {
    var timeText = processText();
    return Container(
      alignment: Alignment.topCenter,
      //头部整个背景颜色
      height: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          _ablumConver(),
          SizedBox(
            height: 20,
          ),
          Text("${this.playTracks.title}"),
          //
          SizedBox(
            height: 20,
          ),
          timeText,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
                child: Text("上一首"),
                onPressed: () {
                  _prev();
                },
              ),
              OutlineButton(
                child: Text("play"),
                onPressed: () {
                  _play();
                },
              ),
              OutlineButton(
                child: Text("下一首"),
                onPressed: () {
                  _next();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${this.playTracks.title}", style: TextStyle(fontSize: 15)),
      ),
      body: _body(),
    );
  }
}
