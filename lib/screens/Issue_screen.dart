import 'package:flutter/material.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/screens/voice_record.dart';
import 'package:zoom/utils/helper_functions.dart';

// ignore: must_be_immutable
class IssueScreen extends StatelessWidget {
  UserModel user;
   IssueScreen({
    required this.user,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor:Color.fromRGBO(192, 119, 33, 1.0) ,
        title: const Text('समस्या', style: TextStyle(fontSize: 20, color:Colors.white),),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                     Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MicrophoneScreen()));
                  },
                  child: Container(
                    height: THelperFunctions.screenHeight() * 0.18,
                    width: THelperFunctions.screenWidth() * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000000),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFfc636b),
                          Color(0xFFffbb00)
                        ], // Replace with your desired colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "शिक्षा",
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    )),
                  ),
                ),
                InkWell(
                  onTap: (){
                     Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MicrophoneScreen()));
                  },
                  child: Container(
                    height: THelperFunctions.screenHeight() * 0.18,
                    width: THelperFunctions.screenWidth() * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000000),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF23bf8e),
                          Color(0xFF04de34)
                        ], // Replace with your desired colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "सुविधा",
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    )),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
