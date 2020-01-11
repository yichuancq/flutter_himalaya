import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_himalaya/model/hot_recommends.dart';

///解析对象集合
Future<String> loadRecommendsJsonFile() async {
  return await rootBundle.loadString('assets/json/hot_recommends.json');
}

///convertFromRecommendsJson
Future<HotRecommendsDto> convertFromRecommendsJson() async {
  String jsonString = await loadRecommendsJsonFile();
  final jsonMap = json.decode(jsonString);
  HotRecommendsDto albumContent = HotRecommendsDto.fromJson(jsonMap);
  return albumContent;
}
