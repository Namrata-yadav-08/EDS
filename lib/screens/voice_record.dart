import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MicrophoneScreen extends StatefulWidget {
  const MicrophoneScreen({super.key});

  @override
  State<MicrophoneScreen> createState() => _MicrophoneScreenState();
}

class _MicrophoneScreenState extends State<MicrophoneScreen> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _filePath;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!_isRecording) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath = '${directory.path}/audio_recording.aac';

      setState(() {
        _isRecording = true;
        _startTime = DateTime.now();
      });

      await _recorder!.startRecorder(toFile: _filePath);

      // Stop recording after 60 seconds
      Future.delayed(Duration(seconds: 60), () async {
        if (_isRecording) {
          await _stopRecording();
        }
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      if (_startTime != null) {
        final duration = DateTime.now().difference(_startTime!);

        if (duration.inSeconds < 1) {
          // Recording is less than 1 second; show a message and do not upload
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Recording is too short to upload.')),
          );
          return;
        }
      }

      await _uploadRecording();
    }
  }

  Future<void> _uploadRecording() async {
    if (_filePath == null) return;

    try {
      // Get the current user ID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is currently logged in.')),
        );
        return;
      }
      String userId = user.uid;

      // Generate a unique filename based on the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload the file to Firebase Storage
      File file = File(_filePath!);
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('users/$userId/recordings/$fileName.aac')
          .putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata to Firestore in user-specific collection
      await FirebaseFirestore.instance.collection('Users').doc(userId).collection('recordings').add({
        'url': downloadUrl,
        'timestamp': DateTime.now(),
      });

      // Optionally, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording uploaded successfully!')),
      );
    } catch (e) {
      print('Failed to upload recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IconButton(
          icon: _isRecording ?Image.asset("assets/Group 3206 (2).png"): Image.asset("assets/Group 3206.png") ,
          onPressed: _isRecording ? _stopRecording : _startRecording,
        ),
      ),
    );
  }
}
