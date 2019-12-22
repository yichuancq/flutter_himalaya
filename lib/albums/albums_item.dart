import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/album_content.dart';
import 'package:flutter_himalaya/vo/albums_track_json_convert.dart';

Albums _albums;
AlbumContent _albumContent;

class AlbumsItemList extends StatefulWidget {
  final Albums albums;

  const AlbumsItemList({Key key, this.albums}) : super(key: key);

  @override
  _AlbumsItemListState createState() {
    print("" + albums.albumTitle);
    print("" + albums.kind == "album");
    _albums = this.albums;
    return _AlbumsItemListState();
  }
}

class _AlbumsItemListState<Albums> extends State<AlbumsItemList> {
  List<Tracks> _tracks = new List();

  ///
  Widget _headerBuilder() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
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
                    Text(_albums.kind == "album"
                        ? "分类:" + "专辑"
                        : "${_albums.kind}"),
                  ],
                ),
                Text(
                  "简介：" + _albums.shortIntro,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "作者: ${_albumContent.data.anchorInfo.anchorName}",
                      style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.grey),
                    ),
                  ],
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

//                Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    SizedBox(
//                      width: 250,
//                      child: Text(
//                        "推荐理由：" + _albums.recommendReason,
//                        maxLines: 1,
//                        style: TextStyle(
//                            fontSize: 12,
//                            decoration: TextDecoration.none,
//                            color: Colors.grey),
//                        overflow: TextOverflow.ellipsis,
//                      ),
//                    ),
//                  ],
//                ),

                ///

                ///
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
    _tracks = null;
//    _albums = null;
//    _albumContent = null;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _albumContent = await convertFromAlbumTractsJson();
    print(_albumContent.data.albumId);
    print("专辑的播放列表： ${_albumContent.data.tracksInfo.tracks.length}");
    _tracks = _albumContent.data.tracksInfo.tracks;
    //更新列表
    setState(() {
      //状态
    });
  }

  Widget _albumItemContentBuilder(int position) {
    Tracks tracks = _tracks[position];
//    print("index is --->${tracks.index}");

    return GestureDetector(
      onTap: () {
        print(" on item click...");
        //onTab(albumsItem);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: SizedBox(
          child: Row(
            //对齐方式
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("${tracks.index}"),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Text("${tracks.title}"),
              ),
              SizedBox(
                width: 1,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.headset,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Text("${tracks.playCount % 10000}万"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("${tracks.createDateFormat}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _albumsContentList() {
    Size size = MediaQuery.of(context).size * 0.8;
    return Container(
//      color: Colors.amber,
      padding: EdgeInsets.only(bottom: 20),
      height: size.height,
      child: ListView.builder(
          itemCount: _tracks.length,
          itemBuilder: (BuildContext context, int position) {
            return _albumItemContentBuilder(position);
          }),
    );
  }

  Widget _widgetTrackInfo() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text("专辑里的声音(${_tracks.length})"),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Text("顺序"),
                  Text("|"),
                  Text("倒序"),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
//        backgroundColor: Colors.amber,
        //  backgroundColor: Colors.grey[300],
        title: Text(_albums.albumTitle, style: TextStyle(fontSize: 15)),
      ),
      body: Container(
//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
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
                  _albumsContentList(),
                  // _headerBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
