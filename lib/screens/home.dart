import 'package:flutter/material.dart';
import 'package:zoom/screens/login.dart';
import 'package:zoom/screens/user_model.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user1;
  
  HomeScreen({
    required this.user1,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    
    pages = [
      LoginScreen(user: widget.user1),
     
    ];
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
        elevation: 0,
        title: const Text('आभासी कक्षा', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: pages[_page],
    );
  }
}
