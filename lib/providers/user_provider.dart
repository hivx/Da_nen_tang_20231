import 'dart:convert';

import 'package:anti_facebook_app/Request/request_api.dart';
import 'package:anti_facebook_app/models/user.dart';
import 'package:flutter/material.dart';

import '../UserData/user_data.dart';
import '../models/post.dart';
import '../models/story.dart';

class UserProvider extends ChangeNotifier {
  late User _user = User(name: '', avatar: '');

  // 'assets/images/user/lcd.jpg'
  UserProvider() {
    // UserData.getStringData('token').then((token) {
    //   UserData.getStringData('userId').then((userId) {
    //     Map<String, dynamic> data = {"user_id": userId};
    //     RequestAPI.postRequest(
    //             'https://it4788.catan.io.vn/get_user_info', 200, data, token)
    //         .then((response) {
    //       if (response != null) {
    //         Map<String, dynamic> responseJs = json.decode(response);
    //         if (responseJs['code'] == '1000') {
    //           String avatar = responseJs['data']['avatar'].isEmpty
    //               ? 'assets/images/default_avatar.png'
    //               : responseJs['data']['avatar'];
    //           _user = User(
    //             name: responseJs['data']['username'],
    //             avatar: avatar,
    //             educations: [
    //               Education(
    //                 majors: 'Computer Science',
    //                 school: 'Đại học Bách Khoa Hà Nội',
    //               ),
    //             ],
    //             hometown: 'Hà Nội',
    //             followers: 4820,
    //             friends: 1150,
    //             hobbies: [
    //               '💻 Viết mã',
    //               '📚 Học tập',
    //               '⚽ Bóng đá',
    //               '🎮 Trò chơi điện tử',
    //               '🎧 Nghe nhạc',
    //               '📖 Đọc sách',
    //             ],
    //             socialMedias: [
    //               SocialMedia(
    //                 icon: 'assets/images/github.png',
    //                 name: 'Dat-TG',
    //                 link: 'https://github.com/Dat-TG',
    //               ),
    //               SocialMedia(
    //                   icon: 'assets/images/linkedin.png',
    //                   name: 'ddawst',
    //                   link: 'https://www.linkedin.com/in/ddawst/'),
    //             ],
    //             bio: responseJs['data']['description'],
    //             cover: responseJs['data']['cover_image'].isEmpty
    //                 ? 'assets/images/user/lcd-cover.jpg'
    //                 : responseJs['data']['cover_image'],
    //             guard: true,
    //             topFriends: [
    //               User(
    //                 name: 'Khánh Vy',
    //                 avatar: 'assets/images/user/khanhvy.jpg',
    //               ),
    //               User(
    //                 name: 'Leo Messi',
    //                 avatar: 'assets/images/user/messi.jpg',
    //               ),
    //               User(
    //                 name: 'Minh Hương',
    //                 avatar: 'assets/images/user/minhhuong.jpg',
    //               ),
    //               User(
    //                 name: 'Bảo Ngân',
    //                 avatar: 'assets/images/user/baongan.jpg',
    //               ),
    //               User(
    //                 name: 'Hà Linhh',
    //                 avatar: 'assets/images/user/halinh.jpg',
    //               ),
    //               User(
    //                 name: 'Minh Trí',
    //                 avatar: 'assets/images/user/minhtri.jpg',
    //               ),
    //             ],
    //             // posts: [
    //             //   Post(
    //             //     user: User(
    //             //       name: username,
    //             //       avatar: avatar,
    //             //     ),
    //             //     time: '3 phút',
    //             //     shareWith: 'public',
    //             //     content:
    //             //         '✅ 10 năm cống hiến cho bóng đá trẻ Việt Nam\n✅ Người đầu tiên đưa Việt Nam tham dự World Cup ở cấp độ U20 🌏🇻🇳\n✅ Giành danh hiệu đầu tiên cùng U23 Việt Nam tại giải U23 Đông Nam Á 2023 🏆\n\nMột người thầy đúng nghĩa với sự tận tụy cống hiến cho sự nghiệp ươm mầm những tương lai của bóng đá nước nhà. Cảm ơn ông, HLV Hoàng Anh Tuấn ❤️\n\n📸 VFF\n\n#goalvietnam #hot #HoangAnhTuan #U23Vietnam',
    //             //     image: ['assets/images/post/2.jpg'],
    //             //     like: 163,
    //             //     love: 24,
    //             //     comment: 5,
    //             //     type: 'memory',
    //             //   ),
    //             //   Post(
    //             //     user: User(
    //             //       name: username,
    //             //       avatar: avatar,
    //             //     ),
    //             //     time: '3 phút',
    //             //     shareWith: 'public',
    //             //     content:
    //             //         'Do you like Phở?\nBecause I can be your Pho-ever ✨✨',
    //             //     image: [
    //             //       'assets/images/post/3.jpg',
    //             //       'assets/images/post/5.jpg',
    //             //       'assets/images/post/12.jpg',
    //             //       'assets/images/post/13.jpg',
    //             //       'assets/images/post/14.jpg',
    //             //       'assets/images/post/15.jpg',
    //             //       'assets/images/post/16.jpg',
    //             //     ],
    //             //     like: 15000,
    //             //     love: 7300,
    //             //     comment: 258,
    //             //     haha: 235,
    //             //     share: 825,
    //             //     lovelove: 212,
    //             //     wow: 9,
    //             //     layout: 'classic',
    //             //     type: 'memory',
    //             //   ),
    //             //   Post(
    //             //     user: User(
    //             //       name: username,
    //             //       avatar: avatar,
    //             //     ),
    //             //     time: '3 phút',
    //             //     shareWith: 'public',
    //             //     content:
    //             //         'Những câu thả thính Tiếng Anh mượt mà - The smoothest pick up lines \n\n1. You wanna know who my crush is? - Cậu muốn biết crush của tớ là ai hơm?\nSimple. Just read the first word :> - Đơn giản. Cứ đọc lại từ đầu tiên\n\n2. Hey, i think my phone is broken - Tớ nghĩ điện thoại tớ bị hỏng rùi \nIt doesn’t have your phone number in it. - Vì nó không có sđt của cậu trong nàyyy \nCan you fix it? 😉 - Cậu sửa được không ha?\n\n3. According to my calculations, the more you smile, the more i fall - Theo tính toán của tớ, cậu càng cười, tớ càng đổ \n\n4. I can’t turn water into wine - Tớ không thể biến nước thành rịu\nBut i can turn you into mine - Nhưng tớ có thể biến cậu thành “của tớ” \n\n5. Can i take a picture of you? - Cho tớ chụp 1 bức hình với cậu được hem\nAh, to tell Santa what i want for Christmas this year - À để nói với ông già Noel tớ muốn quà gì dịp giáng sinh năm nay \n\nÁp dụng cho bạn thân, crush, ngừi iu hay cho zui cũng được lun 🥰',
    //             //     image: [
    //             //       'assets/images/post/3.jpg',
    //             //       'assets/images/post/4.jpg',
    //             //       'assets/images/post/5.jpg'
    //             //     ],
    //             //     like: 15000,
    //             //     love: 7300,
    //             //     comment: 258,
    //             //     haha: 235,
    //             //     share: 825,
    //             //     lovelove: 212,
    //             //     wow: 9,
    //             //     layout: 'column',
    //             //     type: 'memory',
    //             //   ),
    //             // ],
    //           );
    //           notifyListeners();
    //         }
    //       }
    //     });
    //   });
    // });
    UserData.getStringData('username').then((username) {
      UserData.getStringData('avatar').then((avatar) {
        avatar = avatar.isEmpty ? 'assets/images/default_avatar.png' : avatar;
        _user = User(
          name: username,
          avatar: avatar,
          educations: [
            Education(
              majors: 'Computer Science',
              school: 'Đại học Bách Khoa Hà Nội',
            ),
          ],
          hometown: 'Hà Nội',
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
          bio: 'Hello World!',
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
          // posts: [
          //   Post(
          //     user: User(
          //       name: username,
          //       avatar: avatar,
          //     ),
          //     time: '3 phút',
          //     shareWith: 'public',
          //     content:
          //         '✅ 10 năm cống hiến cho bóng đá trẻ Việt Nam\n✅ Người đầu tiên đưa Việt Nam tham dự World Cup ở cấp độ U20 🌏🇻🇳\n✅ Giành danh hiệu đầu tiên cùng U23 Việt Nam tại giải U23 Đông Nam Á 2023 🏆\n\nMột người thầy đúng nghĩa với sự tận tụy cống hiến cho sự nghiệp ươm mầm những tương lai của bóng đá nước nhà. Cảm ơn ông, HLV Hoàng Anh Tuấn ❤️\n\n📸 VFF\n\n#goalvietnam #hot #HoangAnhTuan #U23Vietnam',
          //     image: ['assets/images/post/2.jpg'],
          //     like: 163,
          //     love: 24,
          //     comment: 5,
          //     type: 'memory',
          //   ),
          //   Post(
          //     user: User(
          //       name: username,
          //       avatar: avatar,
          //     ),
          //     time: '3 phút',
          //     shareWith: 'public',
          //     content:
          //         'Do you like Phở?\nBecause I can be your Pho-ever ✨✨',
          //     image: [
          //       'assets/images/post/3.jpg',
          //       'assets/images/post/5.jpg',
          //       'assets/images/post/12.jpg',
          //       'assets/images/post/13.jpg',
          //       'assets/images/post/14.jpg',
          //       'assets/images/post/15.jpg',
          //       'assets/images/post/16.jpg',
          //     ],
          //     like: 15000,
          //     love: 7300,
          //     comment: 258,
          //     haha: 235,
          //     share: 825,
          //     lovelove: 212,
          //     wow: 9,
          //     layout: 'classic',
          //     type: 'memory',
          //   ),
          //   Post(
          //     user: User(
          //       name: username,
          //       avatar: avatar,
          //     ),
          //     time: '3 phút',
          //     shareWith: 'public',
          //     content:
          //         'Những câu thả thính Tiếng Anh mượt mà - The smoothest pick up lines \n\n1. You wanna know who my crush is? - Cậu muốn biết crush của tớ là ai hơm?\nSimple. Just read the first word :> - Đơn giản. Cứ đọc lại từ đầu tiên\n\n2. Hey, i think my phone is broken - Tớ nghĩ điện thoại tớ bị hỏng rùi \nIt doesn’t have your phone number in it. - Vì nó không có sđt của cậu trong nàyyy \nCan you fix it? 😉 - Cậu sửa được không ha?\n\n3. According to my calculations, the more you smile, the more i fall - Theo tính toán của tớ, cậu càng cười, tớ càng đổ \n\n4. I can’t turn water into wine - Tớ không thể biến nước thành rịu\nBut i can turn you into mine - Nhưng tớ có thể biến cậu thành “của tớ” \n\n5. Can i take a picture of you? - Cho tớ chụp 1 bức hình với cậu được hem\nAh, to tell Santa what i want for Christmas this year - À để nói với ông già Noel tớ muốn quà gì dịp giáng sinh năm nay \n\nÁp dụng cho bạn thân, crush, ngừi iu hay cho zui cũng được lun 🥰',
          //     image: [
          //       'assets/images/post/3.jpg',
          //       'assets/images/post/4.jpg',
          //       'assets/images/post/5.jpg'
          //     ],
          //     like: 15000,
          //     love: 7300,
          //     comment: 258,
          //     haha: 235,
          //     share: 825,
          //     lovelove: 212,
          //     wow: 9,
          //     layout: 'column',
          //     type: 'memory',
          //   ),
          // ],
        );

      });
    });
  }

  User get user => _user;
}
