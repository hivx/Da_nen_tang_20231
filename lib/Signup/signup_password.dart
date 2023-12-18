import 'package:anti_facebook_app/Signup/signup_complete.dart';
import 'package:flutter/material.dart';

class SignUpPassword extends StatefulWidget {
  final String email;
  SignUpPassword({required this.email});
  @override
  State<StatefulWidget> createState() {
    return SignUpPasswordWidget(email: email);
  }
}

class SignUpPasswordWidget extends State<SignUpPassword> {
  final TextEditingController _controller = TextEditingController();
  bool _passwordVisible = false;
  final String email;
  SignUpPasswordWidget({required this.email});
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mật khẩu'),
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
                "Tạo mật khẩu",
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
                      Text(error, style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18
                      ),),
                    const SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            String password = _controller.text;
                            if (password.length < 6) {
                              setState(() {
                                error = 'Mật khẩu có độ dài tối thiểu là 6 ký tự!';
                              });
                            } else {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpComplete(
                                    email: email,
                                    password: password,
                                  ),
                                ),
                              );
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

