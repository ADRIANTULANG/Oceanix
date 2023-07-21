import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/getstorage_services.dart';
import 'package:oceanix/src/messaginglobby_screen/model/messaginglobby_chat_model.dart';

import '../model/messagingblobby_user_model.dart';

class MessagingLobbyController extends GetxController {
  @override
  void onInit() {
    getAllUser();
    getChats();
    updateOnline();
    super.onInit();
  }

  @override
  void onClose() async {
    listener!.cancel();
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .update({"isonline": false});
    } on Exception catch (e) {
      print(e);
    }
    super.onClose();
  }

  RxList<Users> usersList = <Users>[].obs;
  RxList<Users> usersList_masterList = <Users>[].obs;
  RxList<ChatModel> lobbyChatList = <ChatModel>[].obs;

  TextEditingController search_user = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController chatmessage = TextEditingController();

  StreamSubscription<dynamic>? listener;
  Stream? streamChats;

  updateOnline() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .update({"isonline": true});
    } on Exception catch (e) {
      print(e);
    }
  }

  getAllUser() async {
    List data = [];
    var res = await FirebaseFirestore.instance.collection('users').get();
    var users = res.docs;

    for (var i = 0; i < users.length; i++) {
      Map obj = {
        "id": users[i].id,
        "contactno": users[i]['contactno'],
        "fcmToken": users[i].data().containsKey('fcmToken') == true
            ? users[i]['fcmToken']
            : "",
        "firstname": users[i]['firstname'],
        "lastname": users[i]['lastname'],
        "image": users[i]['image'],
        "usertype": users[i]['usertype'],
        "email": users[i]['email'],
      };
      if (Get.find<StorageServices>().storage.read('id') != users[i].id) {
        data.add(obj);
      }
    }
    usersList.assignAll(await usersFromJson(jsonEncode(data)));
    usersList_masterList.assignAll(await usersFromJson(jsonEncode(data)));
  }

  searchUsers({required String keyword}) async {
    usersList.clear();
    if (keyword != '') {
      for (var i = 0; i < usersList_masterList.length; i++) {
        if (usersList_masterList[i]
                .email
                .toLowerCase()
                .toString()
                .contains(keyword) ||
            usersList_masterList[i]
                .firstname
                .toLowerCase()
                .toString()
                .contains(keyword) ||
            usersList_masterList[i]
                .lastname
                .toLowerCase()
                .toString()
                .contains(keyword)) {
          usersList.add(usersList_masterList[i]);
        }
      }
    } else {
      usersList.assignAll(usersList_masterList);
    }
  }

  createChat() async {
    try {
      String sendtoID = '';
      for (var i = 0; i < usersList_masterList.length; i++) {
        if (usersList_masterList[i].isSelected.value == true) {
          sendtoID = usersList_masterList[i].id;
        }
      }
      var sendToDocumentReference =
          await FirebaseFirestore.instance.collection('users').doc(sendtoID);
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));

      var res = await FirebaseFirestore.instance.collection('chats').where(
          'users',
          isEqualTo: [userDocumentReference, sendToDocumentReference]).get();
      var res2 = await FirebaseFirestore.instance.collection('chats').where(
          'users',
          isEqualTo: [sendToDocumentReference, userDocumentReference]).get();
      var chat = res.docs;
      var chat2 = res2.docs;
      String chatdocumentID = '';
      for (var i = 0; i < chat.length; i++) {
        chatdocumentID = chat[i].id;
      }
      if (chatdocumentID == '') {
        for (var i = 0; i < chat2.length; i++) {
          chatdocumentID = chat2[i].id;
        }
      }

      if (chatdocumentID == '') {
        await FirebaseFirestore.instance.collection('chats').add({
          "users": [userDocumentReference, sendToDocumentReference],
          "updatedAt": DateTime.now(),
          "chatmessages": [
            {
              "message": message.text,
              "sender": Get.find<StorageServices>().storage.read('id'),
              "receiver": sendtoID,
              "datecreated": DateTime.now().toString(),
              "isText": true
            }
          ]
        });
      } else {
        var postDocumentReference = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatdocumentID);
        postDocumentReference.update({
          'chatmessages': FieldValue.arrayUnion([
            {
              "message": message.text,
              "sender": Get.find<StorageServices>().storage.read('id'),
              "receiver": sendtoID,
              "datecreated": DateTime.now().toString(),
              "isText": true
            }
          ]),
          "updatedAt": DateTime.now()
        });
      }
      Get.back();
    } on Exception catch (e) {
      print(e);
    }
  }

  getChats() async {
    List<Map<String, dynamic>> dataList = [];
    var userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    streamChats = await FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContainsAny: [userDocumentReference])
        .limit(100)
        .snapshots();

    listener = streamChats!.listen((event) async {
      for (var chats in event.docs) {
        var userDetails = await chats['users'];
        List users = [];
        Map usertodisplay = {};

        for (var i = 0; i < userDetails.length; i++) {
          var datauser = await userDetails[i].get();
          var useObj = datauser.data();
          useObj['id'] = datauser.id;
          users.add(useObj);
          if (datauser.id != Get.find<StorageServices>().storage.read('id')) {
            usertodisplay = useObj;
          }
        }
        var newchatlist = chats['chatmessages'].reversed.toList();

        dataList.add({
          "id": chats.id,
          "updatedAt": chats['updatedAt'].toDate().toString(),
          "chatmessages": newchatlist,
          "users": users,
          "usertodisplay": usertodisplay
        });
      }

      dataList.sort((a, b) => b['updatedAt'].compareTo(a['updatedAt']));

      Map<String, Map<String, dynamic>> resultMap = {};
      for (Map<String, dynamic> data in dataList) {
        String id = data['id'];
        if (!resultMap.containsKey(id) ||
            data['updatedAt'].compareTo(resultMap[id]!['updatedAt']) > 0) {
          resultMap[id] = data;
        }
      }

      List<Map<String, dynamic>> result = resultMap.values.toList();
      lobbyChatList.assignAll(await chatModelFromJson(jsonEncode(result)));
      lobbyChatList.sort((a, b) {
        return (b.updatedAt.compareTo(a.updatedAt));
      });
    });
  }

  createChat_from_inside(
      {required String sendtoID, required String chatmessage}) async {
    try {
      var sendToDocumentReference =
          await FirebaseFirestore.instance.collection('users').doc(sendtoID);
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));
      var res = await FirebaseFirestore.instance.collection('chats').where(
          'users',
          isEqualTo: [userDocumentReference, sendToDocumentReference]).get();
      var res2 = await FirebaseFirestore.instance.collection('chats').where(
          'users',
          isEqualTo: [sendToDocumentReference, userDocumentReference]).get();
      var chat = res.docs;
      var chat2 = res2.docs;
      String chatdocumentID = '';
      for (var i = 0; i < chat.length; i++) {
        chatdocumentID = chat[i].id;
      }
      if (chatdocumentID == '') {
        for (var i = 0; i < chat2.length; i++) {
          chatdocumentID = chat2[i].id;
        }
      }

      if (chatdocumentID == '') {
        await FirebaseFirestore.instance.collection('chats').add({
          "users": [userDocumentReference, sendToDocumentReference],
          "updatedAt": DateTime.now(),
          "chatmessages": [
            {
              "message": chatmessage,
              "sender": Get.find<StorageServices>().storage.read('id'),
              "receiver": sendtoID,
              "datecreated": DateTime.now().toString(),
              "isText": true
            }
          ]
        });
      } else {
        var postDocumentReference = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatdocumentID);
        postDocumentReference.update({
          'chatmessages': FieldValue.arrayUnion([
            {
              "message": chatmessage,
              "sender": Get.find<StorageServices>().storage.read('id'),
              "receiver": sendtoID,
              "datecreated": DateTime.now().toString(),
              "isText": true
            }
          ]),
          "updatedAt": DateTime.now()
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
