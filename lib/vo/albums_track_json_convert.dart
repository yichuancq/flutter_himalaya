import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_himalaya/model/album.dart';
import 'package:flutter_himalaya/model/album_content.dart';

///解析站点JSON为对象集合
Future<String> loadJsonFile() async {
  return await rootBundle.loadString('assets/json/album-content.json');
}

///convertFromAlbumJson
Future<AlbumContent> convertFromAlbumTractsJson() async {
  String jsonString = await loadJsonFile();
  final jsonMap = json.decode(jsonString);
  AlbumContent album = AlbumContent.fromJson(jsonMap);
  return album;
}
