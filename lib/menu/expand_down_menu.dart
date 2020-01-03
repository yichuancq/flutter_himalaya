import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter/rendering.dart';

///
const int ORDER_INDEX = 0;
const int TYPE_INDEX = 0;
const int FOOD_INDEX = 1;
const List<Map<String, dynamic>> ORDERS = [
  {"title": "默认排序"},
  {"title": "升顺"},
  {"title": "倒序"},
];
const List<Map<String, dynamic>> TYPES = [
  {"title": "默认筛选", "id": 0},
  {"title": "播放量<5", "id": 1},
  {"title": "播放量>=5", "id": 2},
];

class ExpandDownMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpandDownMenuPageStateful();
  }
}

///自定义类
class MyAlbum {
  String title;

  //播放量
  int playCount;

  //分享数量
  int shareCount;

  MyAlbum({@required this.title, this.playCount = 0, this.shareCount = 0});
//

}

///
class _ExpandDownMenuPageStateful extends State<ExpandDownMenuPage> {
  List<MyAlbum> myAlbums = new List();
  bool reversedFlag = false;
  ScrollController scrollController;
  GlobalKey globalKey;

  ///
  void _initList() {
    myAlbums.add(new MyAlbum(title: "title1", playCount: 1, shareCount: 10));
    myAlbums.add(new MyAlbum(title: "title2", playCount: 2, shareCount: 11));
    myAlbums.add(new MyAlbum(title: "title3", playCount: 3, shareCount: 12));
    myAlbums.add(new MyAlbum(title: "title4", playCount: 4, shareCount: 13));
    myAlbums.add(new MyAlbum(title: "title5", playCount: 5, shareCount: 14));
    myAlbums.add(new MyAlbum(title: "title6", playCount: 6, shareCount: 15));
    myAlbums.add(new MyAlbum(title: "title7", playCount: 7, shareCount: 12));
    myAlbums.add(new MyAlbum(title: "title8", playCount: 8, shareCount: 13));
    myAlbums.add(new MyAlbum(title: "title9", playCount: 9, shareCount: 14));
    myAlbums.add(new MyAlbum(title: "title10", playCount: 10, shareCount: 15));
  }

  @override
  void initState() {
    scrollController = new ScrollController();
    globalKey = new GlobalKey();
    super.initState();
    _initList();
    print("ablum length:${myAlbums.length}");
  }

  ///默认排序
  void _defaultOrder() {
    myAlbums.clear();
    setState(() {
      print("_defaultOrder...");
      _initList();
    });
  }

  ///逆序
  void _reversOrder() {
    Iterable iterable = myAlbums.reversed;
    setState(() {
      print("_reversOrder...");
      myAlbums = iterable.toList();
    });
  }

  void _defaultfilterAlbum() {
    myAlbums.clear();
    setState(() {
      _initList();
    });
  }

  void _filterAlbumMoreThan5() {
    myAlbums.clear();
    _initList();
    setState(() {
      myAlbums.retainWhere((element) => (element.playCount >= 5));
    });
  }

  void _filterAlbumLessThan5() {
    myAlbums.clear();
    _initList();
    setState(() {
      myAlbums.retainWhere((element) => (element.playCount < 5));
    });
  }

  ///构建下拉菜单
  DropdownMenu buildDropdownMenu() {
    return new DropdownMenu(
        maxMenuHeight: kDropdownMenuItemHeight * 10,
        menus: [
          new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: TYPE_INDEX,
                  data: TYPES,
                  itemBuilder: buildCheckItem,
                );
              },
              height: kDropdownMenuItemHeight * TYPES.length),
          new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: ORDER_INDEX,
                  data: ORDERS,
                  itemBuilder: buildCheckItem,
                );
              },
              height: kDropdownMenuItemHeight * ORDERS.length),
        ]);
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return new DropdownHeader(
      onTap: onTap,
      titles: [TYPES[TYPE_INDEX], ORDERS[ORDER_INDEX]],
      // titles: [TYPES[TYPE_INDEX], ORDERS[ORDER_INDEX], FOODS[0]['children'][0]],
    );
  }

  Widget _buildListView() {
    return ListView.separated(
        itemBuilder: (BuildContext context, final int index) {
          MyAlbum album = myAlbums[index];
          int albumIndex = index + 1;
          //return new Text("text $index");
          return new ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                "assets/images/truck.png",
                fit: BoxFit.fitHeight,
                width: 80,
                height: 80,
              ),
            ),
            title: Text(album.title),
            subtitle: Text(
              "播放量：${album.playCount}   share : ${album.shareCount}",
            ),
            trailing: Text("$albumIndex"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return new Container(height: 1.0, color: Colors.grey);
        },
        itemCount: myAlbums.length);
  }

  Widget buildFixHeaderDropdownMenu() {
    return new DefaultDropdownMenuController(

        ///选择事件
        onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
          print(
              "menuIndex:$menuIndex index:$index subIndex:$subIndex data:$data");

          if (menuIndex == 0) {
            if (index == 0) {
              _defaultfilterAlbum();
            }
            if (index == 1) {
              _filterAlbumLessThan5();
            }
            if (index == 2) {
              _filterAlbumMoreThan5();
            }
          }
          if (menuIndex == 1) {
            //默认排序
            if (index == 0) {
              reversedFlag = false;
              _defaultOrder();
            }
            //排序
            if (index == 1) {
              if (reversedFlag) {
                _reversOrder();
                reversedFlag = !reversedFlag;
              }
            }
            if (index == 2) {
              if (!reversedFlag) {
                _reversOrder();
                reversedFlag = !reversedFlag;
              }
            }
          }
        },
        child: new Column(
          children: <Widget>[
            buildDropdownHeader(),
            new Expanded(
                child: new Stack(
              children: <Widget>[_buildListView(), buildDropdownMenu()],
            ))
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      //利用PreferredSize随意定制你的toolbar，如果是滑动布局可以使用sliverPreferredSize
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
                child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("筛选菜单", style: TextStyle(fontSize: 15)),
            )),
          ),
          preferredSize: Size(double.infinity, 60)),

      body: buildFixHeaderDropdownMenu(),
    );
  }
}
