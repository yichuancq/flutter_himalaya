import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/util/my_painter.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/track_item.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/track_item_service.dart';

Tracks _tracks;
Albums _albums;

///专辑明细
class TrackItemPlay extends StatefulWidget {
  final Tracks tracks;
  final Albums albums;

  // @required 必须带带参数
  const TrackItemPlay({Key key, @required this.tracks, @required this.albums})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //断言不为空
    assert(tracks != null);
    assert(albums != null);
    _tracks = this.tracks;
    _albums = this.albums;
    print("${_tracks.trackId}");
    return _TrackItemPlayState();
  }
}

enum PlayerState { stopped, playing, paused }

class _TrackItemPlayState<Albums> extends State<TrackItemPlay>
    with TickerProviderStateMixin {
  String musicUrl;

  //动画控制器
  AnimationController albumController;

  //
  bool playFlag = false;

  //进度条
  AnimationController percentageAnimationController;
  Animation animation;
  double sliderProcessValue = 0;
  double processBarValue = 0.0;

  ///唱片进度
  double percentage = 0.0;
  double newPercentage = 0.0;

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

  get _isPlaying => _playerState == PlayerState.playing;

  get _isPaused => _playerState == PlayerState.paused;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  //
  String process = "";

  @override
  void initState() {
    super.initState();
    _loadMusicUrl();
    _initAudioPlayer();
    _initPlayAblum();
    //第一次进入默认不播放动画
//    play();
//    _play();

    stop();
//    setState(() {});
  }

  ///音乐地址
  void _loadMusicUrl() async {
    TruckItemDto truckItemDto = await getTruckItemMusic(_tracks.trackId);
    if (truckItemDto != null) {
      //音乐地址
      musicUrl = truckItemDto.data.src;
    }
  }

  ///动画初始化
  void _initPlayAblum() {
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
      setState(() {
        if (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds) {
          //_position.inMilliseconds / _duration.inMilliseconds
          percentage =
              (_position.inMilliseconds / _duration.inMilliseconds) * 100;
        } else {
          percentage = 0;
        }
      });
    });
    //开启
    albumController.forward();
  }

  ///
  Widget _widgetAlbumsPlayer() {
    return Container(
      //控制唱片的大小
      width: 100.0,
      height: 100.0,
      child: new CustomPaint(
        foregroundPainter: new MyPainter(
            lineColor: Colors.black45,
            completeColor: Colors.red,
            // completePercent: percentage,
            completePercent: percentage,
            width: 2),
        child: RotationTransition(
          alignment: Alignment.center,
          turns: animation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.0), // 圆角
            child: FloatingActionButton(
              child: Container(
                //内图片的的尺寸
                child: ClipRRect(
                  //圆弧处理
                  borderRadius: BorderRadius.circular(40.0),
                  // 唱片内部的图片
                  child: Image.network(_albums.coverUrlMiddle),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
    albumController.dispose();
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  Widget _headerBuilder() {
    setState(() {});
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _widgetAlbumsPlayer(),
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
                      icon: Icon(Icons.favorite, size: 12, color: Colors.red),
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
              value: (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position.inMilliseconds / _duration.inMilliseconds
                  : 0.0,
              onChanged: (newValue) {
                final Position = newValue * _duration.inMilliseconds;
                _audioPlayer.seek(Duration(milliseconds: Position.round()));
              },
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
        _play();
        play();
      } else {
        _pause();
        stop();
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
