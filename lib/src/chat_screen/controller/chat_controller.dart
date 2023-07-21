import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/notification_services.dart';

import '../../../services/getstorage_services.dart';
import '../../messaginglobby_screen/model/messaginglobby_chat_model.dart';
import '../model/chatmessages_model.dart';

class ChatController extends GetxController {
  TextEditingController chatmessage = TextEditingController();

  StreamSubscription<dynamic>? listener;
  Stream? streamChats;

  StreamSubscription<dynamic>? listener_tocustomer;
  Stream? streamcustomer;

  RxString chatDocumentID = ''.obs;
  RxString sendtoID = ''.obs;
  RxString fcmToken = ''.obs;
  RxList<Chats> messages = <Chats>[].obs;

  User? userDetails;

  RxBool isOnline = false.obs;

  RxString receiverImage =
      "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
          .obs;
  RxString receiverName = ''.obs;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() async {
    userDetails = await Get.arguments['userDetails'];

    chatDocumentID.value = await Get.arguments['chatDocumentID'];
    sendtoID.value = await Get.arguments['sendtoID'];

    print(chatDocumentID.value);
    print(sendtoID.value);
    if (userDetails!.image != "") {
      receiverImage.value = userDetails!.image;
    }
    receiverName.value = userDetails!.firstname + " " + userDetails!.lastname;
    fcmToken.value = userDetails!.fcmToken;
    getChats();
    getCustomer();
    super.onInit();
  }

  getCustomer() async {
    streamcustomer = await FirebaseFirestore.instance
        .collection('users')
        .doc(sendtoID.value)
        .snapshots();
    listener_tocustomer = streamcustomer!.listen((event) async {
      var data = await event.data();
      isOnline.value = data['isonline'];
    });
  }

  getChats() async {
    streamChats = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocumentID.value)
        .snapshots();

    listener = streamChats!.listen((event) async {
      var data = await event.data();
      log(jsonEncode(data['chatmessages']));
      messages.assignAll(await chatsFromJson(jsonEncode(data['chatmessages'])));
      Future.delayed(Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
  }

  createChat_from_inside({required String chattext}) async {
    chatmessage.clear();
    try {
      var postDocumentReference = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDocumentID.value);
      postDocumentReference.update({
        'chatmessages': FieldValue.arrayUnion([
          {
            "message": chattext,
            "sender": Get.find<StorageServices>().storage.read('id'),
            "receiver": sendtoID.value,
            "datecreated": DateTime.now().toString(),
            "isText": true
          }
        ]),
        "updatedAt": DateTime.now()
      });
      Future.delayed(Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      if (isOnline.value == false) {
        Get.find<NotificationServices>().sendNotification(
            userToken: fcmToken.value,
            message: chattext,
            title: Get.find<StorageServices>().storage.read('firstname') +
                " " +
                Get.find<StorageServices>().storage.read('lastname'),
            subtitle: "");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void onClose() async {
    listener!.cancel();
    listener_tocustomer!.cancel();
    super.onClose();
  }
}
