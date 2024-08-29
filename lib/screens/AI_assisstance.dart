import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class API extends StatefulWidget {
  const API({super.key});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentuser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _voiceText = '';
  final FlutterTts _flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "सेतु बॉट",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(192, 119, 33, 1.0)),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child:DashChat(
  inputOptions: InputOptions(
    trailing: [
      IconButton(
        onPressed: _voicenote,
        icon: Icon(
          Icons.mic,
          color: Color.fromRGBO(192, 119, 33, 1.0),
          size: 35,
        ),
      ),
    ],
    inputDecoration: InputDecoration(
      hintText: "अपना प्रश्न पूछें", // Custom placeholder text
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(192, 119, 33, 1.0)), // Lightish orange color
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(192, 119, 33, 1.0)), // Lightish orange color when focused
      ),
    ),
    sendButtonBuilder: (callback) {
      return IconButton(
        onPressed: callback,
        icon: Icon(
          Icons.send,
          color: Color.fromRGBO(192, 119, 33, 1.0) // Lightish orange color for the send icon
        ),
      );
    },
  ),
  currentUser: currentuser,
  onSend: _sendMessage,
  messages: messages,
),



    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
          _speak(response);
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
          _speak(response);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _voicenote() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _voiceText = val.recognizedWords;
          });
          if (val.hasConfidenceRating && val.confidence > 0) {
            _sendVoiceMessage(_voiceText);
            _speech.stop();
            setState(() => _isListening = false);
          }
        });
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  void _sendVoiceMessage(String messageText) {
    ChatMessage chatMessage = ChatMessage(
        user: currentuser, createdAt: DateTime.now(), text: messageText);
    _sendMessage(chatMessage);
  }

  void _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }
}
