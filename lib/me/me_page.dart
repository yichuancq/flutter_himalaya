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
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("我", style: TextStyle(fontSize: 15)),
      ),
      body: Center(
        child: Text("me"),
      ),
    );
  }
}
