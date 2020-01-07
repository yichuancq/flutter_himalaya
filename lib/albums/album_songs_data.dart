import 'dart:math';

import 'package:flutter_himalaya/model/tracks.dart';

///播放专辑
class SongData {
  List<Tracks> _trackList;
  int _currentSongIndex = -1;

  //
  SongData(this._trackList) {
    _trackList = this._trackList;
  }

  List<Tracks> get songs => _trackList;

  int get length => _trackList.length;

  int get songNumber => _currentSongIndex + 1;

  setCurrentIndex(int index) {
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Tracks get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
    }
    if (_currentSongIndex >= length) return null;
    return _trackList[_currentSongIndex];
  }

  Tracks get randomSong {
    Random r = new Random();
    return _trackList[r.nextInt(_trackList.length)];
  }

  Tracks get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
    }
    if (_currentSongIndex < 0) return null;
    return _trackList[_currentSongIndex];
  }
}
