import '../models/user.dart';

class UserInfo {
  static var userId;
  static var userName;
  static var email;
  static var avatar;
  static var token;
  static User user = User(
    userId: userId,
    name: userName,
      avatar: avatar,
  );
}