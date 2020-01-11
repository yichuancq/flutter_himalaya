class HotRecommendsDto {
  String msg;
  int ret;
  HotRecommends hotRecommends;

  HotRecommendsDto({this.msg, this.ret, this.hotRecommends});

  HotRecommendsDto.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    ret = json['ret'];
    hotRecommends = json['hotRecommends'] != null
        ? new HotRecommends.fromJson(json['hotRecommends'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['ret'] = this.ret;
    if (this.hotRecommends != null) {
      data['hotRecommends'] = this.hotRecommends.toJson();
    }
    return data;
  }
}

class HotRecommends {
  int ret;
  String title;
  List<RecommendsList> recommendsList;

  HotRecommends({this.ret, this.title, this.recommendsList});

  HotRecommends.fromJson(Map<String, dynamic> json) {
    ret = json['ret'];
    title = json['title'];
    if (json['recommendsList'] != null) {
      recommendsList = new List<RecommendsList>();
      json['recommendsList'].forEach((v) {
        recommendsList.add(new RecommendsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ret'] = this.ret;
    data['title'] = this.title;
    if (this.recommendsList != null) {
      data['recommendsList'] =
          this.recommendsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendsList {
  String title;
  String contentType;
  bool isFinished;
  int categoryId;
  int categoryType;
  int count;
  bool hasMore;
  List<Datas> list;
  bool filterSupported;
  bool isPaid;

  RecommendsList(
      {this.title,
      this.contentType,
      this.isFinished,
      this.categoryId,
      this.categoryType,
      this.count,
      this.hasMore,
      this.list,
      this.filterSupported,
      this.isPaid});

  RecommendsList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contentType = json['contentType'];
    isFinished = json['isFinished'];
    categoryId = json['categoryId'];
    categoryType = json['categoryType'];
    count = json['count'];
    hasMore = json['hasMore'];
    if (json['datas'] != null) {
      list = new List<Datas>();
      json['datas'].forEach((v) {
        list.add(new Datas.fromJson(v));
      });
    }
    filterSupported = json['filterSupported'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['contentType'] = this.contentType;
    data['isFinished'] = this.isFinished;
    data['categoryId'] = this.categoryId;
    data['categoryType'] = this.categoryType;
    data['count'] = this.count;
    data['hasMore'] = this.hasMore;
    if (this.list != null) {
      data['datas'] = this.list.map((v) => v.toJson()).toList();
    }
    data['filterSupported'] = this.filterSupported;
    data['isPaid'] = this.isPaid;
    return data;
  }
}

class Datas {
  int id;
  int albumId;
  int uid;
  String intro;
  String nickname;
  String albumCoverUrl290;
  String coverSmall;
  String coverMiddle;
  String coverLarge;
  String title;
  String tags;
  int tracks;
  int playsCounts;
  int isFinished;
  int serialState;
  int trackId;
  String trackTitle;
  String provider;
  bool isPaid;
  int commentsCount;
  int priceTypeId;
  double price;
  double discountedPrice;
  double score;
  String displayPrice;
  String displayDiscountedPrice;
  int priceTypeEnum;
  int vipFreeType;
  int refundSupportType;
  double vipPrice;
  String displayVipPrice;
  bool isVipFree;
  String priceUnit;
  bool isDraft;

  Datas(
      {this.id,
      this.albumId,
      this.uid,
      this.intro,
      this.nickname,
      this.albumCoverUrl290,
      this.coverSmall,
      this.coverMiddle,
      this.coverLarge,
      this.title,
      this.tags,
      this.tracks,
      this.playsCounts,
      this.isFinished,
      this.serialState,
      this.trackId,
      this.trackTitle,
      this.provider,
      this.isPaid,
      this.commentsCount,
      this.priceTypeId,
      this.price,
      this.discountedPrice,
      this.score,
      this.displayPrice,
      this.displayDiscountedPrice,
      this.priceTypeEnum,
      this.vipFreeType,
      this.refundSupportType,
      this.vipPrice,
      this.displayVipPrice,
      this.isVipFree,
      this.priceUnit,
      this.isDraft});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumId = json['albumId'];
    uid = json['uid'];
    intro = json['intro'];
    nickname = json['nickname'];
    albumCoverUrl290 = json['albumCoverUrl290'];
    coverSmall = json['coverSmall'];
    coverMiddle = json['coverMiddle'];
    coverLarge = json['coverLarge'];
    title = json['title'];
    tags = json['tags'];
    tracks = json['tracks'];
    playsCounts = json['playsCounts'];
    isFinished = json['isFinished'];
    serialState = json['serialState'];
    trackId = json['trackId'];
    trackTitle = json['trackTitle'];
    provider = json['provider'];
    isPaid = json['isPaid'];
    commentsCount = json['commentsCount'];
    priceTypeId = json['priceTypeId'];
    price = json['price'];
    discountedPrice = json['discountedPrice'];
    score = json['score'];
    displayPrice = json['displayPrice'];
    displayDiscountedPrice = json['displayDiscountedPrice'];
    priceTypeEnum = json['priceTypeEnum'];
    vipFreeType = json['vipFreeType'];
    refundSupportType = json['refundSupportType'];
    vipPrice = json['vipPrice'];
    displayVipPrice = json['displayVipPrice'];
    isVipFree = json['isVipFree'];
    priceUnit = json['priceUnit'];
    isDraft = json['isDraft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['albumId'] = this.albumId;
    data['uid'] = this.uid;
    data['intro'] = this.intro;
    data['nickname'] = this.nickname;
    data['albumCoverUrl290'] = this.albumCoverUrl290;
    data['coverSmall'] = this.coverSmall;
    data['coverMiddle'] = this.coverMiddle;
    data['coverLarge'] = this.coverLarge;
    data['title'] = this.title;
    data['tags'] = this.tags;
    data['tracks'] = this.tracks;
    data['playsCounts'] = this.playsCounts;
    data['isFinished'] = this.isFinished;
    data['serialState'] = this.serialState;
    data['trackId'] = this.trackId;
    data['trackTitle'] = this.trackTitle;
    data['provider'] = this.provider;
    data['isPaid'] = this.isPaid;
    data['commentsCount'] = this.commentsCount;
    data['priceTypeId'] = this.priceTypeId;
    data['price'] = this.price;
    data['discountedPrice'] = this.discountedPrice;
    data['score'] = this.score;
    data['displayPrice'] = this.displayPrice;
    data['displayDiscountedPrice'] = this.displayDiscountedPrice;
    data['priceTypeEnum'] = this.priceTypeEnum;
    data['vipFreeType'] = this.vipFreeType;
    data['refundSupportType'] = this.refundSupportType;
    data['vipPrice'] = this.vipPrice;
    data['displayVipPrice'] = this.displayVipPrice;
    data['isVipFree'] = this.isVipFree;
    data['priceUnit'] = this.priceUnit;
    data['isDraft'] = this.isDraft;
    return data;
  }
}
