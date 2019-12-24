import 'dart:ui';

import 'package:flutter/material.dart';

DateTime _lastPressedAt; //上次点击时间

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MePageStateful();
  }
}

class _MePageStateful extends State<MePage> {
  List flagsList = [false, false, false, false];

  ///导航返回拦截
  ///为了避免用户误触返回按钮而导致APP退出，在很多APP中都拦截了用户点击返回键的按钮，
  ///然后进行一些防误触判断，比如当用户在某一个时间段内点击两次时
  ///，才会认为用户是要退出（而非误触）。Flutter中可以通过WillPopScope来实现返回按钮拦截，
  _willPop() {
    return WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(milliseconds: 500)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: _content(),
        ));
  }

  Widget _content() {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: Text("hello"),
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              title: Text("我", style: TextStyle(fontSize: 15)),
            )),
          ),
          preferredSize: Size(double.infinity, 60)),

      body: _content(),
    );
  }
}
