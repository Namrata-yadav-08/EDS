import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/screens/AI_assisstance.dart';
import 'package:zoom/screens/bottomnav.dart';
import 'package:zoom/screens/joinmeet.dart';
import 'package:zoom/screens/meeting.dart';
import 'package:zoom/screens/splash_screen.dart';
import 'package:zoom/utils/apptheme.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Virtual Classroom',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => MeetingScreen(),
//         '/join-meeting': (context) => JoinMeetingScreen(),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoom clone',
       themeMode: ThemeMode.system,
       theme: TAppTheme.lighttheme,
       darkTheme: TAppTheme.darktheme,  
      // home:API(),
       home: SplashScreen(),
       );}}






       //home: SplashScreen(),
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Zoom clone',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: backgroundColor,
//         ),
//         home: LoginScreen()
// >>>>>>> 4e4d45d781d936fc925c862a62064afacec8c5b2
//         //StreamBuilder(
//         //   stream: AuthMethods().authChanges,
//         //   builder: (context, snapshot) {
//         //     if (snapshot.connectionState == ConnectionState.waiting) {
//         //       return const Center(
//         //         child: CircularProgressIndicator(),
//         //       );
//         //     }
//         //     if (snapshot.hasData) {
//         //       return const HomeScreen();
//         //     }

//         //     return const LoginScreen();
//         //   },
//         // )
//         );
  