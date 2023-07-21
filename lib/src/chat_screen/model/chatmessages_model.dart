// To parse this JSON data, do
//
//     final chats = chatsFromJson(jsonString);

import 'dart:convert';

List<Chats> chatsFromJson(String str) =>
    List<Chats>.from(json.decode(str).map((x) => Chats.fromJson(x)));

String chatsToJson(List<Chats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chats {
  String receiver;
  String sender;
  DateTime datecreated;
  String message;
  bool isText;

  Chats({
    required this.receiver,
    required this.sender,
    required this.datecreated,
    required this.message,
    required this.isText,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        receiver: json["receiver"],
        sender: json["sender"],
        datecreated: DateTime.parse(json["datecreated"]),
        message: json["message"],
        isText: json["isText"],
      );

  Map<String, dynamic> toJson() => {
        "receiver": receiver,
        "sender": sender,
        "datecreated": datecreated.toIso8601String(),
        "message": message,
        "isText": isText,
      };
}
