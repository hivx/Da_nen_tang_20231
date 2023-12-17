import 'dart:convert';

import 'package:anti_facebook_app/Request/request_api.dart';
import 'package:anti_facebook_app/Signup/signup_password.dart';
import 'package:flutter/material.dart';


class SignUpEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpEmailWidget();
  }
}

class SignUpEmailWidget extends State<SignUpEmail> {
  final TextEditingController _controller = TextEditingController();
  String error = '';

  bool isValidEmail(String email) {
    // Biểu thức chính quy để kiểm tra định dạng email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Kiểm tra tính hợp lệ của email
    return emailRegex.hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa chỉ email'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Nhập địa chỉ email của bạn",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      style:
                          const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      decoration: const InputDecoration(
                          labelText: 'Địa chỉ email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, // Độ đậm
                            fontSize: 20.0, // Kích thước chữ
                          ),
                          border: OutlineInputBorder()),
                    ),
                    if (error.isNotEmpty)
                      Text(error, style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18
                      ),),
                    const SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            String email = _controller.text;
                            if (!isValidEmail(email)) {
                              setState(() {
                                error = 'Email không hợp lệ!';
                              });
                            } else {
                              Map<String, dynamic> data = {
                                'email': email
                              };
                              RequestAPI.postRequest('https://it4788.catan.io.vn/check_email', 200, data, '').then((response) {
                                if (response != null) {
                                  Map<String, dynamic> responseJs = json.decode(response);
                                  print(responseJs);
                                  if (responseJs['code'] == '1000') {
                                    if (responseJs['data']['existed'] == '1') {
                                      setState(() {
                                        error = 'Email đã đăng ký!';
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPassword(
                                              email: email
                                          ),
                                        ),
                                      );
                                    }
                                  } else if (responseJs['code'] == '1003') {
                                    setState(() {
                                      error = 'Email không hợp lệ!';
                                    });
                                  }
                                } else {
                                  setState(() {
                                    error = 'Kiểm tra lại kết nối Internet';
                                  });
                                }
                              });
                            }
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