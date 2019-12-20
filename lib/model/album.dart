class Album {
  int totalPage;
  int totalCount;
  int currentPage;
  List<Albums> albums;

  Album({this.totalPage, this.totalCount, this.currentPage, this.albums});

  Album.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    totalCount = json['total_count'];
    currentPage = json['current_page'];
    if (json['albums'] != null) {
      albums = new List<Albums>();
      json['albums'].forEach((v) {
        albums.add(new Albums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['total_count'] = this.totalCount;
    data['current_page'] = this.currentPage;
    if (this.albums != null) {
      data['albums'] = this.albums.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Albums {
  int id;
  String kind;
  int categoryId;
  String albumTitle;
  String albumTags;
  String albumIntro;
  String coverUrl;
  String coverUrlSmall;
  String coverUrlMiddle;
  String coverUrlLarge;
  bool tracksNaturalOrdered;
  Announcer announcer;
  int playCount;
  int favoriteCount;
  int shareCount;
  int subscribeCount;
  int includeTrackCount;
  LastUptrack lastUptrack;
  bool canDownload;
  int isFinished;
  int updatedAt;
  int createdAt;
  bool isPaid;
  int estimatedTrackCount;
  String albumRichIntro;
  String speakerIntro;
  int freeTrackCount;
  String freeTrackIds;
  String saleIntro;
  String expectedRevenue;
  String buyNotes;
  String speakerTitle;
  String speakerContent;
  bool hasSample;
  int composedPriceType;
  String detailBannerUrl;
  String shortIntro;
  bool isVipfree;
  bool isVipExclusive;
  String meta;
  String sellingPoint;
  String recommendReason;

  Albums(
      {this.id,
      this.kind,
      this.categoryId,
      this.albumTitle,
      this.albumTags,
      this.albumIntro,
      this.coverUrl,
      this.coverUrlSmall,
      this.coverUrlMiddle,
      this.coverUrlLarge,
      this.tracksNaturalOrdered,
      this.announcer,
      this.playCount,
      this.favoriteCount,
      this.shareCount,
      this.subscribeCount,
      this.includeTrackCount,
      this.lastUptrack,
      this.canDownload,
      this.isFinished,
      this.updatedAt,
      this.createdAt,
      this.isPaid,
      this.estimatedTrackCount,
      this.albumRichIntro,
      this.speakerIntro,
      this.freeTrackCount,
      this.freeTrackIds,
      this.saleIntro,
      this.expectedRevenue,
      this.buyNotes,
      this.speakerTitle,
      this.speakerContent,
      this.hasSample,
      this.composedPriceType,
      this.detailBannerUrl,
      this.shortIntro,
      this.isVipfree,
      this.isVipExclusive,
      this.meta,
      this.sellingPoint,
      this.recommendReason});

  Albums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kind = json['kind'];
    categoryId = json['category_id'];
    albumTitle = json['album_title'];
    albumTags = json['album_tags'];
    albumIntro = json['album_intro'];
    coverUrl = json['cover_url'];
    coverUrlSmall = json['cover_url_small'];
    coverUrlMiddle = json['cover_url_middle'];
    coverUrlLarge = json['cover_url_large'];
    tracksNaturalOrdered = json['tracks_natural_ordered'];
    announcer = json['announcer'] != null
        ? new Announcer.fromJson(json['announcer'])
        : null;
    playCount = json['play_count'];
    favoriteCount = json['favorite_count'];
    shareCount = json['share_count'];
    subscribeCount = json['subscribe_count'];
    includeTrackCount = json['include_track_count'];
    lastUptrack = json['last_uptrack'] != null
        ? new LastUptrack.fromJson(json['last_uptrack'])
        : null;
    canDownload = json['can_download'];
    isFinished = json['is_finished'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    isPaid = json['is_paid'];
    estimatedTrackCount = json['estimated_track_count'];
    albumRichIntro = json['album_rich_intro'];
    speakerIntro = json['speaker_intro'];
    freeTrackCount = json['free_track_count'];
    freeTrackIds = json['free_track_ids'];
    saleIntro = json['sale_intro'];
    expectedRevenue = json['expected_revenue'];
    buyNotes = json['buy_notes'];
    speakerTitle = json['speaker_title'];
    speakerContent = json['speaker_content'];
    hasSample = json['has_sample'];
    composedPriceType = json['composed_price_type'];
    detailBannerUrl = json['detail_banner_url'];
    shortIntro = json['short_intro'];
    isVipfree = json['is_vipfree'];
    isVipExclusive = json['is_vip_exclusive'];
    meta = json['meta'];
    sellingPoint = json['selling_point'];
    recommendReason = json['recommend_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['category_id'] = this.categoryId;
    data['album_title'] = this.albumTitle;
    data['album_tags'] = this.albumTags;
    data['album_intro'] = this.albumIntro;
    data['cover_url'] = this.coverUrl;
    data['cover_url_small'] = this.coverUrlSmall;
    data['cover_url_middle'] = this.coverUrlMiddle;
    data['cover_url_large'] = this.coverUrlLarge;
    data['tracks_natural_ordered'] = this.tracksNaturalOrdered;
    if (this.announcer != null) {
      data['announcer'] = this.announcer.toJson();
    }
    data['play_count'] = this.playCount;
    data['favorite_count'] = this.favoriteCount;
    data['share_count'] = this.shareCount;
    data['subscribe_count'] = this.subscribeCount;
    data['include_track_count'] = this.includeTrackCount;
    if (this.lastUptrack != null) {
      data['last_uptrack'] = this.lastUptrack.toJson();
    }
    data['can_download'] = this.canDownload;
    data['is_finished'] = this.isFinished;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['is_paid'] = this.isPaid;
    data['estimated_track_count'] = this.estimatedTrackCount;
    data['album_rich_intro'] = this.albumRichIntro;
    data['speaker_intro'] = this.speakerIntro;
    data['free_track_count'] = this.freeTrackCount;
    data['free_track_ids'] = this.freeTrackIds;
    data['sale_intro'] = this.saleIntro;
    data['expected_revenue'] = this.expectedRevenue;
    data['buy_notes'] = this.buyNotes;
    data['speaker_title'] = this.speakerTitle;
    data['speaker_content'] = this.speakerContent;
    data['has_sample'] = this.hasSample;
    data['composed_price_type'] = this.composedPriceType;
    data['detail_banner_url'] = this.detailBannerUrl;
    data['short_intro'] = this.shortIntro;
    data['is_vipfree'] = this.isVipfree;
    data['is_vip_exclusive'] = this.isVipExclusive;
    data['meta'] = this.meta;
    data['selling_point'] = this.sellingPoint;
    data['recommend_reason'] = this.recommendReason;
    return data;
  }
}

class Announcer {
  int id;
  String kind;
  String nickname;
  String avatarUrl;
  bool isVerified;
  int anchorGrade;

  Announcer(
      {this.id,
      this.kind,
      this.nickname,
      this.avatarUrl,
      this.isVerified,
      this.anchorGrade});

  Announcer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kind = json['kind'];
    nickname = json['nickname'];
    avatarUrl = json['avatar_url'];
    isVerified = json['is_verified'];
    anchorGrade = json['anchor_grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['nickname'] = this.nickname;
    data['avatar_url'] = this.avatarUrl;
    data['is_verified'] = this.isVerified;
    data['anchor_grade'] = this.anchorGrade;
    return data;
  }
}

class LastUptrack {
  int trackId;
  String trackTitle;
  int duration;
  int createdAt;
  int updatedAt;

  LastUptrack(
      {this.trackId,
      this.trackTitle,
      this.duration,
      this.createdAt,
      this.updatedAt});

  LastUptrack.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    trackTitle = json['track_title'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track_id'] = this.trackId;
    data['track_title'] = this.trackTitle;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
