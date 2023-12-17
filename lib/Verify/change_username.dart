import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Login/login.dart';
import 'change_avatar_after_signup.dart';

class ChangeUserName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangeUserNameWidget();
  }
}

class ChangeUserNameWidget extends State<ChangeUserName> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tên người dùng'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    const Text(
                      "Cập nhật tên người dùng",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 60),
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      style:
                      const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      decoration: const InputDecoration(
                          labelText: 'Tên người dùng',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, // Độ đậm
                            fontSize: 20.0, // Kích thước chữ
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 30),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeAvatar(userName: _controller.text)
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(
                                    24, 119, 242, 1)), // Đặt màu nền
                          ),
                          child: const Text(
                            'Tiếp',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Quay lại trang đăng nhập',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(24, 119, 242, 1),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()
                              ),
                            );
                          },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}