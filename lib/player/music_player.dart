import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String _musicUrl;
enum PlayerState { stopped, playing, paused }

///
class MusicPlayer extends StatefulWidget {
  //播放音乐的URL
  final String musicUrl;

  const MusicPlayer({Key key, this.musicUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _musicUrl = this.musicUrl;
    print("${musicUrl}");
    return MusicPlayerState();
  }

  ///
  @override
  Future<int> play() {
    print("${musicUrl}");
    return MusicPlayerState()._play();
  }

  ///
  @override
  Future<int> pause() {
    print("${musicUrl}");
    return MusicPlayerState()._pause();
  }
}

class MusicPlayerState extends State<MusicPlayer>
    with TickerProviderStateMixin {
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
    _initAudioPlayer();
    //第一次进入默认不播放动画
    // setState(() {});
  }

  //

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
    final result = await _audioPlayer.play(_musicUrl,
        isLocal: null, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Scaffold();
//  }
}
