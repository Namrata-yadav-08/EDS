import 'package:flutter/material.dart';
import 'package:zoom/screens/jitsi_meet_methods.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({Key? key}) : super(key: key);

  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  final TextEditingController _roomController = TextEditingController();
  bool _isAudioMuted = true;
  bool _isVideoMuted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('कक्षा बनाएँ',style: TextStyle(fontSize:20, color:Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomController,
              decoration: InputDecoration(
                labelText: 'रूम आईडी',
                border: OutlineInputBorder(),
                
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              activeColor:Color.fromRGBO(192, 119, 33, 1.0) ,
              title: Text('ऑडियो म्यूट करें'),
              value: _isAudioMuted,
              onChanged: (bool value) {
                setState(() {
                  _isAudioMuted = value;
                });
              },
            ),
            SwitchListTile(
               activeColor:Color.fromRGBO(192, 119, 33, 1.0) ,
              title: Text('वीडियो म्यूट करें'),
              value: _isVideoMuted,
              onChanged: (bool value) {
                setState(() {
                  _isVideoMuted = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(192, 119, 33, 1.0),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(320, 50),
                ),
              ),
              onPressed: () {
                _jitsiMeetMethods.joinMeeting(
                  roomName: _roomController.text,
                  isAudioMuted: _isAudioMuted,
                  isVideoMuted: _isVideoMuted,
                );
              },
              child: Text('जुड़ें',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }
}