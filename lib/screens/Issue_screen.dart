import 'package:flutter/material.dart';
import 'package:zoom/utils/helper_functions.dart';

class IssueScreen extends StatelessWidget {
  const IssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(192, 119, 33, 1.0),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
  height: THelperFunctions.screenHeight() * 0.18,
  width: THelperFunctions.screenWidth() * 0.40,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(1000000),
    gradient: LinearGradient(
      colors: [Color(0xFFfc636b), Color(0xFFffbb00)], // Replace with your desired colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: 
  Center(child: Text("शिक्षा", style: TextStyle(fontSize:50,color:Colors.white),)),
),

                 Container(
  height: THelperFunctions.screenHeight() * 0.18,
  width: THelperFunctions.screenWidth() * 0.40,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(1000000),
    gradient: LinearGradient(
      colors: [Color(0xFF23bf8e), Color(0xFF04de34)], // Replace with your desired colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: 
  Center(child: Text("सुविधा", style: TextStyle(fontSize:50,color:Colors.white),)),
),
            ],
          )
        ],
      )
    );
  }
}
