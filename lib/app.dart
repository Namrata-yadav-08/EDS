import 'package:flutter/material.dart';
import 'package:zoom/screens/login.dart';
import 'package:zoom/utils/colors.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom clone',
      home: const LoginScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
    );
  }
}
