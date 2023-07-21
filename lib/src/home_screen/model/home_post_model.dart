// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String id;
  String image;
  List<dynamic> likes;
  DateTime datecreated;
  String message;
  User user;
  String userid;
  RxBool isLike;
  RxInt likesCount;

  Post({
    required this.id,
    required this.image,
    required this.likes,
    required this.datecreated,
    required this.message,
    required this.user,
    required this.userid,
    required this.isLike,
    required this.likesCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        image: json["image"],
        isLike: false.obs,
        likesCount: int.parse(json["likes"].length.toString()).obs,
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        datecreated: DateTime.parse(json["datecreated"]),
        message: json["message"],
        user: User.fromJson(json["user"]),
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isLike": isLike,
        "likesCount": likesCount,
        "image": image,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "datecreated": datecreated.toIso8601String(),
        "message": message,
        "user": user.toJson(),
        "userid": userid,
      };
}

class User {
  String image;
  String firstname;
  String password;
  String usertype;
  String fcmToken;
  String email;
  String lastname;
  String contactno;

  User({
    required this.image,
    required this.firstname,
    required this.password,
    required this.usertype,
    required this.fcmToken,
    required this.email,
    required this.lastname,
    required this.contactno,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        image: json["image"],
        firstname: json["firstname"],
        password: json["password"],
        usertype: json["usertype"],
        fcmToken: json["fcmToken"],
        email: json["email"],
        lastname: json["lastname"],
        contactno: json["contactno"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "firstname": firstname,
        "password": password,
        "usertype": usertype,
        "fcmToken": fcmToken,
        "email": email,
        "lastname": lastname,
        "contactno": contactno,
      };
}
