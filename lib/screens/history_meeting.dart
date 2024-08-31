// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Make sure to import Firestore package
// import 'package:zoom/services/firestore_methods.dart'; // Adjust the import path accordingly

// class HistoryMeetingScreen extends StatelessWidget {
//   const HistoryMeetingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Meeting History'),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirestoreMethods().meetingsHistory, // Stream<QuerySnapshot>
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('Something went wrong. Please try again later.'),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text('No meeting history available.'),
//             );
//           }

//           // Extracting meeting history from snapshot data
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var meetingData = snapshot.data!.docs[index].data() as Map<String, dynamic>; // Cast to Map
              
//               return ListTile(
//                 title: Text(
//                   'Room Name: ${meetingData['meetingName']}',
//                 ),
//                 subtitle: Text(
//                   'Joined on ${DateFormat.yMMMd().format((meetingData['createdAt'] as Timestamp).toDate())}', // Correct conversion from Timestamp
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}