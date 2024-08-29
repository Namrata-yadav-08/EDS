import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String first;
  String school;
  String? phone;
  String? email;
  String photo;
  double? x;
  double? y;
  String? fcmToken; // Added FCM token field

  UserModel({
    required this.first,
    required this.school,
    required this.phone,
    required this.email,
    required this.id,
    required this.photo,
    required this.x,
    required this.y,
    this.fcmToken, // Added to constructor
  });

  Map<String, dynamic> toJson() {
    return {
      "First": first,
      "School": school,
      "Phone": phone,
      "Email": email,
      "Photo": photo,
      "x": x,
      "y": y,
      "fcmToken": fcmToken, // Added to JSON conversion
    };
  }

  Map<String, dynamic> toJson2(String field, String value) {
    return {
      field: value,
    };
  }

  Map<String, dynamic> toJsonimage(String value) {
    return {
      "Photo": value,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
      id: document.id,
      first: data['First'] ?? '',
      school: data['School'] ?? '',
      phone: data['Phone'] ?? '',
      email: data['Email'] ?? '',
      photo: data['Photo'] ?? '',
      x: data['x']?.toDouble(),
      y: data['y']?.toDouble(),
      fcmToken: data['fcmToken'], 
    );
  }
}
