import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/hot_recommends.dart';
import 'package:flutter_himalaya/vo/recommends_json_convert.dart';

import 'albums_item.dart';

///热门推荐
class HotRecommends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotRecommendsState();
  }
}

class _HotRecommendsState extends State {
  ///
  List<RecommendsList> recommendsList = new List();

  ///
  void loadJson() async {
    HotRecommendsDto hotRecommendsDto = await convertFromRecommendsJson();
    if (hotRecommendsDto != null) {
      recommendsList = hotRecommendsDto.hotRecommends.recommendsList;
    }
    setState(() {});
  }

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  //
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

  Widget _widgetRecommendsCards(final List<Datas> dataRecommendsList) {
    return Container(
      height: 180,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, final int index) {
          Datas item = dataRecommendsList[index];
          //作者
          Announcer _announcer = new Announcer(nickname: item.nickname);
          //专辑封装
          Albums _albums = new Albums(
              id: item.albumId,
              albumTitle: item.title,
              kind: "album",
              playCount: item.playsCounts,
              shareCount: 0,
              shortIntro: item.intro,
              coverUrlMiddle: item.coverMiddle,
              announcer: _announcer);

          return Card(
            child: GestureDetector(
              onTap: () {
                onTab(_albums);
                print("on item :${item.title}");
              },
              child: SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        item.coverMiddle,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${item.title}",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: dataRecommendsList.length,
      ),
    );
  }

  Widget _widgetRecommendsTitles() {
    return Container(
      child: ListView.builder(
          itemBuilder: (BuildContext context, final int index) {
            RecommendsList hotRecommendsDto = recommendsList[index];
            List<Datas> dataRecommendsList = hotRecommendsDto.list;
            return ListTile(
              onTap: () {},
              title: Text(
                "${hotRecommendsDto.title}",
                style: new TextStyle(fontSize: 14),
              ),
              subtitle: _widgetRecommendsCards(dataRecommendsList),
            );
          },
          itemCount: recommendsList.length),
    );
  }

  Widget _widgetBody() {
    return Container(
      child: _widgetRecommendsTitles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("热门推荐", style: TextStyle(fontSize: 15)),
      ),
      body: _widgetBody(),
    );
  }
}
