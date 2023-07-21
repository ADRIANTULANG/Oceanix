// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String id;
  String contactno;
  String fcmToken;
  String firstname;
  String lastname;
  String image;
  String usertype;
  String email;
  RxBool isSelected;

  Users({
    required this.id,
    required this.contactno,
    required this.fcmToken,
    required this.firstname,
    required this.lastname,
    required this.image,
    required this.usertype,
    required this.email,
    required this.isSelected,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        contactno: json["contactno"],
        fcmToken: json["fcmToken"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        image: json["image"],
        usertype: json["usertype"],
        email: json["email"],
        isSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contactno": contactno,
        "fcmToken": fcmToken,
        "firstname": firstname,
        "lastname": lastname,
        "image": image,
        "usertype": usertype,
        "email": email,
        "isSelected": isSelected,
      };
}
