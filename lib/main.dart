import 'package:fb_project/home.dart';
import 'package:flutter/material.dart';
import 'dangbai.dart';
import 'login.dart';

import 'login_another_account.dart';

void main() {
  runApp(const MyApp());

  // runApp(MaterialApp(
  //   theme: ThemeData(
  //     fontFamily: 'Segoe UI',
  //   ),
  //   home: SafeArea(
  //     child: Login()
  //   ),
  //   debugShowCheckedModeBanner: false,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => Home();
}

