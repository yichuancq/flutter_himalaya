import 'dart:ui';
import 'dart:async';
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
import 'package:flutter_himalaya/vo/track_item_service.dart';

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
enum PlayerState { stopped, playing, paused }

class _TrackItemPlayState<Albums> extends State<TrackItemPlay2>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();

    _loadMusicUrl();
    _initAudioPlayer();
    _initPlayAblum();
    //第一次进入默认不播放动画
    stop();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 4);
  }

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

  ///音乐地址
  void _loadMusicUrl() async {
    TruckItemDto truckItemDto = await getTruckItemMusic(_tracks.trackId);
    if (truckItemDto != null) {
      //音乐地址
      musicUrl = truckItemDto.data.src;
    }
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
                      height: 20,
                    ),
                    Text(
                      _position != null
                          ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                          : _duration != null ? _durationText : '',
                      style: TextStyle(fontSize: 19.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 80,
                      child: _bottomBar(),
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
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
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
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  icon: playFlag == true
                      ? Icon(Icons.pause, color: Colors.orangeAccent) //暂停
                      : Icon(Icons.play_arrow, color: Colors.white),
                  iconSize: 30, // 播放
                  onPressed: () {
                    setState(() {
                      controlPlay();
                    });
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _nestedScrollView(),
    );
  }
}
