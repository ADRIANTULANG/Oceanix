// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  String comment;
  DateTime datecreated;
  User user;

  Comment({
    required this.comment,
    required this.datecreated,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        comment: json["comment"],
        datecreated: DateTime.parse(json["datecreated"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "datecreated": datecreated.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  String image;
  String password;
  String firstname;
  String usertype;
  String fcmToken;
  String email;
  String lastname;
  String contactno;

  User({
    required this.image,
    required this.password,
    required this.firstname,
    required this.usertype,
    required this.fcmToken,
    required this.email,
    required this.lastname,
    required this.contactno,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        image: json["image"],
        password: json["password"],
        firstname: json["firstname"],
        usertype: json["usertype"],
        fcmToken: json["fcmToken"],
        email: json["email"],
        lastname: json["lastname"],
        contactno: json["contactno"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "password": password,
        "firstname": firstname,
        "usertype": usertype,
        "fcmToken": fcmToken,
        "email": email,
        "lastname": lastname,
        "contactno": contactno,
      };
}
