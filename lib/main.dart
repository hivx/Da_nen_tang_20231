import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:anti_facebook_app/providers/user_provider.dart';
import 'package:anti_facebook_app/router.dart';
import 'package:anti_facebook_app/screens/email_signup_screen.dart';
import 'package:anti_facebook_app/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      // home: const HomeScreen(),
      home: PostListScreen(),
    );
  }
}
