import 'package:anti_facebook_app/models/user.dart';

List<Comment> commentsFromJson(dynamic str) =>
    List<Comment>.from(str.map((x) => Comment.fromJson(x)));

class Comment {
  late User user;
  late String content;
  late String? image;
  late String? time;
  late List<Comment>? replies;
  late int? markId;
  late int? type;
  late int? id;
  late int? typeOfMark;

  Comment({
    required this.user,
    required this.content,
    this.image,
    this.time,
    this.replies,
    this.id,
    this.markId,
    this.type,
    this.typeOfMark,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    print('this is comment');
    id = int.parse(json['id'].toString());
    content = json['mark_content'];
    time = json['created'];
    typeOfMark = int.parse(json['type_of_mark'].toString());
    content = json['mark_content'];
    user = User.fromJson(json['poster']);
    if (json['comments'].isEmpty) replies = commentsFromJson(json['comments']);
  }
}
