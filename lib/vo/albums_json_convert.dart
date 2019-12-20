import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_himalaya/model/album.dart';

///解析站点JSON为对象集合
Future<String> loadJsonFile() async {
  return await rootBundle.loadString('assets/truckinfo.json');
}

///convertFromAlbumJson
Future<Album> convertFromAlbumJson() async {
  String jsonString = await loadJsonFile();
  final jsonMap = json.decode(jsonString);
  Album truckDto = Album.fromJson(jsonMap);
  return truckDto;
}
