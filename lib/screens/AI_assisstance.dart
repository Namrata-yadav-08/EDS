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
  ChatUser geminiUser = ChatUser(id: "1", firstName: "सेतु बॉट");

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _voiceText = '';
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("सेतु बॉट", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
        actions: [
          if (_isGenerating)
            IconButton(
              icon: Icon(Icons.cancel,size: 20,),
              onPressed: _stopGeneration,
            ),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DashChat(
        
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
        hintText: "अपने सवाल पूछें", // Custom placeholder text
        fillColor: const Color.fromARGB(255, 249, 223, 185), // Background color for the text field
        filled: true, // Enables the filled background
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the container
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Rounded border
          borderSide: BorderSide.none, // No border line
        ),
      ),
        sendButtonBuilder: (Function() onSend) {
          return IconButton(
            onPressed: onSend,
            icon: Icon(
              Icons.send,
              color: Color.fromRGBO(192, 119, 33, 1.0), // Customize your color here
            ),
          );},
          trailing: [
            IconButton(
              onPressed: _voicenote,
              icon: Icon(Icons.mic,color: Color.fromRGBO(192, 119, 33, 1.0),size: 35,),
            ),
          ],
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
      _isGenerating = true;
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen(
        (event) {
          if (!_isGenerating) return; // Stop generating if flag is false
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
        },
        onDone: () {
          setState(() {
            _isGenerating = false;
          });
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        _isGenerating = false;
      });
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
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5); // Adjust this value to control speed

    setState(() {
      _isSpeaking = true;
    });

    await _flutterTts.speak(text);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  void _stopGeneration() {
    setState(() {
      _isGenerating = false;
    });
    if (_isSpeaking) {
      _flutterTts.stop();
    }
  }
}