import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/albums/track_play3.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/album_content.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/albums_track_json_convert.dart';
import 'package:flutter_himalaya/vo/search.dart';

Albums _albums;
AlbumContent _albumContent;

class AlbumsItemList extends StatefulWidget {
  final Albums albums;

  const AlbumsItemList({Key key, @required this.albums}) : super(key: key);

  @override
  _AlbumsItemListState createState() {
    assert(albums != null);
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
            child: SingleChildScrollView(
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
                        "作者: ${_albums.announcer.nickname}",
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
    //  searchAlbum();
  }

  void searchAlbum() async {
    await searchAlbumByKeyWords("music");
  }

  void loadData() async {
    //getTracksList(int albumId)
//    await getXimalaya();
    //TrackDto trackDto2 = await getTracksList2(_albums.id);
    TrackDto trackDto = await getTracksList2(_albums.id);
    print("trackDto==${trackDto}}");
    if (trackDto != null && trackDto.data != null) {
      _tracks = trackDto.data.tracks;
    } else {
      trackDto = await getTracksList(_albums.id);
      print(_albumContent.data.albumId);
      print("专辑的播放列表： ${_tracks.length}");
      _tracks = _albumContent.data.tracks;
    }
//    _trackList = _tracks;
    //更新列表
    setState(() {
      //状态
    });
  }

  ///AlbumsItemList
  void onTab(Tracks tracks) {
    ///ReportPage
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new TrackItemPlay3(
        tracks: tracks,
        albums: _albums,
        trackList: _tracks,
      );
    }));
    print("TrackItemPlay..");
  }

  Widget _albumItemContentBuilder(int position) {
    //
    Tracks tracks = _tracks[position];
    return GestureDetector(
      onTap: () {
        print(" on item click...");
        onTab(tracks);
      },
      child: Container(
        child: ListTile(
          //序号居中
          leading: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${tracks.index}"),
              ],
            ),
          ),
          title: Text(
            "${tracks.title}",
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.headset,
                size: 18,
                color: Colors.grey,
              ),
              Text("${tracks.playCount % 10000}万"),
              SizedBox(
                width: 20,
              ),
              Text("${tracks.createDateFormat} 更新"),
            ],
          ),
//          trailing: IconButton(
//            icon: Icon(Icons.navigate_next, color: Colors.black),
//          ),
          //
        ),
      ),
    );
  }

  ///
  Widget _albumsListView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: _tracks.length,
      separatorBuilder: (BuildContext context, int index) {
        return new Container(height: 0.5, color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int position) {
        return Padding(
            padding: EdgeInsets.all(5.0),
            child: _albumItemContentBuilder(
                position)); //_albumItemContentBuilder(position);
      },
    );
  }

  ///逆序
  void _reversOrder() {
    print("reOrder...");
    Iterable iterable = _tracks.reversed;
    setState(() {
      _tracks = iterable.toList();
      print("_reversOrder...");
    });
  }

  Widget _widgetTrackInfo() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("专辑里的声音(${_tracks.length})"),
            //
            IconButton(
              icon: Icon(Icons.format_line_spacing, color: Colors.grey),
              onPressed: () {
                setState(() {});
                _reversOrder();
              },
            ),
          ],
        ));
  }

  //实现构建方法
  _viewBuild() {
    Size size = MediaQuery.of(context).size;
    if (_albums == null) {
      // 加载菊花
      return Center(
        child: CupertinoActivityIndicator(),
      );
      //
    } else {
      return new Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            //表头
            SizedBox(
              height: 150,
              child: _headerBuilder(),
            ),
            SizedBox(
              child: _widgetTrackInfo(),
            ),
            //专辑列表
            Expanded(
              child: _albumsListView(),
              // _headerBuilder(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(_albums.albumTitle, style: TextStyle(fontSize: 15)),
      ),
      body: Container(
        child: _viewBuild(),
      ),
    );
  }
}
