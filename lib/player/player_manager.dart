import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_himalaya/albums/album_songs_data.dart';
import 'package:flutter_himalaya/model/track_item.dart';
import 'dart:async';

import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/track_item_service.dart';
import 'dart:async';
import 'dart:ui';

///
enum PlayerState { stopped, playing, paused }

abstract class PlayerManager<T> extends State {
  Tracks playTracks;

  AudioPlayer audioPlayer = AudioPlayer();

  //region 变量
  BuildContext context;

  //播放专辑列表
  SongData songData;

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

  void setSongData(SongData songData) {
    this.songData = songData;
  }

  void setPlayTrack(Tracks tracks) {
    this.playTracks = tracks;
  }

  ///
  Widget processText() {
    return Text(
        _position != null
            ? '${_positionText ?? ''} / ${_durationText ?? ''}'
            : _duration != null ? _durationText : '',
        style: TextStyle(fontSize: 15.0, color: Colors.redAccent));
  }

//  void showTracks() {
//    print(songData.length);
//    for (var x in songData.songs) {
//      print(x.title);
//    }
//  }

  ///音乐地址
  Future<String> _loadMusicUrl(final int trackId) async {
    TruckItemDto truckItemDto = await getTruckItemMusic(trackId);

    if (truckItemDto != null) {
      setState(() {
        //音乐地址
        musicUrl = truckItemDto.data.src;
      });
    }
    return musicUrl;
  }

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();
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

  ///下一首
  Future next() async {
    print('下一首');
    _stop();
    setState(() {
      _duration = Duration(seconds: 0);
      _position = Duration(seconds: 0);
      play(songData.nextSong);
    });
  }

  ///上一首
  Future prev() async {
    print('上一首');
    _stop();

    setState(() {
      _duration = Duration(seconds: 0);
      _position = Duration(seconds: 0);
      play(songData.prevSong);
    });
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

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
