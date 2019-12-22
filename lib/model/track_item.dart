///专辑明细的音乐
class TruckItemDto {
  int ret;
  Data data;

  TruckItemDto({this.ret, this.data});

  TruckItemDto.fromJson(Map<String, dynamic> json) {
    ret = json['ret'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ret'] = this.ret;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int trackId;
  bool canPlay;
  bool isPaid;
  bool hasBuy;
  String src; // music url
  bool albumIsSample;
  int sampleDuration;
  bool isBaiduMusic;
  bool firstPlayStatus;

  Data(
      {this.trackId,
      this.canPlay,
      this.isPaid,
      this.hasBuy,
      this.src,
      this.albumIsSample,
      this.sampleDuration,
      this.isBaiduMusic,
      this.firstPlayStatus});

  Data.fromJson(Map<String, dynamic> json) {
    trackId = json['trackId'];
    canPlay = json['canPlay'];
    isPaid = json['isPaid'];
    hasBuy = json['hasBuy'];
    src = json['src'];
    albumIsSample = json['albumIsSample'];
    sampleDuration = json['sampleDuration'];
    isBaiduMusic = json['isBaiduMusic'];
    firstPlayStatus = json['firstPlayStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackId'] = this.trackId;
    data['canPlay'] = this.canPlay;
    data['isPaid'] = this.isPaid;
    data['hasBuy'] = this.hasBuy;
    data['src'] = this.src;
    data['albumIsSample'] = this.albumIsSample;
    data['sampleDuration'] = this.sampleDuration;
    data['isBaiduMusic'] = this.isBaiduMusic;
    data['firstPlayStatus'] = this.firstPlayStatus;
    return data;
  }
}
