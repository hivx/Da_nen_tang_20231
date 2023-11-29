import 'package:flutter/material.dart';
import 'package:anti_facebook_app/widgets/button_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa chỉ email'),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            // size: 48.0,
          ), // Sử dụng biểu tượng mũi tên quay lại
          onPressed: () {
            // Xử lý khi nút "Back" được nhấn
            Navigator.of(context)
                .pop(); // Đóng màn hình đăng ký và quay lại màn hình trước đó
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey, // Màu của border bottom
            width: 1.0, // Độ dày của border bottom
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: const Text(
                'Nhập địa chỉ email của bạn',
                style: TextStyle(
                  color: Color.fromARGB(255, 39, 41, 47),
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Text(
              'Hiện đã có tài khoản liên kết với địa chỉ email này.',
              style: TextStyle(color: Colors.red),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 80.0),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Địa chỉ email',
                  suffixIconColor: Colors.red,
                  labelStyle:
                      TextStyle(color: Colors.black87), // Đặt màu của label
                ),
              ),
            ),
            MyButton(
              label: 'Tiếp',
              onPressed: () {
                // Xử lý đăng ký tại đây
              },
            ),
          ],
        ),
      ),
    );
  }
}
