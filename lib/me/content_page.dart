import 'package:flutter/material.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/tracks.dart';

Albums _albums;
Tracks _tracks;
Announcer _announcer;

class ContentPage extends StatefulWidget {
  final Tracks tracks;
  final Albums albums;

  const ContentPage({Key key, this.tracks, this.albums}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    assert(tracks != null);
    assert(albums != null);
    _albums = this.albums;
    _tracks = this.tracks;
    //作者
    _announcer = _albums.announcer;
    return _ContentPageStateful();
  }
}
class _ContentPageStateful extends State<ContentPage> {
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
              Text(
                _albums.albumIntro,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
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
