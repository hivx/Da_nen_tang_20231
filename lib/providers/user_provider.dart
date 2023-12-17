import 'package:anti_facebook_app/models/user.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/story.dart';

class UserProvider extends ChangeNotifier {
  late User _user = User(
    name: 'Lê Công ',
    avatar: 'assets/images/user/lcd.jpg',
    educations: [
      Education(
        majors: 'Software Engineering',
        school: 'Trường Đại học Khoa học Tự nhiên, Đại học Quốc gia TP.HCM',
      ),
    ],
    hometown: 'Cai Lậy (huyện)',
    address: "HN",
    followers: 4820,
    friends: 1150,
    hobbies: [
      '💻 Viết mã',
      '📚 Học tập',
      '⚽ Bóng đá',
      '🎮 Trò chơi điện tử',
      '🎧 Nghe nhạc',
      '📖 Đọc sách',
    ],
    socialMedias: [
      SocialMedia(
        icon: 'assets/images/github.png',
        name: 'Dat-TG',
        link: 'https://github.com/Dat-TG',
      ),
      SocialMedia(
          icon: 'assets/images/linkedin.png',
          name: 'ddawst',
          link: 'https://www.linkedin.com/in/ddawst/'),
    ],
    stories: [
      Story(
        user: User(
          name: 'Lê Công Đắt',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        image: ['assets/images/story/3.jpg'],
        time: ['5 giờ'],
        shareWith: 'friends-of-friends',
        name: 'Featured',
      ),
      Story(
        user: User(
          name: 'Lê Công Đắt',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        image: [
          'assets/images/story/4.jpg',
          'assets/images/story/5.jpg',
          'assets/images/story/6.jpg',
          'assets/images/story/7.jpg',
        ],
        video: ['assets/videos/2.mp4', 'assets/videos/1.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '18+',
      ),
      Story(
        user: User(
          name: 'Lê Công Đắt',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        video: ['assets/videos/3.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '20+',
      ),
    ],
    bio: 'I am Dat',
    cover: 'assets/images/user/lcd-cover.jpg',
    guard: true,
    topFriends: [
      User(
        name: 'Khánh Vy',
        avatar: 'assets/images/user/khanhvy.jpg',
      ),
      User(
        name: 'Leo Messi',
        avatar: 'assets/images/user/messi.jpg',
      ),
      User(
        name: 'Minh Hương',
        avatar: 'assets/images/user/minhhuong.jpg',
      ),
      User(
        name: 'Bảo Ngân',
        avatar: 'assets/images/user/baongan.jpg',
      ),
      User(
        name: 'Hà Linhh',
        avatar: 'assets/images/user/halinh.jpg',
      ),
      User(
        name: 'Minh Trí',
        avatar: 'assets/images/user/minhtri.jpg',
      ),
    ],
    posts: [
      Post(
        user: User(
          name: 'Lê Công Đắt',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        time: '3 phút',
        shareWith: 'public',
        content:
            '✅ 10 năm cống hiến cho bóng đá trẻ Việt Nam\n✅ Người đầu tiên đưa Việt Nam tham dự World Cup ở cấp độ U20 🌏🇻🇳\n✅ Giành danh hiệu đầu tiên cùng U23 Việt Nam tại giải U23 Đông Nam Á 2023 🏆\n\nMột người thầy đúng nghĩa với sự tận tụy cống hiến cho sự nghiệp ươm mầm những tương lai của bóng đá nước nhà. Cảm ơn ông, HLV Hoàng Anh Tuấn ❤️\n\n📸 VFF\n\n#goalvietnam #hot #HoangAnhTuan #U23Vietnam',
        image: ['assets/images/post/2.jpg'],
        like: 163,
        love: 24,
        comment: 5,
        type: 'memory',
      ),
    ],
    city: "hn",
    country: "hn",
    link: "",
    userId: "375",
  );
  User get user => _user;

  void updateUserData({
    required String name,
    String? avatar,
    String? cover_image,
    String? city,
    String? country,
    String? description,
    String? address,
    String? link,
  }) {
    _user = _user.copyWith(
      name: name,
      avatar: avatar,
      hometown: city,
      address: address,
      country: country,
      cover: cover_image,
      bio: description,
      link: link,
    );

    notifyListeners();
  }
}
