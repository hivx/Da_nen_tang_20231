import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Login/login.dart';
import '../Modal/wait_modal.dart';
import '../Request/request_api.dart';
import '../UserData/user_data.dart';
import 'change_username.dart';

class VerifyAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyAccountWidget();
  }
}

class VerifyAccountWidget extends State<VerifyAccount> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác thực tài khoản'),
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
                      "Chúng tôi đã gửi mã xác nhận tới email của bạn.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nhập mã gồm 6 chữ số từ email của bạn.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      style:
                      const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      decoration: const InputDecoration(
                          labelText: 'Mã xác nhận',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, // Độ đậm
                            fontSize: 20.0, // Kích thước chữ
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            UserData.getStringData('email').then((email) {
                              Map<String, dynamic> data = {
                                'email': email,
                                'code_verify': _controller.text
                              };
                              print(data);
                              WaitModal.showLoadingModal(context);
                              RequestAPI.postRequest('https://it4788.catan.io.vn/check_verify_code', 200, data, '').then((responseData) {
                                if (responseData != null) {
                                  Map<String, dynamic> responseDataJs = json.decode(responseData);
                                  print(responseDataJs['code']);
                                  print(responseDataJs);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeUserName()
                                    ),
                                  );
                                }
                              });
                            });

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(
                                    24, 119, 242, 1)), // Đặt màu nền
                          ),
                          child: const Text(
                            'Xác nhận',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(229, 230, 235, 1)), // Đặt màu nền
                          ),
                          child: const Text(
                            'Gửi lại mã',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    ),
                    const SizedBox(height: 10),
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