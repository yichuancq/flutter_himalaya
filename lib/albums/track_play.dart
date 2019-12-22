import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/track_item.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/track_item_service.dart';

Tracks _tracks;

///专辑明细
class TrackItemPlay extends StatefulWidget {
  final Tracks tracks;

  const TrackItemPlay({Key key, this.tracks}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _tracks = this.tracks;
    print("${_tracks.trackId}");
    return _TrackItemPlayState();
  }
}

enum PlayerState { stopped, playing, paused }

class _TrackItemPlayState<Albums> extends State<TrackItemPlay> {
  String musicUrl;

  // init
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerMode mode;

  AudioPlayer _audioPlayer;

  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

//  https://github.com/luanpotter/audioplayers/blob/master/example/lib/player_widget.dart
  get _isPlaying => _playerState == PlayerState.playing;

  get _isPaused => _playerState == PlayerState.paused;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  //
  String process = "";

  //
  bool playFlag = false;

//  final String url =
//      "https://fdfs.xmcdn.com/group61/M05/F7/6A/wKgMZl38aZiRnG9SAEQg10Muor0804.m4a";

  @override
  void initState() {
    super.initState();
    loadMusinUrl();
    _initAudioPlayer();
  }

  void loadMusinUrl() async {
    //getTruckItemMusic
    TruckItemDto truckItemDto = await getTruckItemMusic(_tracks.trackId);
    if (truckItemDto != null) {
      //音乐地址
      musicUrl = truckItemDto.data.src;
    }
  }

  ///
  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        // (Optional) listen for notification updates in the background
        _audioPlayer.startHeadlessService();

        // set at least title to see the notification bar on ios.
        _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            backwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0));
      }
    });
    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });

    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _audioPlayerState = state);
    });
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

//
  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  ///
  void sliderChangePlay(double val) {
    setState(() {
      print("processBarValue== ${val}");
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
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      _position != null
                          ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                          : _duration != null ? _durationText : '',
                      style: TextStyle(fontSize: 13.0),
                    ),
//                    Text("process->${process}"),
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
              value: (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position.inMilliseconds / _duration.inMilliseconds
                  : 0.0,
              onChanged: (v) {
                final Position = v * _duration.inMilliseconds;
                _audioPlayer.seek(Duration(milliseconds: Position.round()));
              },
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

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(musicUrl,
        isLocal: null, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    }

    return result;
  }

  ///点击唱片控制运行
  void controlPlay() {
    setState(() {
      playFlag = !playFlag;
      if (playFlag) {
        _play();
      } else {
//        _stop();
        _pause();
      }
    });
  }

  //实现构建方法
  _viewBuild() {
    if (_tracks == null || _tracks.index == 0) {
      // 加载菊花
      return Center(
        child: CupertinoActivityIndicator(),
      );
      //
    } else {
      return Container(
          child: Column(
        children: <Widget>[
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
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomSheet: _bottomBar(),
      appBar: AppBar(
        title: Text("${_tracks.title}", style: TextStyle(fontSize: 15)),
      ),
      body: _viewBuild(),
    );
  }
}
