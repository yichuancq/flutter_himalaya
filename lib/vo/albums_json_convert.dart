import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_himalaya/model/album.dart';

///解析站点JSON为对象集合
Future<String> loadJsonFile() async {
  ///Users/yichuan/StudioProjects/flutter_himalaya/assets/json/albums.json
  return await rootBundle.loadString('assets/json/albums.json');
}

///convertFromAlbumJson
Future<Album> convertFromAlbumJson() async {
  String jsonString = await loadJsonFile();
  final jsonMap = json.decode(jsonString);
  Album album = Album.fromJson(jsonMap);
  return album;
}
