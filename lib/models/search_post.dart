class SearchPost {
  String? code;
  String? message;
  List<Data>? data;

  SearchPost({this.code, this.message, this.data});

  SearchPost.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  List<Image>? image;
  String? described;
  String? created;
  String? feel;
  String? markComment;
  String? isFelt;
  String? state;
  Author? author;
  Video? video;

  Data(
      {this.id,
        this.name,
        this.image,
        this.described,
        this.created,
        this.feel,
        this.markComment,
        this.isFelt,
        this.state,
        this.author,
        this.video});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    described = json['described'];
    created = json['created'];
    feel = json['feel'];
    markComment = json['mark_comment'];
    isFelt = json['is_felt'];
    state = json['state'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['described'] = described;
    data['created'] = created;
    data['feel'] = feel;
    data['mark_comment'] = markComment;
    data['is_felt'] = isFelt;
    data['state'] = state;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class Image {
  String? id;
  String? url;

  Image({this.id, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Author {
  String? id;
  String? name;
  String? avatar;

  Author({this.id, this.name, this.avatar});
  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}

class Video {
  String? url;

  Video({this.url});

  Video.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    return data;
  }
}
class Request {
  String? keyword;
  String? userId;
  String? index;
  String? count;

  Request({this.keyword, this.userId, this.index, this.count});

  Request.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    userId = json['user_id'];
    index = json['index'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['keyword'] = keyword;
    data['user_id'] = userId;
    data['index'] = index;
    data['count'] = count;
    return data;
  }
}
