import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/screens/attendence.dart';
import 'package:zoom/screens/teacher_register.dart';
import 'package:zoom/utils/helper_functions.dart';

class TeacherAttendance extends StatelessWidget {
  const TeacherAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Map<String, String>> teachers = [
      {
        "name": "Anil Sharma",
        "subject": "Maths",
        "phone": "8829345678",
        "image": "assets/T.jpeg"
      },
      {
        "name": "Sita Gupta",
        "subject": "English",
        "phone": "9928374650",
        "image": "assets/T.jpeg"
      },
      // Add more teacher data here
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/Group 3234.png", height: 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherRegister(),
                      ),
                    );
                  },
                  child: Icon(Icons.add, size: 30),
                ),
              ],
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.04),
            Text(
              "सुप्रभातम्‌",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.02),
            Text(
              "जैसे धरती का अंधेरा सूरज हटाता है, वैसे ही जीवन का अंधेरा शिक्षक हटाता है।",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.03),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'नाम यहां खोजें...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Attendence(
                              teacherName: teacher['name']!,
                              teacherImage: teacher['image']!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: THelperFunctions.screenHeight() * 0.22,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.asset(
                                      teacher['image']!,
                                      height: 74,
                                      width: 74,
                                    ),
                                  ),
                                ),
                                SizedBox(width: THelperFunctions.screenWidth() * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teacher['name']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      teacher['subject']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      teacher['phone']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    "Present",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
