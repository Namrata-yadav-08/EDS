import 'package:flutter/material.dart';
import 'package:zoom/screens/upload_material.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/utils/helper_functions.dart';

class SubjectScreen extends StatelessWidget {
  final String kaksha;
  final UserModel user;

  SubjectScreen({required this.user, required this.kaksha, super.key});

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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "विषय चुनें",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(192, 119, 33, 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    ..._buildSubjectContainers(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSubjectContainers() {
    final subjects = [
      {"subject": "गणित", "image": 'assets/Group 22.png', "color": Color(0xFF34495E)},
      {"subject": "हिंदी", "image": "assets/Group 22.png", "color": Color(0xFFD9D9D9)},
      {"subject": "अंग्रेज़ी", "image": "assets/Group 22.png", "color": Color(0xFF34495E)},
      {"subject": "विज्ञान", "image": "assets/Group 22.png", "color": Color(0xFFD9D9D9)},
      {"subject": "सामाजिक विज्ञान", "image": "assets/Group 22.png", "color": Color(0xFF34495E)},
    ];

    return subjects.map((subjectData) {
      return Column(
        children: [
         SubjectContainer(
  Kaksha: kaksha,
  user: user,
  image: subjectData["image"]! as String,
  subject: subjectData["subject"]! as String,
  tcolor: subjectData["color"] == Color(0xFF34495E) ? Colors.white : Colors.black,
  x: subjectData["color"]! as Color,
),

          SizedBox(height: THelperFunctions.screenHeight() * 0.02),
        ],
      );
    }).toList();
  }
}

class SubjectContainer extends StatelessWidget {
  final String image;
  final String Kaksha;
  final String subject;
  final Color tcolor;
  final Color x;
  final UserModel user;

  SubjectContainer({
    required this.Kaksha,
    required this.user,
    required this.image,
    required this.subject,
    required this.tcolor,
    required this.x,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileUploadScreen(
              subject: subject,
              user: user,
              kaksha: Kaksha,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: x, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(height: 80, width: 80, child: Image.asset(image)), // Removed the `!` operator
              SizedBox(width: THelperFunctions.screenWidth() * 0.1),
              Expanded(
                child: Text(
                  maxLines: 2,
                  subject,
                  style: TextStyle(fontSize: 30, color: tcolor, fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
