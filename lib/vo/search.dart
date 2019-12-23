import 'dart:convert';

import 'package:dio/dio.dart';

Future searchAlbumByKeyWords(String keyWord) async {
  try {
    Map<String, dynamic> headers = new Map();

    //注意这个
    //responseType: ResponseType.plain
    headers['Cookie'] =
        "_xmLog=xm_k3h4nt69ipo2hv; device_id=xm_1574849383796_k3h4ntkkle2qmn; s&e=2c1f306096423deedfdcf186031b772f; trackType=web; x_xmly_traffic=utm_source%253A%2526utm_medium%253A%2526utm_campaign%253A%2526utm_content%253A%2526utm_term%253A%2526utm_from%253A; Hm_lvt_4a7d8ec50cfd6af753c4f8aee3425070=1576991329,1577002264,1577011147,1577108848; Hm_lpvt_4a7d8ec50cfd6af753c4f8aee3425070=1577109292; s&a=L%0C^%09YSASCQ[UY%07%1E%06%1E%01%0B%04%04RCYJ%5C^%05UXM%09V]WOXZWRB%5CCZWRW[A_";
    //53b7f979f9fa9413e75fd661e2380875(96)1577111731071(61)1577111697747
    headers['xm-sign'] =
        '7b211aa409f4edef70954ba1528bb9f3(55)1577112700220(63)1577112638617';
    headers['Connection'] = 'keep-alive';
    headers['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8';
    Options options =
        new Options(headers: headers, responseType: ResponseType.plain);
    final String url =
        "https://www.ximalaya.com/revision/search/main?core=all&kw=轻音乐&spellchecker=true&device=iPhone";
    Response response = await Dio().get(url, options: options);
    if (response.statusCode == 200) {
      print(response.request.uri);
      String result = response.data.toString();
      print(result);
      final jsonMap = json.decode(result);
      // return TrackDto.fromJson(jsonMap);
    }
  } catch (e) {
    print(e);
  }
}
