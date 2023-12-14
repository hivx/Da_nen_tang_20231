import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditUserPage extends StatelessWidget {
  final String avatarImagePath;
  final String coverImagePath;
  final String description;
  final String work;
  final String home;
  final String place;
  final int follower;
  final String school;
  final String relationship;

  const EditUserPage({
    Key? key,
    required this.avatarImagePath,
    required this.coverImagePath,
    required this.description,
    required this.work,
    required this.home,
    required this.place,
    required this.follower,
    required this.school,
    required this.relationship,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa trang cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: ProfileContent(
          avatarImagePath: avatarImagePath,
          coverImagePath: coverImagePath,
          description: description,
          work : work,
          home: home,
          place: place,
          follower: follower,
          school: school,
          relationship: relationship,
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final String avatarImagePath;
  final String coverImagePath;
  final String description;
  final String work;
  final String home;
  final String place;
  final int follower;
  final String school;
  final String relationship;

  const ProfileContent({
    Key? key,
    required this.avatarImagePath,
    required this.coverImagePath,
    required this.description,
    required this.work,
    required this.home,
    required this.place,
    required this.follower,
    required this.school,
    required this.relationship,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ảnh đại diện',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                },
                child: Text(
                  'Chỉnh sửa',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(avatarImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ảnh bìa',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: 360,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(coverImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 10, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiểu sử',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: description,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiết',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.work, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                work,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.home, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                'Sống tại ' + home,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.place, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                'Đến từ ' + place,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.wifi, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                'Có ' + follower.toString() + ' người theo dõi',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.school, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                school,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.favorite, // This is the icon you want to use; you can change it to any other icon you prefer.
                size: 20,
                color: Colors.grey,// Adjust the size of the icon as needed
              ),
              SizedBox(width: 10), // Spacing between the icon and the text
              Text(
                relationship,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sở thích',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đáng chú ý',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/paint.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Hãy thêm một số tin, ảnh hoặc video yêu thich vào phần Đáng chú ý để mọi người hiểu hơn về bạn.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),

          SizedBox(height: 20),

          Center(
            child: ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nút được nhấn
              },
              child: Container(
                width: 300,
                height: 30,
                child: Center(
                  child: Text(
                    'Dùng thử',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Liên kết',
                  style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}