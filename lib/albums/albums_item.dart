import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_himalaya/albums/track_play3.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/album_content.dart';
import 'package:flutter_himalaya/model/tracks.dart';
import 'package:flutter_himalaya/vo/albums_track_json_convert.dart';
import 'package:toast/toast.dart';

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
  int _trackTotalCount;
  int _pageNum = 1;
  int _pageSize = 30;
  int _totalPage = 0;
  int _currentPage = 1;

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
                  Wrap(
                    children: <Widget>[
                      Text("" + _albums.albumTitle,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.none,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_albums.kind == "album"
                          ? "分类:" + "专辑"
                          : "${_albums.kind}", style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.black),),
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
                  Container(
//                    height: 40,
                    padding: const EdgeInsets.all(1.0),
                    margin: EdgeInsets.all(3),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      direction :Axis.horizontal,
                      spacing: 4.0, // 主轴(水平)方向间距
                      runSpacing: 2.0, // 纵轴（垂直）方向间距
                      alignment: WrapAlignment.start, //沿主轴方向居中
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                          width: 70,
                          child: OutlineButton.icon(
                            onPressed: () {},
                            label: Text("下载",style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.black),),
                            icon: Icon(Icons.file_download,
                              size: 10, color: Colors.red,),
                          ),
                        ),

                        SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 30,
                          width: 70,
                          child:   OutlineButton.icon(
                            onPressed: () {},
                            label: Text("订阅",style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.black),),
                            icon: Icon(Icons.subscriptions,
                                size: 10, color: Colors.red),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 30,
                          width: 70,
                          child: OutlineButton.icon(
                            onPressed: () {},
                            label: Text("分享",style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                            ),
                            icon: Icon(Icons.share, size: 10, color: Colors.red),
                          ),
                        ),

                      ],
                    ),
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
  }

  @override
  void initState() {
    super.initState();
    loadData();
    //  searchAlbum();
  }

  void loadData() async {
    TrackDto trackDto = await getTracksList2(_albums.id, _pageNum);
    if (trackDto != null && trackDto.data != null) {
      _tracks = trackDto.data.tracks;
      _trackTotalCount = trackDto.data.trackTotalCount;
      _pageNum = trackDto.data.pageNum;
      _pageSize = trackDto.data.pageSize;
      print("_trackTotalCount： ${_trackTotalCount}");
      print("_pageNum： ${_pageNum}");
      print("_pageSize： ${_pageSize}");

      //返回大于等于( >= )给定参数的的最小整数
      _totalPage = (_trackTotalCount / _pageSize).ceil();
      print("_totalPage： ${_totalPage}");
      //

    } else {
      Toast.show("获取数据失败！", context);
    }
    //更新列表
    setState(() {
      //状态
    });
  }

  void getPageData() async {
    TrackDto trackDto = await getTracksList2(_albums.id, _pageNum);
    if (trackDto != null && trackDto.data != null) {
      _tracks = trackDto.data.tracks;
      _pageNum = trackDto.data.pageNum;
      _pageSize = trackDto.data.pageSize;
      print("_pageNum： ${_pageNum}");
    } else {
      Toast.show("获取数据失败！", context);
    }
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
              Text("${tracks.playCount % 10000} 万"),
              SizedBox(
                width: 20,
              ),
              Text("${tracks.createDateFormat} 更新"),
            ],
          ),
          //
        ),
      ),
    );
  }

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

  ///上拉
  Future _onRefresh() async {
    print("_onRefresh...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum - 1 <= 0) {
        Toast.show("没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum -= 1;
        _currentPage -= 1;
        getPageData();
        setState(() {});
      }
    });
  }

  ///下拉
  Future _onLoad() async {
    print("_onLoad...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum >= _totalPage) {
        Toast.show("没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum += 1;
        _currentPage += 1;
        getPageData();
      }
      setState(() {});
    });
  }

  ///分页
  Widget _albumsListRefresh() {
    return new EasyRefresh(
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: _albumsListView(),
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
              child: _albumsListRefresh(),
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
