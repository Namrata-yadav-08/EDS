import 'package:flutter/material.dart';
import 'package:zoom/utils/helper_functions.dart';

class TeacherRegister extends StatefulWidget {
  const TeacherRegister({super.key});

  @override
  State<TeacherRegister> createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {
  final List<String> _dropdownItems = [
    'Hindi/हिंदी',
    'English',
    'Malayalam/മലയാളം'
  ];
  String? _selectedTopValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "पंजीकरण करें",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(192, 119, 33, 1.0),
                  ),
                ),
              ),
              SizedBox(height: THelperFunctions.screenHeight() * 0.02),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "शिक्षक का नाम",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(187, 187, 187, 1.0),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: THelperFunctions.screenHeight() * 0.02),
                    Text(
                      "शिक्षक का विषय",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(187, 187, 187, 1.0),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: THelperFunctions.screenHeight() * 0.02),
                    Text(
                      "कक्षा(1-5)",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(187, 187, 187, 1.0),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: THelperFunctions.screenHeight() * 0.02),
                    Text(
                      "शिक्षक का फ़ोन नंबर",
                      style: TextStyle(
                        fontSize: THelperFunctions.screenHeight() * 0.022,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(187, 187, 187, 1.0),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: THelperFunctions.screenHeight() * 0.04),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Implement your signup logic here
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            "पंजीकरण करें",
                            style: TextStyle(
                                fontSize: THelperFunctions.screenHeight() * 0.025,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: THelperFunctions.screenHeight() * 0.04),
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
