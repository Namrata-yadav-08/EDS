import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetMethods {
  final JitsiMeet _jitsiMeet = JitsiMeet();
  final List<String> participants = [];

  void createMeeting({
    required String roomName,
 
    bool isAudioMuted = false,
    bool isVideoMuted = false,
  }) async {
    try {
      // Configure meeting options
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
        },
        userInfo: JitsiMeetUserInfo(
          // displayName: displayName,
          // email: email,
        ),
      );

      // Register event listeners directly using the new API
     JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: $url");
      },

      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
              "participantId: $participantId",
        );
        participants.add(participantId!);
      },

      // chatMessageReceived: (senderId, message, isPrivate) {
      //   debugPrint(
      //     "chatMessageReceived: senderId: $senderId, message: $message, "
      //         "isPrivate: $isPrivate",
      //   );
      // },

      readyToClose: () {
        debugPrint("readyToClose");
      },
    );

      // Join the meeting
      await _jitsiMeet.join(options);

    } catch (error) {
      debugPrint("Error: $error");
    }
  }
}
