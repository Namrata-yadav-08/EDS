import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController {
  static final GlobalKey<FormState> signup = GlobalKey<FormState>();

  static final TextEditingController collegename = TextEditingController();
  static final TextEditingController firstname = TextEditingController();
  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();
  static final TextEditingController phonenumber = TextEditingController();

  static double x = 0.0; 
  static double ycoordinate = 0.0; 

  static User? user1;

  static Future<void> signUpCall(
      String email, String password, BuildContext context) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      user1 = userCredential.user;

      // Save additional user details in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(user1?.uid).set({
        'schoolName': collegename.text.trim(),
        'principalName': firstname.text.trim(),
        'email': email.trim(),
        'phoneNumber': phonenumber.text.trim(),
        'latitude': x,
        'longitude': ycoordinate,
      });

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Handle errors, e.g., show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: ${e.toString()}')),
      );
    }
  }
}
