import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/screens/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom/widgets/Material_widget.dart';

class FileUploadScreen extends StatefulWidget {
  final String kaksha;
  final UserModel user;
  final String subject;

  FileUploadScreen({
    required this.kaksha,
    required this.user,
    required this.subject,
    super.key,
  });

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;
  String? _uploadStatus = '';
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    try {
      final fileName = _selectedFile!.path.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('classes/${widget.kaksha}/${widget.subject}/$fileName');

      await storageRef.putFile(_selectedFile!);

      final downloadUrl = await storageRef.getDownloadURL();

      final description = _descriptionController.text.trim();
      final timestamp = Timestamp.now();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user.id)
          .collection('classes')
          .doc(widget.kaksha)
          .collection(widget.subject)
          .add({
        'fileUrl': downloadUrl,
        'fileName': fileName,
        'description': description,
        'timestamp': timestamp,
      });

      setState(() {
        _uploadStatus = 'सफलतापूर्वक अपलोड हो गया !';
        _selectedFile = null; // Clear selected file
        _descriptionController.clear(); // Clear description
      });
    } catch (e) {
      setState(() {
        _uploadStatus = 'Upload Failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
        title: Text(
          'सामग्री साझा',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFFD9D9D9),
              ),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: "विवरण जोड़ें",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(192, 119, 33, 1.0),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(320, 50),
                ),
              ),
              child: Text(
                "फ़ाइल चुनें",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_selectedFile != null)
              Text('Selected File: ${_selectedFile!.path.split('/').last}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(192, 119, 33, 1.0),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(320, 50),
                ),
              ),
              child: Text(
                "फ़ाइल अपलोड करें",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_uploadStatus != null)
              Text(
                _uploadStatus!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            SizedBox(height: 20),
            Expanded(
              child: _buildUploadedMaterialsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedMaterialsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user.id)
          .collection('classes')
          .doc(widget.kaksha)
          .collection(widget.subject)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No materials uploaded yet.'));
        }

        final materials = snapshot.data!.docs;

        return ListView.builder(
          itemCount: materials.length,
          itemBuilder: (context, index) {
            final material = materials[index].data() as Map<String, dynamic>;
            return MaterialDetails(
              heading: material['description'] ?? 'No description',
              filename: material['fileName'] ?? 'Unknown',
              subheading: (material['timestamp'] as Timestamp).toDate().toString(),
              url: material['fileUrl'],
              documentId: materials[index].id, // Pass the document ID for deletion
              kaksha: widget.kaksha,
              subject: widget.subject,
              userId: widget.user.id!,
            );
          },
        );
      },
    );
  }
}
