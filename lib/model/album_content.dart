import 'package:flutter_himalaya/model/tracks.dart';

class AlbumContent {
  int ret;
  String msg;
  Data data;

  AlbumContent({this.ret, this.msg, this.data});

  AlbumContent.fromJson(Map<String, dynamic> json) {
    ret = json['ret'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ret'] = this.ret;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MainInfo {
  int albumStatus;
  bool showApplyFinishBtn;
  bool showEditBtn;
  bool showTrackManagerBtn;
  bool showInformBtn;
  String cover;
  String albumTitle;
  Crumbs crumbs;
  String updateDate;
  String createDate;
  int playCount;
  bool isPaid;
  int isFinished;
  List<Metas> metas;
  bool isSubscribe;
  String richIntro;
  String shortIntro;
  String detailRichIntro;
  bool isPublic;
  bool hasBuy;
  int vipType;
  bool canCopyText;
  int subscribeCount;

  MainInfo(
      {this.albumStatus,
      this.showApplyFinishBtn,
      this.showEditBtn,
      this.showTrackManagerBtn,
      this.showInformBtn,
      this.cover,
      this.albumTitle,
      this.crumbs,
      this.updateDate,
      this.createDate,
      this.playCount,
      this.isPaid,
      this.isFinished,
      this.metas,
      this.isSubscribe,
      this.richIntro,
      this.shortIntro,
      this.detailRichIntro,
      this.isPublic,
      this.hasBuy,
      this.vipType,
      this.canCopyText,
      this.subscribeCount});

  MainInfo.fromJson(Map<String, dynamic> json) {
    albumStatus = json['albumStatus'];
    showApplyFinishBtn = json['showApplyFinishBtn'];
    showEditBtn = json['showEditBtn'];
    showTrackManagerBtn = json['showTrackManagerBtn'];
    showInformBtn = json['showInformBtn'];
    cover = json['cover'];
    albumTitle = json['albumTitle'];
    crumbs =
        json['crumbs'] != null ? new Crumbs.fromJson(json['crumbs']) : null;
    updateDate = json['updateDate'];
    createDate = json['createDate'];
    playCount = json['playCount'];
    isPaid = json['isPaid'];
    isFinished = json['isFinished'];
    if (json['metas'] != null) {
      metas = new List<Metas>();
      json['metas'].forEach((v) {
        metas.add(new Metas.fromJson(v));
      });
    }
    isSubscribe = json['isSubscribe'];
    richIntro = json['richIntro'];
    shortIntro = json['shortIntro'];
    detailRichIntro = json['detailRichIntro'];
    isPublic = json['isPublic'];
    hasBuy = json['hasBuy'];
    vipType = json['vipType'];
    canCopyText = json['canCopyText'];
    subscribeCount = json['subscribeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumStatus'] = this.albumStatus;
    data['showApplyFinishBtn'] = this.showApplyFinishBtn;
    data['showEditBtn'] = this.showEditBtn;
    data['showTrackManagerBtn'] = this.showTrackManagerBtn;
    data['showInformBtn'] = this.showInformBtn;
    data['cover'] = this.cover;
    data['albumTitle'] = this.albumTitle;
    if (this.crumbs != null) {
      data['crumbs'] = this.crumbs.toJson();
    }
    data['updateDate'] = this.updateDate;
    data['createDate'] = this.createDate;
    data['playCount'] = this.playCount;
    data['isPaid'] = this.isPaid;
    data['isFinished'] = this.isFinished;
    if (this.metas != null) {
      data['metas'] = this.metas.map((v) => v.toJson()).toList();
    }
    data['isSubscribe'] = this.isSubscribe;
    data['richIntro'] = this.richIntro;
    data['shortIntro'] = this.shortIntro;
    data['detailRichIntro'] = this.detailRichIntro;
    data['isPublic'] = this.isPublic;
    data['hasBuy'] = this.hasBuy;
    data['vipType'] = this.vipType;
    data['canCopyText'] = this.canCopyText;
    data['subscribeCount'] = this.subscribeCount;
    return data;
  }
}

class Crumbs {
  int categoryId;
  String categoryPinyin;
  String categoryTitle;
  int subcategoryId;
  String subcategoryName;
  String subcategoryDisplayName;
  String subcategoryCode;

  Crumbs(
      {this.categoryId,
      this.categoryPinyin,
      this.categoryTitle,
      this.subcategoryId,
      this.subcategoryName,
      this.subcategoryDisplayName,
      this.subcategoryCode});

  Crumbs.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryPinyin = json['categoryPinyin'];
    categoryTitle = json['categoryTitle'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
    subcategoryDisplayName = json['subcategoryDisplayName'];
    subcategoryCode = json['subcategoryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryPinyin'] = this.categoryPinyin;
    data['categoryTitle'] = this.categoryTitle;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['subcategoryDisplayName'] = this.subcategoryDisplayName;
    data['subcategoryCode'] = this.subcategoryCode;
    return data;
  }
}

class Metas {
  int metaValueId;
  int metaDataId;
  int categoryId;
  bool isSubCategory;
  String categoryName;
  String categoryPinyin;
  String metaValueCode;
  String metaDisplayName;
  String link;

  Metas(
      {this.metaValueId,
      this.metaDataId,
      this.categoryId,
      this.isSubCategory,
      this.categoryName,
      this.categoryPinyin,
      this.metaValueCode,
      this.metaDisplayName,
      this.link});

  Metas.fromJson(Map<String, dynamic> json) {
    metaValueId = json['metaValueId'];
    metaDataId = json['metaDataId'];
    categoryId = json['categoryId'];
    isSubCategory = json['isSubCategory'];
    categoryName = json['categoryName'];
    categoryPinyin = json['categoryPinyin'];
    metaValueCode = json['metaValueCode'];
    metaDisplayName = json['metaDisplayName'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metaValueId'] = this.metaValueId;
    data['metaDataId'] = this.metaDataId;
    data['categoryId'] = this.categoryId;
    data['isSubCategory'] = this.isSubCategory;
    data['categoryName'] = this.categoryName;
    data['categoryPinyin'] = this.categoryPinyin;
    data['metaValueCode'] = this.metaValueCode;
    data['metaDisplayName'] = this.metaDisplayName;
    data['link'] = this.link;
    return data;
  }
}

class AnchorInfo {
  int anchorId;
  String anchorCover;
  bool showFollowBtn;
  String anchorName;
  int anchorGrade;
  int anchorGradeType;
  int anchorAlbumsCount;
  int anchorTracksCount;
  int anchorFollowsCount;
  int anchorFansCount;
  String personalIntroduction;
  bool showAnchorAlbumModel;
  List<AnchorAlbumList> anchorAlbumList;
  bool hasMoreBtn;
  int logoType;

  AnchorInfo(
      {this.anchorId,
      this.anchorCover,
      this.showFollowBtn,
      this.anchorName,
      this.anchorGrade,
      this.anchorGradeType,
      this.anchorAlbumsCount,
      this.anchorTracksCount,
      this.anchorFollowsCount,
      this.anchorFansCount,
      this.personalIntroduction,
      this.showAnchorAlbumModel,
      this.anchorAlbumList,
      this.hasMoreBtn,
      this.logoType});

  AnchorInfo.fromJson(Map<String, dynamic> json) {
    anchorId = json['anchorId'];
    anchorCover = json['anchorCover'];
    showFollowBtn = json['showFollowBtn'];
    anchorName = json['anchorName'];
    anchorGrade = json['anchorGrade'];
    anchorGradeType = json['anchorGradeType'];
    anchorAlbumsCount = json['anchorAlbumsCount'];
    anchorTracksCount = json['anchorTracksCount'];
    anchorFollowsCount = json['anchorFollowsCount'];
    anchorFansCount = json['anchorFansCount'];
    personalIntroduction = json['personalIntroduction'];
    showAnchorAlbumModel = json['showAnchorAlbumModel'];
    if (json['anchorAlbumList'] != null) {
      anchorAlbumList = new List<AnchorAlbumList>();
      json['anchorAlbumList'].forEach((v) {
        anchorAlbumList.add(new AnchorAlbumList.fromJson(v));
      });
    }
    hasMoreBtn = json['hasMoreBtn'];
    logoType = json['logoType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anchorId'] = this.anchorId;
    data['anchorCover'] = this.anchorCover;
    data['showFollowBtn'] = this.showFollowBtn;
    data['anchorName'] = this.anchorName;
    data['anchorGrade'] = this.anchorGrade;
    data['anchorGradeType'] = this.anchorGradeType;
    data['anchorAlbumsCount'] = this.anchorAlbumsCount;
    data['anchorTracksCount'] = this.anchorTracksCount;
    data['anchorFollowsCount'] = this.anchorFollowsCount;
    data['anchorFansCount'] = this.anchorFansCount;
    data['personalIntroduction'] = this.personalIntroduction;
    data['showAnchorAlbumModel'] = this.showAnchorAlbumModel;
    if (this.anchorAlbumList != null) {
      data['anchorAlbumList'] =
          this.anchorAlbumList.map((v) => v.toJson()).toList();
    }
    data['hasMoreBtn'] = this.hasMoreBtn;
    data['logoType'] = this.logoType;
    return data;
  }
}

class AnchorAlbumList {
  int albumId;
  String albumTitle;
  String cover;
  int playCount;
  int tracksCount;
  int anchorId;
  String anchorName;
//  String url;

  AnchorAlbumList(
      {this.albumId,
      this.albumTitle,
      this.cover,
      this.playCount,
      this.tracksCount,
      this.anchorId,
      this.anchorName,
//      this.url
      });

  AnchorAlbumList.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    albumTitle = json['albumTitle'];
    cover = json['cover'];
    playCount = json['playCount'];
    tracksCount = json['tracksCount'];
    anchorId = json['anchorId'];
    anchorName = json['anchorName'];
//    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['albumTitle'] = this.albumTitle;
    data['cover'] = this.cover;
    data['playCount'] = this.playCount;
    data['tracksCount'] = this.tracksCount;
    data['anchorId'] = this.anchorId;
    data['anchorName'] = this.anchorName;
//    data['url'] = this.url;
    return data;
  }
}

class TracksInfo {
  int trackTotalCount;
  int sort;
  List<Tracks> tracks;
  int pageNum;
  int pageSize;

  TracksInfo(
      {this.trackTotalCount,
      this.sort,
      this.tracks,
      this.pageNum,
      this.pageSize});

  TracksInfo.fromJson(Map<String, dynamic> json) {
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