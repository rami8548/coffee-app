import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String content;
  final String senderId;
  final String time;
  final String url;

  ChatModel({required this.content, required this.senderId, required this.time,required this.url});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      content: json['content'],
      senderId: json['senderId'],
      time: json["time"],
      url: json["url"],
    );
  }
}
