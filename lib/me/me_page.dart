import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MePageStateful();
  }
}

class _MePageStateful extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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

      body: (Text("我", style: TextStyle(fontSize: 15))),
    );
  }

//    return new Scaffold(
//      backgroundColor: Colors.transparent,
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        centerTitle: true,
//        title: Text("我", style: TextStyle(fontSize: 15)),
//      ),
//      body: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//          image: NetworkImage(
//              'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
//          fit: BoxFit.cover,
//        )),
//      ),
//    );
//  }
}
