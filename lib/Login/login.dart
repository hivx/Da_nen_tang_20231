import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../Signup/signup.dart';
import '../UserData/user_data.dart';
import 'find_account.dart';
import 'login_another_account.dart';
import 'login_with_an_existing_account.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginWidget();
  }
}

class LoginWidget extends State<Login> {
  String username = '';
  String email = '';
  String avatar = 'assets/images/default_avatar.png';

  void initState() {
    super.initState();
    avatar = 'assets/images/default_avatar.png';
    UserData.getStringData('username').then((response) {
      if (response.isNotEmpty) {
        UserData.getStringData('email').then((resultEmail) {
          UserData.getStringData('avatar').then((resultAvatar) {
            setState(() {
              username = response;
              email = resultEmail;
              // avatar = resultAvatar.isEmpty ? 'assets/images/default_avatar.png' : resultAvatar;
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserData.getStringData('token').then((result) {
    //   if (result != null && result.isNotEmpty) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomeScreen(),
    //       ),
    //     );
    //   }
    // });
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/icon_facebook_login.png',
                width: 60,
              ),
              const SizedBox(height: 100),
              if (username.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromRGBO(240, 242, 245, 1),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginAccount(email: email, username: username),
                        ),
                      );
                      // Navigator.of(context).push(_customPageRoute(LoginAccount()));
                    },
                    child: Row(
                      children: [
                        const ClipOval(
                          child: Image(
                            image:
                            AssetImage('assets/images/default_avatar.png'),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Expanded(
                          flex: 1,
                          child: Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: PopupMenuButton<String>(
                            onSelected: (String choice) {
                              // Xử lý khi một mục trong pop-up menu được chọn
                              print('You selected: $choice');
                              if (choice == 'item1') {
                                // UserData.setIntData(index, value)
                                UserData.removeValue('userId');
                                UserData.removeValue('username');
                                UserData.removeValue('email');
                                UserData.removeValue('avatar');
                                UserData.removeValue('token');
                                setState(() {
                                  username = '';
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'item1',
                                  child: Text(
                                    'Gỡ tài khoản khỏi thiết bị',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'item2',
                                  child: Text('Tắt thông báo đẩy',
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ];
                            },
                            offset: const Offset(15, 70),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginAnotherAccount(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 2, color: Color.fromRGBO(24, 119, 242, 1)),
                    ),
                    child: const Text(
                      'Đăng nhập bằng tài khoản khác',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(24, 119, 242, 1)),
                    )),
              ),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindAccount(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 2, color: Color.fromRGBO(24, 119, 242, 1)),
                    ),
                    child: const Text(
                      'Tìm tài khoản',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(24, 119, 242, 1)),
                    )),
              ),
              const SizedBox(height: 120),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
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
        ),
      ),
    );
  }
}
