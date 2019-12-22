class TrackDto {
  int ret;
  Data data;

  TrackDto({this.ret, this.data});

  TrackDto.fromJson(Map<String, dynamic> json) {
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
  int currentUid;
  int albumId;
  int trackTotalCount;
  int sort;
  List<Tracks> tracks;
  int pageNum;
  int pageSize;
  List<Null> superior;

  Data(
      {this.currentUid,
        this.albumId,
        this.trackTotalCount,
        this.sort,
        this.tracks,
        this.pageNum,
        this.pageSize,
        this.superior});

  Data.fromJson(Map<String, dynamic> json) {
    currentUid = json['currentUid'];
    albumId = json['albumId'];
    trackTotalCount = json['trackTotalCount'];
    sort = json['sort'];
    if (json['tracks'] != null) {
      tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        tracks.add(new Tracks.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentUid'] = this.currentUid;
    data['albumId'] = this.albumId;
    data['trackTotalCount'] = this.trackTotalCount;
    data['sort'] = this.sort;
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class Tracks {
  int index;
  int trackId;
  bool isPaid;
  int tag;
  String title;
  int playCount;
  bool showLikeBtn;
  bool isLike;
  bool showShareBtn;
  bool showCommentBtn;
  bool showForwardBtn;
  String createDateFormat;
  String url;
  int duration;
  bool isVideo;
  Null videoCover;

  Tracks(
      {this.index,
        this.trackId,
        this.isPaid,
        this.tag,
        this.title,
        this.playCount,
        this.showLikeBtn,
        this.isLike,
        this.showShareBtn,
        this.showCommentBtn,
        this.showForwardBtn,
        this.createDateFormat,
        this.url,
        this.duration,
        this.isVideo,
        this.videoCover});

  Tracks.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    trackId = json['trackId'];
    isPaid = json['isPaid'];
    tag = json['tag'];
    title = json['title'];
    playCount = json['playCount'];
    showLikeBtn = json['showLikeBtn'];
    isLike = json['isLike'];
    showShareBtn = json['showShareBtn'];
    showCommentBtn = json['showCommentBtn'];
    showForwardBtn = json['showForwardBtn'];
    createDateFormat = json['createDateFormat'];
    url = json['url'];
    duration = json['duration'];
    isVideo = json['isVideo'];
    videoCover = json['videoCover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['trackId'] = this.trackId;
    data['isPaid'] = this.isPaid;
    data['tag'] = this.tag;
    data['title'] = this.title;
    data['playCount'] = this.playCount;
    data['showLikeBtn'] = this.showLikeBtn;
    data['isLike'] = this.isLike;
    data['showShareBtn'] = this.showShareBtn;
    data['showCommentBtn'] = this.showCommentBtn;
    data['showForwardBtn'] = this.showForwardBtn;
    data['createDateFormat'] = this.createDateFormat;
    data['url'] = this.url;
    data['duration'] = this.duration;
    data['isVideo'] = this.isVideo;
    data['videoCover'] = this.videoCover;
    return data;
  }
}