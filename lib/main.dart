import 'package:flutter/material.dart';
import 'login.dart';

import 'login_another_account.dart';

void main() {
  // runApp(const MyApp());

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Segoe UI',
    ),
    home: SafeArea(
      child: Login()
    ),
    debugShowCheckedModeBanner: false,
  ));
}

