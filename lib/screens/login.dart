import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/screens/home.dart';
import 'package:zoom/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start or join a meeting',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset('assets/onboarding.jpg'),
          ),
          CustomButton(
  text: "Google Sign In",
  onPressed: () 
  //async
   {
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    //bool res = await _authMethods.signInWithGoogle(context);
    // if (res) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()),
    //   );
    // } else {
    //   // Optionally show an error message if sign-in failed
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Google Sign-In failed')),
    //   );
    // }
  },
),

        ],
      ),
    );
  }
}
