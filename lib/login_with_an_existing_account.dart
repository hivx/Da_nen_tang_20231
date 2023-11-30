import 'package:flutter/material.dart';
import 'login.dart';

PageRouteBuilder _customPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class LoginAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WidgetLoginAccount();
}

class WidgetLoginAccount extends State<LoginAccount> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30),
          child: Stack(
            children: [
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
                          )
                      )
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Đỗ Việt Cường',
                    style: TextStyle(
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
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(231, 243, 255, 1)), // Đặt màu nền
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(24, 119, 242, 1)
                          ),
                        )
                    ),
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
                              color: Color.fromRGBO(24, 119, 242, 1)
                          ),
                        )
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: -15,
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Login(),
                    //   ),
                    // );
                    Navigator.of(context).push(_customPageRoute(Login()));
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black,),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

}