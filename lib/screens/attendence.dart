import 'package:flutter/material.dart';
import 'package:zoom/utils/helper_functions.dart';

class Attendence extends StatefulWidget {
  final String teacherName;
  final String teacherImage;

  const Attendence({
    Key? key,
    required this.teacherName,
    required this.teacherImage,
  }) : super(key: key);

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: THelperFunctions.screenHeight()*0.07,),
            Text(widget.teacherName, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,)),
            SizedBox(height: THelperFunctions.screenHeight()*0.05,),
            CircleAvatar(
              radius: 125, // Adjust size as needed
              backgroundImage: AssetImage(widget.teacherImage),
            ),
            SizedBox(height: THelperFunctions.screenHeight()*0.05,),
             Image.asset("assets/fingerprint.webp",height: 200,width: 200),
          ],
        ),
      ),
    );
  }
}
