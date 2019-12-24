import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'menu/menu.dart';

void main() {
  runApp(new MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
//https://pub.flutter-io.cn/packages
////https://javiercbk.github.io/json_to_dart/
//分页获取听单内容
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
      home: MenuPage(),
    );
  }
}
//  Size size = MediaQuery
//      .of(context)
//      .size;
///
