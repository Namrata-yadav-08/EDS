import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialDetails extends StatefulWidget {
  final String heading;
  final String filename;
  final String subheading;
  final String url;
  final String documentId;
  final String kaksha;
  final String subject;
  final String userId;

  MaterialDetails({
    required this.heading,
    required this.filename,
    required this.subheading,
    required this.url,
    required this.documentId,
    required this.kaksha,
    required this.subject,
    required this.userId,
    super.key,
  });

  @override
  _MaterialDetailsState createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  Future<void> _deleteFile() async {
    try {
      // Delete file from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(widget.url);
      await storageRef.delete();

      // Delete document from Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId)
          .collection('classes')
          .doc(widget.kaksha)
          .collection(widget.subject)
          .doc(widget.documentId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('फ़ाइल सफलतापूर्वक हटा दी गई')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete file: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(widget.url)) {
          await launch(widget.url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch ${widget.url}')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(204, 210, 237, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf),
                        SizedBox(width: 10),
                        Text(
                          widget.heading,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(192, 119, 33, 1.0),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteFile(),
                    ),
                  ],
                ),
                Text(
                  widget.filename,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.subheading,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
