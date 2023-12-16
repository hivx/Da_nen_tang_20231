import 'package:flutter/material.dart';

class EditUserPageSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cài đặt trang cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Divider(
              color: Colors.grey[350],
              thickness: 10, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),
            // Container cho "Mục đã lưu" với icon bookmark
            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Mục đã lưu',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[400],
              thickness: 1.2, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),
            // Container cho "Chế độ xem"
            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.grid_view,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Chế độ xem',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[400],
              thickness: 1.4, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),
            // Container cho "Nhật ký hoạt động"
            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Nhật ký hoạt động',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[350],
              thickness: 1, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),

            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Quản lý bài viết',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[350],
              thickness: 1, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),

            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.timeline,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Xem lại dòng thời gian',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[400],
              thickness: 1.1, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),

            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Xem lối tắt quyền riêng tư',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[350],
              thickness: 1, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),

            ElevatedButton(
              onPressed: () {
                // Thêm logic của bạn
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Tìm kiếm trên trang cá nhân',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[350],
              thickness: 6, // Độ dày của đường gạch
              height: 5, // Chiều cao của đường gạch
              indent: 1, // Khoảng cách từ lề trái
              endIndent: 1, // Khoảng cách từ lề phải
            ),
          ],
        ),
      ),
    );
  }
}