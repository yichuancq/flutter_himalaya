import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_himalaya/model/album.dart';

Albums _albums;

class AlbumsItemList extends StatefulWidget {
  final Albums albums;

  const AlbumsItemList({Key key, this.albums}) : super(key: key);

  @override
  _AlbumsItemListState createState() {
    print("" + albums.albumTitle);
    _albums = this.albums;
    return _AlbumsItemListState();
  }
}

class _AlbumsItemListState<Albums> extends State<AlbumsItemList> {
  ///
  Widget _headerBuilder() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
      height: 130,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
//                Image.asset("assets/images/cover-right.png", height: 90),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    _albums.coverUrlMiddle,
                    fit: BoxFit.fill,
                    width: 90,
                    height: 90,
                  ),
                ),
                Image.asset(
                  "assets/images/vip-album.png",
                  height: 18,
                  width: 40,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Image.asset("assets/images/cover-right.png"),
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
                Row(
                  children: <Widget>[
                    Text("" + _albums.albumTitle),
                    SizedBox(
                      width: 10,
                    ),
                    Text("分类:" + _albums.kind),
                  ],
                ),
                Text(
                  "简介：" + _albums.shortIntro,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.none,
                      color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.graphic_eq, size: 20, color: Colors.grey),
                    Text(
                      "${_albums.playCount % 1000}k",
                      style: (TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.headset,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Text(
                      "${_albums.playCount % 1000}K",
                      style: (TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Text(
                      "${_albums.shareCount % 1000}K",
                      style: (TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
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
                      label: Text("订阅"),
                      icon: Icon(Icons.subscriptions,
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

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(_albums.albumTitle),
      ),
      body: _headerBuilder(),
    );
  }
}
