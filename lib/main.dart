import 'package:flutter/material.dart';
import 'package:flutter_himalaya/bak/Home.dart';
import 'albums/albums_cardview_list.dart';

void main() => runApp(MyApp());
//https://pub.flutter-io.cn/packages
////https://javiercbk.github.io/json_to_dart/
//分页获取听单内容

///albums/browse
///根据专辑ID获取专辑下的声音列表，即专辑浏览
///分页获取听单内容
////operation/browse_column_content

///operation/browse_column_content
///
/// //http://open.ximalaya.com/doc/detailQuickStart?categoryId=15&articleId=27#%E9%A6%96%E9%A1%B5
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShow
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
//      home:  Home(),
      home: AlbumsList(),
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//  Size size = MediaQuery
//      .of(context)
//      .size;
///
