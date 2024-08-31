import 'dart:math';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/resources/firestor_authmethods.dart';


class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final _jitsiMeet = JitsiMeet();

  Future<String> createMeeting() async {
    try {
      var random = Random();
      String roomName = (random.nextInt(10000000) + 10000000).toString();

      _firestoreMethods.addToMeetingHistory(roomName);

      return roomName;
    } catch (error) {
      print("Error creating meeting: $error");
      return '';
    }
  }

  Future<void> joinMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
  }) async {
    try {
      String name = _authMethods.user.displayName ?? 'Guest';
      String? email = _authMethods.user.email;

      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": "Meeting: $roomName",
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          "welcomepage.enabled": false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: email,
        ),
      );

      await _jitsiMeet.join(options);
    } catch (error) {
      print("Error joining meeting: $error");
    }
  }
}