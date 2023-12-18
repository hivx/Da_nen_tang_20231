import 'dart:convert';

import 'package:anti_facebook_app/Modal/wait_modal.dart';
import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../Request/request_api.dart';
import '../UserData/user_data.dart';
import '../UserData/user_info.dart';
import '../Verify/verify_account.dart';
import 'login.dart';

class LoginAnotherAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WidgetLoginAnotherAccount();
}

class WidgetLoginAnotherAccount extends State<LoginAnotherAccount> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _passwordVisible = false;
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Stack(children: [
              Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/images/icon_facebook_login.png',
                    width: 60,
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _controller1,
                    decoration: const InputDecoration(
                        hintText: 'Email', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller2,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  if (error.isNotEmpty)
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: ElevatedButton(
                        onPressed: () {
                          String email = _controller1.text;
                          String password = _controller2.text;
                          if (!isValidEmail(email)) {
                            setState(() {
                              error = 'Email không hợp lệ!';
                            });
                          } else if (password.length < 6) {
                            setState(() {
                              error =
                                  'Mật khẩu có độ dài tối thiểu là 6 ký tự!';
                            });
                          } else {
                            Map<String, dynamic> data = {
                              'email': email,
                              'password': password,
                              'uuid': 'cuongdv'
                            };
                            WaitModal.showLoadingModal(context);
                            RequestAPI.postRequest(
                                    'https://it4788.catan.io.vn/login',
                                    200,
                                    data,
                                    '')
                                .then((responseData) {
                              if (responseData != null) {
                                Map<String, dynamic> responseDataLoginJs =
                                    json.decode(responseData);
                                if (responseDataLoginJs['code'] == '1000') {
                                  UserData.setStringData('userId',
                                      responseDataLoginJs['data']['id']);
                                  UserData.setStringData('username',
                                      responseDataLoginJs['data']['username']);
                                  UserData.setStringData(
                                      'email', _controller1.text);
                                  UserData.setStringData('token',
                                      responseDataLoginJs['data']['token']);
                                  UserData.setStringData('avatar',
                                      responseDataLoginJs['data']['avatar']);
                                  UserInfo.userId =
                                      responseDataLoginJs['data']['id'];
                                  UserInfo.userName =
                                      responseDataLoginJs['data']['username'];
                                  UserInfo.email = _controller1.text;
                                  UserInfo.token =
                                      responseDataLoginJs['data']['token'];
                                  UserInfo.avatar = responseDataLoginJs['data']
                                              ['avatar']
                                          .isEmpty
                                      ? 'assets/images/default_avatar.png'
                                      : responseDataLoginJs['data']['avatar'];
                                  if (responseDataLoginJs['data']['active'] ==
                                      '1') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VerifyAccount()),
                                    );
                                  }
                                } else if (responseDataLoginJs['code'] ==
                                    '9991') {
                                  setState(() {
                                    error =
                                        'Email hoặc mật khẩu không chính xác!';
                                    print(error);
                                  });
                                  Navigator.of(context).pop();
                                }
                              } else {
                                setState(() {
                                  error = 'Kiểm tra kết nối của bạn!';

                                });
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(
                                  231, 243, 255, 1)), // Đặt màu nền
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(24, 119, 242, 1)),
                        )),
                  ),
                  const FractionallySizedBox(
                    widthFactor: 1.0,
                    child: TextButton(
                        onPressed: null,
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(24, 119, 242, 1)),
                        )),
                  ),
                  const SizedBox(height: 200),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(
                                  231, 243, 255, 1)), // Đặt màu nền
                        ),
                        child: const Text(
                          'Tạo tài khoản mới',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(24, 119, 242, 1)),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/icon_meta.png',
                    width: 80,
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: -15,
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                    // Navigator.of(context).push(_customPageRoute(Login()));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
