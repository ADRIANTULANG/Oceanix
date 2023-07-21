// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  String id;
  DateTime updatedAt;
  List<Chatmessage> chatmessages;
  List<User> users;
  User usertodisplay;

  ChatModel({
    required this.id,
    required this.updatedAt,
    required this.chatmessages,
    required this.users,
    required this.usertodisplay,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        chatmessages: List<Chatmessage>.from(
            json["chatmessages"].map((x) => Chatmessage.fromJson(x))),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        usertodisplay: User.fromJson(json["usertodisplay"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "chatmessages": List<dynamic>.from(chatmessages.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "usertodisplay": usertodisplay.toJson(),
      };
}

class Chatmessage {
  String receiver;
  String sender;
  DateTime datecreated;
  String message;
  bool isText;

  Chatmessage({
    required this.receiver,
    required this.sender,
    required this.datecreated,
    required this.message,
    required this.isText,
  });

  factory Chatmessage.fromJson(Map<String, dynamic> json) => Chatmessage(
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

class User {
  String image;
  String password;
  String firstname;
  String usertype;
  String fcmToken;
  String email;
  String contactno;
  String lastname;
  String id;

  User({
    required this.image,
    required this.password,
    required this.firstname,
    required this.usertype,
    required this.fcmToken,
    required this.email,
    required this.contactno,
    required this.lastname,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        image: json["image"],
        password: json["password"],
        firstname: json["firstname"],
        usertype: json["usertype"],
        fcmToken: json["fcmToken"],
        email: json["email"],
        contactno: json["contactno"],
        lastname: json["lastname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "password": password,
        "firstname": firstname,
        "usertype": usertype,
        "fcmToken": fcmToken,
        "email": email,
        "contactno": contactno,
        "lastname": lastname,
        "id": id,
      };
}
