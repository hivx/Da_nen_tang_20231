import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:anti_facebook_app/providers/user_provider.dart';
import 'package:anti_facebook_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login/login.dart';
import 'constants/global_variables.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.backgroundColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: GlobalVariables.iconColor),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Login(),
      // home: PostListScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import 'Login/login.dart';
// import 'features/home/screens/home_screen.dart';
//
// void main() {
//   // runApp(const MyApp());
//
//   runApp(MultiProvider(
//     providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
//     child: const MyApp(),
//   ));
//   runApp(MaterialApp(
//     theme: ThemeData(
//       fontFamily: 'Segoe UI',
//     ),
//     home: SafeArea(
//         child: Login()
//     ),
//     debugShowCheckedModeBanner: false,
//   ));
// }