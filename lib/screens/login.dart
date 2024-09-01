import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/screens/class_screen.dart';
import 'package:zoom/screens/joinmeet.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/utils/helper_functions.dart';
import 'package:zoom/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  UserModel user;
   LoginScreen({
    required this.user,
    Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Start or join a meeting',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 38.0),
        child: Image.asset('assets/v.JPG'),
      ),
      CustomButton(
          text: 'Create a meet',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JoinMeetingScreen()));
          }),
      SizedBox(
        height: THelperFunctions.screenHeight() * 0.02,
      ),
      CustomButton(
          text: 'Join a meet',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JoinMeetingScreen()));
          }),
      SizedBox(
        height: THelperFunctions.screenHeight() * 0.02,
      ),
      CustomButton(
          text: 'शिक्षा सामग्री',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ClassSelection(user1: widget.user,)));
          })
    ]));
  }
}
