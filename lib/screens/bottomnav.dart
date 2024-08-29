import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zoom/screens/AI_assisstance.dart';
import 'package:zoom/screens/Issue_screen.dart';
import 'package:zoom/screens/Teacher_Attendence.dart';
import 'package:zoom/screens/home.dart';
import 'package:zoom/screens/inventory.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:zoom/utils/helper_functions.dart';

class BottomNavBar extends StatefulWidget {
  final UserModel user1; 

  BottomNavBar({required this.user1});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    final List<Widget> _screens = [
      HomeScreen(),
      AiAssisstance(),
      IssueScreen(user: widget.user1), 
       AddItemScreen(user: widget.user1),
      TeacherAttendence(),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Image.asset("assets/uil_meeting-board.png"),
          Image.asset("assets/Group (1).png"),
          Image.asset("assets/majesticons_home-line.png"),
          Image.asset("assets/Vector (24).png"),
          Image.asset("assets/Vector (25).png"),
        ],
        color: Color.fromRGBO(192, 119, 33, 1.0),
        buttonBackgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _screens[_page], // Display the screen based on the selected index
    );
  }
}
