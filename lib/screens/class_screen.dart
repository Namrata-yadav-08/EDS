import 'package:flutter/material.dart';
import 'package:zoom/screens/Subject_Screen.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/utils/helper_functions.dart';

class ClassSelection extends StatelessWidget {
  final UserModel user1;

  ClassSelection({
    required this.user1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/Group 3234.png", height: 50),
            Column(
              children: [
                Center(
                  child: Text(
                    "कक्षा चुनें",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(192, 119, 33, 1.0),
                    ),
                  ),
                ),
                SizedBox(height: THelperFunctions.screenHeight() * 0.1),
                ...List.generate(
                  5,
                  (index) {
                    final classNum = index + 1;
                    return Column(
                      children: [
                        ClassButton(
                          Screen: SubjectScreen(
                            kaksha: "Class $classNum",
                            user: user1,
                          ),
                          kaksha: "कक्षा $classNum",
                        ),
                        SizedBox(
                          height: THelperFunctions.screenHeight() * 0.02,
                        ),
                      ],
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ClassButton extends StatelessWidget {
  final String kaksha;
  final Widget Screen;

  ClassButton({
    required this.kaksha,
    required this.Screen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Screen),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF34495E)),
        minimumSize: MaterialStateProperty.all(Size(320, 50)),
      ),
      child: Text(
        kaksha,
        style: TextStyle(
          fontSize: 19,
          color: Colors.white,
        ),
      ),
    );
  }
}
