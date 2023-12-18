import 'dart:convert';

import 'package:flutter/material.dart';

import '../Modal/wait_modal.dart';
import '../Request/request_api.dart';
import '../UserData/user_data.dart';
import '../UserData/user_info.dart';
import '../Verify/verify_account.dart';
import '../features/home/screens/home_screen.dart';

class LoginAccount extends StatefulWidget {
  final String email;
  final String username;

  LoginAccount({required this.email, required this.username});

  @override
  State<StatefulWidget> createState() =>
      WidgetLoginAccount(email: email, username: username);
}

class WidgetLoginAccount extends State<LoginAccount> {
  bool _passwordVisible = false;
  final String email;
  final String username;
  String error = '';

  WidgetLoginAccount({required this.email, required this.username});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30),
          child: Stack(children: [
            Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          'assets/images/default_avatar.png',
                          fit: BoxFit.cover,
                        ))),
                const SizedBox(height: 20),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  obscureText: !_passwordVisible,
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _controller,
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
                        Map<String, dynamic> data = {
                          'email': email,
                          'password': _controller.text,
                          'uuid': 'cuongdv'
                        };
                        if (_controller.text.length < 6) {
                          setState(() {
                            error = 'Mật khẩu có độ dài tối thiểu là 6 ký tự!';
                          });
                        } else {
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
                                UserData.setStringData('token',
                                    responseDataLoginJs['data']['token']);
                                UserInfo.userId =
                                responseDataLoginJs['data']['id'];
                                UserInfo.userName =
                                responseDataLoginJs['data']['username'];
                                UserInfo.email = email;
                                UserInfo.token =
                                responseDataLoginJs['data']['token'];
                                UserInfo.avatar =
                                responseDataLoginJs['data']['avatar'].isEmpty
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
                                        builder: (context) => VerifyAccount()),
                                  );
                                }
                              }
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
                // const SizedBox(height: 20),
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
              ],
            ),
            Positioned(
              top: 20,
              left: -15,
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
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
    );
  }
}
