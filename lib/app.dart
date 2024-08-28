import 'package:flutter/material.dart';
import 'package:zoom/screens/login.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/screens/bottomnav.dart';
import 'package:zoom/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;

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
