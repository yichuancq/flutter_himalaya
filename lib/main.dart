import 'package:flutter/material.dart';
import 'package:flutter_himalaya/albums/Home.dart';
import 'albums/albums_cardview_list.dart';

void main() => runApp(MyApp());

////https://javiercbk.github.io/json_to_dart/
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
