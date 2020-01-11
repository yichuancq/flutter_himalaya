import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_himalaya/model/album_songs_data.dart';
import 'package:flutter_himalaya/model/track_item.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/track_item_service.dart';
import 'package:toast/toast.dart';

///
enum PlayerState { stopped, playing, paused }

abstract class PlayerManager<T> extends State {
  //region初始化player
  //当前播放的专辑声音
  Tracks playTracks;

  //播放专辑列表
  SongData songData;

  ///
  void initPlayerManager({Tracks playTracks, SongData songData}) {
    this.songData = songData;
    this.playTracks = playTracks;
  }

  // endregion

  //region AudioPlayer
  AudioPlayer audioPlayer = AudioPlayer();

  //音乐的URL
  String musicUrl;
  PlayerMode mode;
  bool playFlag = false;

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
  String process = "";

  //endregion

  ///播放进度条
  Widget sliderWidget() {
    return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.black12,
      value: (_position != null &&
              _duration != null &&
              _position.inMilliseconds > 0 &&
              _position.inMilliseconds < _duration.inMilliseconds)
          ? _position.inMilliseconds / _duration.inMilliseconds
          : 0.0,
      onChanged: (newValue) {
        final position = newValue * _duration.inMilliseconds;
        _audioPlayer.seek(Duration(milliseconds: position.round()));
      },
    );
  }

  ///播放进度文字
  Widget processWidget() {
    return Text(
        _position != null
            ? '${_positionText ?? ''} / ${_durationText ?? ''}'
            : _duration != null ? _durationText : '',
        style: TextStyle(fontSize: 15.0, color: Colors.white));
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  ///音乐地址
  Future<String> _loadMusicUrl(final int trackId) async {
    TruckItemDto truckItemDto = await getTruckItemMusic(trackId);
    if (truckItemDto != null &&
        truckItemDto.data != null &&
        truckItemDto.data.src != null) {
      musicUrl = truckItemDto.data.src;
      setState(() {
        //音乐地址
      });
    } else {
      showToast("无法获取播放地址", gravity: Toast.CENTER);
      print("无法获取播放地址...");
    }

    return musicUrl;
  }

  @override
  void initState() {
    _initAudioPlayer();
    //设置当前播放的索引
    songData.setCurrentIndex(_playIndex(playTracks));
    super.initState();
  }

  /// 设置当前播放的索引
  int _playIndex(Tracks playTracks) {
    print("_playIndex..");
    int index = 0;
    print(songData.length);
    if (songData.songs.length == 0) {
      return index;
    }
    for (var i = 0; i < songData.songs.length; i++) {
      if (songData.songs[i].trackId == playTracks.trackId) {
        index = i;
      }
    }
    return index;
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });
    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        //_tracks = tracks;
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

  ///
  Future<int> play(final Tracks tracks) async {
    if (tracks == null || tracks.trackId == null) {
      return 0;
    }
    final musicUrl = await _loadMusicUrl(tracks.trackId);

    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(musicUrl,
        isLocal: null, position: playPosition);

    ///
    if (result == 1) {
      setState(() {
        this.playTracks = tracks;
        _playerState = PlayerState.playing;
      });
    }
    return result;
  }

  ///播放完成后自动播放下一曲
  void _onComplete() {
    //
    if (songData.currentIndex >= songData.length) {
      setState(() => _playerState = PlayerState.stopped);
    } else {
      next();
    }
  }

  ///_stop
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

  ///_pause
  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  ///选集播放
  Future<void> changePlayItem(int position) async {
    Tracks tracks = songData.songs[position];
    final result = await _audioPlayer.stop();
    //
    if (result == 1) {
      setState(() {
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
        playTracks = tracks;
        print("选播  in： ${tracks.index}, ${tracks.title}");
        play(playTracks);
      });
    }
  }

  ///点击唱片控制运行
  void controlPlay() {
    setState(() {
      if (!playFlag) {
        play(playTracks);
      } else {
        //停止播放时，指针移出唱片外
        _pause();
      }
      playFlag = !playFlag;
    });
  }

  ///下一首
  Future next() async {
    print('下一首');
    _stop();
    setState(() {
      _duration = Duration(seconds: 0);
      _position = Duration(seconds: 0);
      if (playFlag) {
        play(songData.nextSong);
      } else {
        //非播放暂停改变只索引
        playTracks = songData.nextSong;
      }
    });
  }

  ///上一首
  Future prev() async {
    print('上一首');
    _stop();

    setState(() {
      _duration = Duration(seconds: 0);
      _position = Duration(seconds: 0);
      if (playFlag) {
        play(songData.prevSong);
      } else {
        //非播放暂停改变只索引
        playTracks = songData.prevSong;
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void stopPlayMusic() {
    //
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
  }

  @override
  void dispose() {
    stopPlayMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
