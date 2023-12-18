import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Login/login.dart';

import 'package:http/http.dart' as http;

import '../Modal/wait_modal.dart';
import '../Request/request_api.dart';
import '../UserData/user_data.dart';
import '../UserData/user_info.dart';
import '../features/home/screens/home_screen.dart';

class ChangeAvatar extends StatefulWidget {
  final String userName;
  ChangeAvatar({required this.userName});
  @override
  State<StatefulWidget> createState() {
    return ChangeAvatarWidget(userName: userName);
  }
}

class ChangeAvatarWidget extends State<ChangeAvatar> {
  final TextEditingController _controller = TextEditingController();

  final String userName;
  ChangeAvatarWidget({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ảnh đại diện'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
                      "Cập nhật ảnh đại diện",
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
                          labelText: 'Ảnh đại diện',
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
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> data = {
                              'username': userName
                            };
                            WaitModal.showLoadingModal(context);
                            UserData.setStringData('username', userName);
                            UserInfo.userName = userName;
                            UserInfo.avatar = 'assets/images/default_avatar.png';
                            UserData.getStringData('token').then((token) {
                              RequestAPI.postRequest('https://it4788.catan.io.vn/change_profile_after_signup', 200, data, token).then((responseData) {
                                if (responseData != null) {
                                  print(responseData);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen()
                                    ),
                                  );
                                }
                              });
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(229, 230, 235, 1)), // Đặt màu nền
                          ),
                          child: const Text(
                            'Bỏ qua',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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