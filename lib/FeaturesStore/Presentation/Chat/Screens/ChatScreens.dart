import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Model/ChatBotMessage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatScreenBot extends StatefulWidget {
  const ChatScreenBot({super.key});

  @override
  State<ChatScreenBot> createState() => _ChatScreenBotState();
}

class _ChatScreenBotState extends State<ChatScreenBot> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;
    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);

        var response = await http.post(
          Uri.parse(
              "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyBbSVNNgp7fA7soa2-52K6hOq67cRhYNzY"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "contents": [
              {
                "parts": [
                  {"text": text}
                ]
              }
            ]
          }),
        );

        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          if (json.containsKey('candidates') && json['candidates'].isNotEmpty) {
            var content = json['candidates'][0]['content'];
            if (content.containsKey('parts')) {
              var parts = content['parts'];
              if (parts.isNotEmpty) {
                String botResponse = parts[0]['text'].toString().trimLeft();
                setState(() {
                  isTyping = false;
                  msgs.insert(
                    0,
                    Message(
                      false,
                      botResponse,
                    ),
                  );
                });
                scrollController.animateTo(0.0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut);
              }
            }
          }
        } else {
          print('Failed to load data: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Failed to load data: ${response.statusCode}")),
          );
        }
      }
    } on http.ClientException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Network error occurred, please try again!")),
      );
    } on FormatException catch (e) {
      print('FormatException: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid response format!")),
      );
    } on Exception catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some error occurred, please try again!")),
      );
    } finally {
      setState(() {
        isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Coffee",
          style: GoogleFonts.aladin(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: msgs.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: isTyping && index == 0
                          ? Column(
                              children: [
                                BubbleNormal(
                                  text: msgs[0].msg,
                                  isSender: true,
                                  color: Colors.blue.shade100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16, top: 4),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Typing...")),
                                )
                              ],
                            )
                          : BubbleNormal(
                              text: msgs[index].msg,
                              isSender: msgs[index].isSender,
                              textStyle: msgs[index].isSender
                                  ? GoogleFonts.alatsi(
                                      color: Colors.white, fontSize: 20)
                                  : GoogleFonts.alatsi(
                                      color: Colors.white, fontSize: 20),
                              color: msgs[index].isSender
                                  ? Colors.white10
                                  : Colors.black26,
                            ));
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Enter text"),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ],
      ),
    );
  }
}
