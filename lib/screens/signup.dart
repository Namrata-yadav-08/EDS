import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoom/screens/signupcontroller.dart';
import 'package:zoom/utils/helper_functions.dart';
import 'package:zoom/utils/userrepo.dart';
import 'package:zoom/utils/validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      SignupController.x = position.latitude;
      SignupController.ycoordinate = position.longitude;
    });
  }

  // Variables to hold selected dropdown values
  String? _selectedTopValue;

  // Sample dropdown menu items
  final List<String> _dropdownItems = ['Hindi/हिंदी', 'English', 'Malayalam/മലയാളം'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Center(
                child: IntrinsicWidth(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Select Language",
                      border: InputBorder.none,
                    ),
                    value: _selectedTopValue,
                    items: _dropdownItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTopValue = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Center(
                child: Text(
                  "साइन अप करें ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(192, 119, 33, 1.0),
                  ),
                ),
              ),
              SizedBox(height: THelperFunctions.screenHeight() * 0.01),
              Form(
                key: SignupController.signup,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "अधिकारी का नाम",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(187, 187, 187, 1.0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.validateText("Lastname", value),
                        controller: SignupController.Schoolname,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: THelperFunctions.screenHeight() * 0.022,
                    ),
                    Text(
                      "प्राधिकरण का प्रकार",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(187, 187, 187, 1.0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.validateText("Firstname", value),
                        controller: SignupController.firstname,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: THelperFunctions.screenHeight() * 0.022,
                    ),
                    Text(
                      "कार्यालय का ई-मेल",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(187, 187, 187, 1.0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: SignupController.email,
                        validator: (value) => Validator.validateEmail(value),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: THelperFunctions.screenHeight() * 0.022,
                    ),
                    Text(
                      "पासवर्ड",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(187, 187, 187, 1.0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: SignupController.password,
                        obscureText: true,
                        obscuringCharacter: "*",
                        validator: (value) => Validator.validatepassword(value),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: THelperFunctions.screenHeight() * 0.022,
                    ),
                    Text(
                      "कार्यालय का फ़ोन नंबर",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(187, 187, 187, 1.0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: SignupController.phonenumber,
                        validator: (value) => Validator.phonenumber(value),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: THelperFunctions.screenHeight() * 0.022,
                    ),
                    InkWell(
                      onTap: () async {
                        await _getCurrentLocation();
                        if (SignupController.signup.currentState!.validate()) {
                          SignupController.signUpcall(
                            SignupController.email.text,
                            SignupController.password.text,
                            context,
                          );
                          // Check if user1 is not null before using it
                          if (SignupController.user1 != null) {
                            UserRepository.createUser(
                                SignupController.user1!, context);
                          } else {
                            // Handle case when user1 is null
                            print("Error: User data is not available.");
                          }
                        }
                      },
                      child: Container(
                        height: THelperFunctions.screenHeight() * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(192, 119, 33, 1.0),
                          border: Border.all(
                            color: Color.fromRGBO(187, 187, 187, 1.0),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "साइन अप करें",
                            style: TextStyle(
                              fontSize: THelperFunctions.screenHeight() * 0.02,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
