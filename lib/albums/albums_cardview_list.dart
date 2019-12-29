import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/vo/albums_json_convert.dart';
import 'package:flutter_himalaya/vo/search.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'albums_item.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsListState();
  }
}

///专辑
class _AlbumsListState extends State<AlbumsList> with TickerProviderStateMixin {
  List<Albums> _albumList = new List();

  //
  bool playFlag = false;

  ///AlbumsItemList
  void onTab(Albums albumsItem) {
    ///ReportPage
    //go to station
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new AlbumsItemList(
        albums: albumsItem,
      );
    }));
    print("AlbumsItemList..");
  }

  ///item cell
  Widget _albumItemBuilder(final int index) {
    Albums albumsItem = _albumList[index];

    return GestureDetector(
      onTap: () {
        print(" on item click...");
        if (albumsItem != null) {
          onTab(albumsItem);
        }
      },
      child: Container(
        height: 100,
        color: Colors.white,
        //内边距
//        padding: EdgeInsets.only(left: 1, right: 1),
        child: SizedBox(
          child: Row(
            //对齐方式
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //弹性布局
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        albumsItem.coverUrlMiddle,
                        fit: BoxFit.fill,
                        width: 80,
                        height: 80, //图片高度
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(albumsItem.albumTitle),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      albumsItem.shortIntro == null
                          ? albumsItem.albumTags
                          : albumsItem.shortIntro,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.graphic_eq, size: 20, color: Colors.grey),
                        Text(
                          "100",
                          style: (TextStyle(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.headset,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          "112",
                          style: (TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _albumsList() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: ListView.separated(
          itemCount: _albumList == null ? 0 : _albumList.length,
          separatorBuilder: (BuildContext context, int index) {
            return new Container(height: 0.5, color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int position) {
            return _albumItemBuilder(position);
          }),
    );
  }

  Widget _albumsBuilder() {
    return Container(
      child: ListView(
        children: <Widget>[
          _albumsList(),
        ],
      ),
    );
  }

  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      cursorColor: Colors.red, //设置光标
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            size: 20,
            color: Colors.grey,
          ),
          hintText: "输入专辑名称",
          hintStyle: new TextStyle(fontSize: 14, color: Colors.grey)),
      style: new TextStyle(fontSize: 14, color: Colors.red),
    );
  }

  ///
  void loadData() async {
    print("on loadData...");

    Album album = await convertFromAlbumJson();
    //读取json
    _albumList = album.albums;
    print("list size: ${_albumList.length}");
    //更新列表
    setState(() {
      //状态
    });
  }

  void searchAlbum() async {
    await searchAlbumByKeyWords("music");
  }

  @override
  void initState() {
    super.initState();
    loadData();
    searchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent.withOpacity(0.1),
      backgroundColor: Colors.transparent,
      //把scaffold的背景色改成透明
      appBar: PreferredSize(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
              fit: BoxFit.cover,
            )),
            child: SafeArea(
              child: SearchBar(
                onQuerySubmitted: (query) {},
                onQueryChanged: (query) {},
                searchHint: "输入专辑 ",
                defaultBar: AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    '输入专辑',
                    style: new TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          preferredSize: Size(double.infinity, 60)),
      body: _albumsBuilder(),
    );
  }

  @override
  dispose() {
    _albumList = null;
    super.dispose();
  }
}
