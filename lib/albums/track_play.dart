import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/tracks.dart';

Tracks _tracks;

///专辑明细
class TrackItemPlay extends StatefulWidget {
  final Tracks tracks;

  const TrackItemPlay({Key key, this.tracks}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _tracks = this.tracks;
    return _TrackItemPlayState();
  }
}

class _TrackItemPlayState<Albums> extends State<TrackItemPlay> {
  // init
  AudioPlayer audioPlayer = AudioPlayer();

  //
  String process = "";

  //
  bool playFlag = false;

  final String url =
      "https://fdfs.xmcdn.com/group61/M05/F7/6A/wKgMZl38aZiRnG9SAEQg10Muor0804.m4a";

  @override
  void initState() {
    super.initState();
    audioPlayer.onAudioPositionChanged.listen((p) async {
      // p参数可以获取当前进度，也是可以调整的，比如p.inMilliseconds
      process = "${p}";
      print("p-->${p}");
      setState(() {});
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  void sliderChangePlay(double val) {
    setState(() {
      print("processBarValue== ${val}");
      //processBarValue = val * 0.01;
//      percentage = val;
//      print("processBarValue== ${processBarValue}");
    });
  }

  Widget _headerBuilder() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/images/black-disk.png",
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "" + _tracks.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      color: Colors.black),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.headset, size: 20, color: Colors.grey),
                    Text(
                      "${_tracks.playCount % 1000}k",
                      style: (TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "上传时间：" + "${_tracks.createDateFormat}",
                      style: (TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("process->${process}"),
                  ],
                ),

                ///
                Row(
                  children: <Widget>[
                    OutlineButton.icon(
                      onPressed: () {},
                      label: Text("喜欢"),
                      icon: Icon(Icons.favorite, size: 20, color: Colors.red),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlineButton.icon(
                      onPressed: () {},
                      label: Text("下载"),
                      icon: Icon(Icons.file_download,
                          size: 20, color: Colors.red),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlineButton.icon(
                      onPressed: () {},
                      label: Text("分享"),
                      icon: Icon(Icons.share, size: 20, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetTrackInfo() {
    return Container(
      color: Colors.grey[300],
    );
  }

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
              value: 40,
              onChanged: (value) {},
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
                    //fastRewindPlay();
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
                    setState(() {
                      controlPlay();
//                      play();
                    });
                    //controlPlay();
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
//                    fastForwardPlay();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void play() async {
    int result = await audioPlayer.play(url);
    print("result-->${result}");
    if (result == 1) {
      print('play success');
    } else {
      print('play failed');
    }
  }

  void pause() async {
    int result = await audioPlayer.pause();
    print("result-->${result}");
    if (result == 1) {
      // success
      print('pause success');
    } else {
      print('pause failed');
    }
  }

  ///结束
  @override
  void deactivate() async {
    print('结束');
    int result = await audioPlayer.release();
    if (result == 1) {
      print('release success');
    } else {
      print('release failed');
    }
    super.deactivate();
  }

  ///点击唱片控制运行
  void controlPlay() {
    setState(() {
      playFlag = !playFlag;
      if (playFlag) {
        play();
      } else {
        pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomSheet: _bottomBar(),
      appBar: AppBar(
        title: Text("${_tracks.title}", style: TextStyle(fontSize: 15)),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
//          _headerBuilder(),
          Expanded(
            flex: 1,
            child: _headerBuilder(),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                _widgetTrackInfo(),
                // _headerBuilder(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
