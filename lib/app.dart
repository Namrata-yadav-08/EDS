import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/screens/home.dart';
import 'package:zoom/screens/login.dart';
import 'package:zoom/utils/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoom clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: LoginScreen()
        //StreamBuilder(
        //   stream: AuthMethods().authChanges,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       return const HomeScreen();
        //     }

        //     return const LoginScreen();
        //   },
        // )
        );
  }
}
