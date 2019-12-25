import 'package:flutter/material.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/tracks.dart';

Albums _albums;
Tracks _tracks;
Announcer _announcer;

class AnnouncerPage extends StatefulWidget {
  final Tracks tracks;
  final Albums albums;

  const AnnouncerPage({Key key, this.tracks, this.albums}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    assert(tracks != null);
    assert(albums != null);
    _albums = this.albums;
    _tracks = this.tracks;
    //作者
    _announcer = _albums.announcer;
    return _AnnouncerPageStateful();
  }
}

class _AnnouncerPageStateful extends State<AnnouncerPage> {
  Widget _content() {
    return Container(
      alignment: AlignmentDirectional.topStart,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(5),
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("作者介绍：${_announcer.nickname}, 等级:${_announcer.anchorGrade}"),
              Image.network(
                "${_announcer.avatarUrl}",
                width: 80,
                height: 80,
              ),
              Text("播放量：${_tracks.playCount}")
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(),
    );
  }
}
