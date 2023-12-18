import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Modal/wait_modal.dart';
import '../Request/request_api.dart';
import '../UserData/user_data.dart';
import '../UserData/user_info.dart';
import '../Verify/verify_account.dart';
import '../WebViewPage/web_view_page.dart';

class SignUpComplete extends StatefulWidget {
  final String email;
  final String password;
  SignUpComplete({required this.email, required this.password});
  @override
  State<StatefulWidget> createState() {
    return SignUpCompleteWidget(
      email: email,
      password: password,
    );
  }
}

class SignUpCompleteWidget extends State<SignUpComplete> {
  final String email;
  final String password;
  SignUpCompleteWidget({required this.email, required this.password});
  bool isResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản & Quyền riêng tư'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Hoàn tất đăng ký",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Những người dùng dịch vụ của chúng tôi có thể đã tải thông tin liên hệ của bạn lên Facebook. ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),
                        children: [
                          TextSpan(
                            text: 'Tìm hiểu thêm.',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const WebViewPage(
                                        url: 'https://vi-vn.facebook.com/help/637205020878504'
                                    ),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Bằng cách nhấp vào Đăng ký, bạn đồng ý với ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),
                        children: [
                          TextSpan(
                            text: 'Điều khoản',
                            style: const TextStyle(
                              color: Color.fromRGBO(24, 119, 242, 1),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const WebViewPage(
                                        url: 'https://vi-vn.facebook.com/legal/terms/update'
                                    ),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(text: ', ',),
                          TextSpan(
                            text: 'Chính sách quyền riêng tư',
                            style: const TextStyle(
                              color: Color.fromRGBO(24, 119, 242, 1),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const WebViewPage(
                                        url: 'https://vi-vn.facebook.com/privacy/policy/?entry_point=data_policy_redirect&entry=0'
                                    ),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(text: ' và ',),
                          TextSpan(
                            text: 'Chính sách cookie',
                            style: const TextStyle(
                              color: Color.fromRGBO(24, 119, 242, 1),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const WebViewPage(
                                        url: 'https://vi-vn.facebook.com/privacy/policies/cookies/?entry_point=cookie_policy_redirect&entry=0'
                                    ),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(text: ' của Facebook.',),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            // print('Email: $email\n');
                            // print('Password: $password\n');
                            Map<String, dynamic> data = {
                              'email': email,
                              'password': password,
                              'uuid': 'cuongdv'
                            };
                            WaitModal.showLoadingModal(context);
                            RequestAPI.postRequest('https://it4788.catan.io.vn/signup', 201, data, '').then((responseData) {
                              if (responseData != null) {
                                print(responseData);
                                Map<String, dynamic> responseDataJs = json.decode(responseData);
                                print(responseDataJs['code']);
                                if (responseDataJs['code'] == '1000') {
                                  RequestAPI.postRequest('https://it4788.catan.io.vn/login', 200, data, '').then((responseDataLogin) {
                                    if (responseDataLogin != null) {
                                      Map<String, dynamic> responseDataLoginJs = json.decode(responseDataLogin);
                                      UserData.setStringData('userId', responseDataLoginJs['data']['id']);
                                      UserData.setStringData('username', responseDataLoginJs['data']['username']);
                                      UserData.setStringData('email', email);
                                      UserData.setStringData('token', responseDataLoginJs['data']['token']);
                                      UserData.setStringData('avatar', responseDataLoginJs['data']['avatar']);
                                      UserInfo.userId = responseDataLoginJs['data']['id'];
                                      UserInfo.userName = responseDataLoginJs['data']['username'];
                                      UserInfo.email = email;
                                      UserInfo.token = responseDataLoginJs['data']['token'];
                                      UserInfo.avatar = responseDataLoginJs['data']['avatar'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VerifyAccount()
                                        ),
                                      );
                                    }
                                  });
                                }
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(
                                    24, 119, 242, 1)), // Đặt màu nền
                          ),
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          )
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

