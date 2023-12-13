// import 'package:flutter/material.dart';

// import 'login.dart';

// class LoginAnotherAccount extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => WidgetLoginAnotherAccount();
// }

// class WidgetLoginAnotherAccount extends State<LoginAnotherAccount> {

//   bool _passwordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height -
//                   MediaQuery.of(context).padding.top -
//                   MediaQuery.of(context).padding.bottom,
//               margin: const EdgeInsets.only(left: 15.0, right: 15.0),
//               child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         const SizedBox(height: 100),
//                         Image.asset(
//                           'assets/images/icon_facebook_login.png',
//                           width: 60,
//                         ),
//                         const SizedBox(height: 50),
//                         const TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Số di động hoặc email',
//                             border: OutlineInputBorder()
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextField(
//                           obscureText: !_passwordVisible,
//                           // keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             hintText: 'Mật khẩu',
//                             border: OutlineInputBorder(),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _passwordVisible = !_passwordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         FractionallySizedBox(
//                           widthFactor: 1.0,
//                           child: ElevatedButton(
//                               onPressed: null,
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(231, 243, 255, 1)), // Đặt màu nền
//                               ),
//                               child: const Text(
//                                 'Đăng nhập',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color.fromRGBO(24, 119, 242, 1)
//                                 ),
//                               )
//                           ),
//                         ),
//                         const FractionallySizedBox(
//                           widthFactor: 1.0,
//                           child: TextButton(
//                               onPressed: null,
//                               child: Text(
//                                 'Quên mật khẩu?',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color.fromRGBO(24, 119, 242, 1)
//                                 ),
//                               )
//                           ),
//                         ),
//                         const SizedBox(height: 200),
//                         FractionallySizedBox(
//                           widthFactor: 1.0,
//                           child: ElevatedButton(
//                               onPressed: null,
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(231, 243, 255, 1)), // Đặt màu nền
//                               ),
//                               child: const Text(
//                                 'Tạo tài khoản mới',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color.fromRGBO(24, 119, 242, 1)
//                                 ),
//                               )
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Image.asset(
//                           'assets/images/icon_meta.png',
//                           width: 80,
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       top: 20,
//                       left: -15,
//                       child: IconButton(
//                         onPressed: () {
//                           FocusScope.of(context).unfocus();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Login(),
//                             ),
//                           );
//                           // Navigator.of(context).push(_customPageRoute(Login()));
//                         },
//                         icon: const Icon(Icons.arrow_back, color: Colors.black,),
//                       ),
//                     )
//                   ]
//               ),
//             ),
//           ),
//       ),
//     );
//   }

// }
