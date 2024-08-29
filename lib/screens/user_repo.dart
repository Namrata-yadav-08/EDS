import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/screens/home.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/utils/userrepo.dart';

class SignupController {
  static UserModel? user1;
  static final firstname = TextEditingController();
  static final Officename = TextEditingController();
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final phonenumber = TextEditingController();
  static double? x; // Latitude
  static double? ycoordinate; // Longitude
  static GlobalKey<FormState> signup = GlobalKey<FormState>();

  static Future<void> signUpcall(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create UserModel instance
      user1 = UserModel(
        first: firstname.text.trim(),
        school: Officename.text.trim(),
        phone: phonenumber.text.trim(),
        email: email,
        id: userCredential.user?.uid ?? '',
        photo: '',
        x: x,
        y: ycoordinate,
      );

      // Save user data to Firestore
      await UserRepository.createUser(user1!, context);

      // Navigate to NearbyUsersScreen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User created successfully!")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Authentication Error")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An unknown error occurred: $e")));
    }
  }

  static Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send email verification")));
    }
  }

}
