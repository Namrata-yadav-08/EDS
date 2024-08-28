import 'package:flutter/material.dart';
import 'package:zoom/screens/home.dart';
import 'package:zoom/screens/signup.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));  // Replace with your main screen widget
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation!,
        child: Center(
          child: Image.asset('assets/splash_screen.png'),  // Replace with your image asset
        ),
      ),
    );
  }
}
