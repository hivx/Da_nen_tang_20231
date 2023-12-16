import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5), // Khoảng trống để dịch lên
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.push_pin,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Ghim bài viết',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Lưu bài viết',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Xem lịch sử chỉnh sửa',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Chỉnh sửa bài viết',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Chỉnh sửa quyền riêng tư',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Chuyển vào thùng rác',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_off,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Tắt thông báo về bài viết',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Sao chép liên kết',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}