import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_himalaya/model/track_item.dart';

///// 专辑明细播放列表
Future<TruckItemDto> getTruckItemMusic(int trackId) async {
  try {
    Map<String, dynamic> headers = new Map();

    //注意这个
    //responseType: ResponseType.plain
    headers['Cookie'] =
        "_xmLog=xm_k3h4nt69ipo2hv; device_id=xm_1574849383796_k3h4ntkkle2qmn; s&e=2c1f306096423deedfdcf186031b772f; trackType=web; x_xmly_traffic=utm_source%253A%2526utm_medium%253A%2526utm_campaign%253A%2526utm_content%253A%2526utm_term%253A%2526utm_from%253A; Hm_lvt_4a7d8ec50cfd6af753c4f8aee3425070=1576867153,1576991329,1577002264,1577011147; s&a=L%0C^%09YSASCQ[UY%07%1E%06%1E%01%0B%04%04RCYJ%5C^%05UXM%09V]^O^OLTVZVU^OCXN; Hm_lpvt_4a7d8ec50cfd6af753c4f8aee3425070=1577012269";
    Options options =
        new Options(headers: headers, responseType: ResponseType.plain);
    //https://www.ximalaya.com/revision/play/v1/audio?id=238014616&ptype=1
    final String url =
        "https://www.ximalaya.com/revision/play/v1/audio?id=${trackId}&ptype=1";
    Response response = await Dio().get(url, options: options);
    if (response.statusCode == 200) {
      print(response.request.uri);
      String result = response.data.toString();
      final jsonMap = json.decode(result);
      return TruckItemDto.fromJson(jsonMap);
    }
  } catch (e) {
    print(e);
  }
}
