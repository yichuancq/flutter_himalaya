import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsListState();
  }
}

class _AlbumsListState extends State<AlbumsList> {
  List flagsList = [false, false, false, false];

  ///
  Widget _albumsList() {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Image.network(
                "http://imagev2.xmcdn.com/group29/M05/00/14/wKgJXVlQ7vmBi-__AAFgYj4HfQ0789.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png"),
            title: Text("每晚一个睡前故事"),
//            subtitle: Text("albums subTitle"),
            subtitle: Text("儿童故事,可乐姐姐,学前教育,童话,睡前故事"),
            trailing: Checkbox(
              value: flagsList[0],
              onChanged: (value) {
                flagsList[0] = value;
                setState(() {});
              },
            ),
            onTap: () {
              flagsList[0] = !flagsList[0];
              setState(() {});
            },
          ),
          Divider(
            height: 1,
            color: Colors.red,
          ),
          ListTile(
            //
            leading: Image.network(
                "http://imagev2.xmcdn.com/group4/M02/11/BF/wKgDs1MoE13Cbd5aAADbM_v7Sf0531.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png"),
            title: Text("睡前故事：一千零一夜"),
            subtitle: Text("儿童读物,儿童故事,童话,睡前故事,晚安故事"),
            trailing: Checkbox(
              value: flagsList[1],
              onChanged: (value) {
                flagsList[1] = value;
                setState(() {});
              },
            ),
            //trailing: IconButton(icon: Icon(Icons.chevron_right)),
            onTap: () {
              flagsList[1] = !flagsList[1];
              setState(() {});
            },
          ),
          Divider(
            height: 1,
            color: Colors.red,
          ),
          ListTile(
            //
            leading: Image.network(
                "http://imagev2.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848.jpg!op_type=5&upload_type=album&device_type=ios&name=medium&magick=png"),
            title: Text("夜色钢琴曲》"),
            subtitle: Text("咖啡,日韩,流行,纯音乐,钢琴曲"),
            trailing: Checkbox(
              value: flagsList[2],
              onChanged: (value) {
                flagsList[2] = value;
                setState(() {});
              },
            ),
            //trailing: IconButton(icon: Icon(Icons.chevron_right)),
            onTap: () {
              flagsList[2] = !flagsList[2];
              setState(() {});
            },
          ),
          Divider(
            height: 1,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  ///
  Widget _albumsBuilder() {
    return Container(
      child: ListView(
        children: <Widget>[
          _albumsList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    Iterable<dynamic> pickList = flagsList.where((e) => (e == true));
    return Scaffold(
//      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: <Widget>[
                    Text("${pickList.length} pick"),
                    IconButton(
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        centerTitle: true,
        title: Text("专辑"),
      ),
      body: Container(
        child: _albumsBuilder(),
      ),
    );
  }
}
