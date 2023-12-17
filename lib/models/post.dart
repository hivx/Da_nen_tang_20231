import 'package:anti_facebook_app/models/user.dart';

List<Post> postsFromJson(dynamic str) =>
    List<Post>.from(str.map((x) => Post.fromJson(x)));

class Post {
  late int? id = 0;
  late User user;
  late String time;
  late String? shareWith;
  late List<String>? image;
  late String? video;
  late String? content;
  // late String? checkin;
  late int? like;
  late int? haha;
  late int? sad;
  late int? love;
  late int? lovelove;
  late int? angry;
  late int? comment;
  late int? share;
  late int? wow;
  late String? layout; // classic, column, quote, frame
  late String? type; //normal, share, memory, ...
  late String? name;
  late int? feel;
  late int? commentMark;
  late int? isFelt;
  late int? isBlocked;
  late int? canEdit;
  late int? banned;
  late String? state;
  Post({
    this.id,
    required this.user,
    required this.time,
    this.image,
    this.video,
    this.content,
    this.like,
    this.love,
    this.comment,
    this.haha,
    this.share,
    this.lovelove,
    this.wow,
    this.layout,
    this.shareWith,
    this.sad,
    this.angry,
    this.type,
    this.name,
    this.feel,
    this.commentMark,
    this.isFelt,
    this.isBlocked,
    this.canEdit,
    this.banned,
    this.state,
  });

  Post copyWith({
    User? user,
    String? time,
    String? shareWith,
    List<String>? image,
    String? video,
    String? content,
    int? like,
    int? haha,
    int? sad,
    int? love,
    int? lovelove,
    int? angry,
    int? comment,
    int? share,
    int? wow,
    String? layout,
    String? type,
    String? name,
    int? feel,
    int? commentMark,
    int? isFelt,
    int? isBlocked,
    int? canEdit,
    int? banned,
    String? state,
  }) {
    return Post(
      user: user ?? this.user,
      time: time ?? this.time,
      shareWith: shareWith ?? this.shareWith,
      image: image ?? this.image,
      video: video ?? this.video,
      content: content ?? this.content,
      like: like ?? this.like,
      haha: haha ?? this.haha,
      sad: sad ?? this.sad,
      love: love ?? this.love,
      lovelove: lovelove ?? this.lovelove,
      angry: angry ?? this.angry,
      comment: comment ?? this.comment,
      share: share ?? this.share,
      wow: wow ?? this.wow,
      layout: layout ?? this.layout,
      type: type ?? this.type,
      name: name ?? this.name,
      feel: feel ?? this.feel,
      commentMark: commentMark ?? this.commentMark,
      isFelt: isFelt ?? this.isFelt,
      isBlocked: isBlocked ?? this.isBlocked,
      canEdit: canEdit ?? this.canEdit,
      banned: banned ?? this.banned,
      state: state ?? this.state,
    );
  }

  Post.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    if (json['image'] != null && (json['image'] as List).isNotEmpty) {
      image = (json['image'] as List)
          .map((item) => item['url'].toString())
          .toList();
    } else {
      image = [];
    }
    if (json.containsKey('video')) {
      video = json['video']['url'];
    } else {
      video = '';
    }
    print(video);

    content = json['described'];
    time = json['created'];
    feel = int.parse(json['feel'].toString());
    commentMark = int.parse(json['comment_mark'].toString());
    isFelt = int.parse(json['is_felt'].toString());
    isBlocked = int.parse(json['is_blocked'].toString());
    canEdit = int.parse(json['can_edit'].toString());
    banned = int.parse(json['banned'].toString());
    state = json['state'];
    user = User.fromJson(json['author']);
    like = 1000;
    love = 7300;
    comment = 258;
    haha = 235;
    share = 825;
    lovelove = 212;
    wow = 9;
    layout = 'frame';
    shareWith = 'public';
    type = '';
    sad = 267;
    angry = 0;
    print(image);
  }
}
