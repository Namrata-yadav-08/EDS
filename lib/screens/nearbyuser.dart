// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:zoom/screens/user_repo.dart';
// import 'package:zoom/screens/userreepo.dart';

// class NearbyUsersScreen extends StatefulWidget {
//   @override
//   _NearbyUsersScreenState createState() => _NearbyUsersScreenState();
// }

// class _NearbyUsersScreenState extends State<NearbyUsersScreen> {
//   List<UserModel> _nearbyUsers = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchNearbyUsers();
//   }

//   Future<void> _fetchNearbyUsers() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition();
//       double currentLat = position.latitude;
//       double currentLon = position.longitude;

//       List<UserModel> nearbyUsers =
//           await UserRepository.getNearbyUsers(currentLat, currentLon);
//       setState(() {
//         _nearbyUsers = nearbyUsers;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   Future<void> _sendNotifications() async {
//     try {
//       for (var user in _nearbyUsers) {
//         if (user.fcmToken != null) {
//           await UserRepository.sendNotification(
//             user.fcmToken!,
//             'Nearby Users Alert',
//             'You have users nearby within 5 km!',
//           );
//         }
//         if (user.email != null) {
//           await UserRepository.sendEmail(
//             user.email!,
//             'Nearby Users Alert',
//             'You have users nearby within 5 km!',
//           );
//         }
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Notifications sent successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to send notifications: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Nearby Users"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: _sendNotifications,
//             tooltip: 'Send Notifications',
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? Center(child: Text('Error: $_errorMessage'))
//               : _nearbyUsers.isEmpty
//                   ? Center(child: Text('No users found within 5 km.'))
//                   : ListView.builder(
//                       itemCount: _nearbyUsers.length,
//                       itemBuilder: (context, index) {
//                         UserModel user = _nearbyUsers[index];
//                         return ListTile(
//                           title: Text("${user.first} ${user.last}"),
//                           subtitle: Text("Location: ${user.x}, ${user.y}"),
//                           leading: user.photo.isNotEmpty
//                               ? Image.network(user.photo)
//                               : Icon(Icons.person),
//                         );
//                       },
//                     ),
//     );
//   }
// }