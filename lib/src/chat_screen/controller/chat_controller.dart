import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  UploadTask? uploadTask;
  RxBool isOnline = false.obs;
  final ImagePicker picker = ImagePicker();
  RxString receiverImage =
      "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
          .obs;
  RxString receiverName = ''.obs;
  ScrollController scrollController = ScrollController();

  RxList<String> seenByList = <String>[].obs;
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
      messages.assignAll(await chatsFromJson(jsonEncode(data['chatmessages'])));
      seenByList.clear();
      for (var i = 0; i < data['seenby'].length; i++) {
        String name = data['seenby'][i].toString() ==
                Get.find<StorageServices>().storage.read('firstname')
            ? "you"
            : data['seenby'][i].toString();
        seenByList.add(name);
      }
      Future.delayed(Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      List seenby = data['seenby'];
      bool isExist = false;
      for (var i = 0; i < seenby.length; i++) {
        if (seenby[i] ==
            Get.find<StorageServices>().storage.read('firstname')) {
          isExist = true;
        }
      }
      if (isExist == false) {
        var postDocumentReference = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatDocumentID.value);
        postDocumentReference.update({
          'seenby': FieldValue.arrayUnion(
              [Get.find<StorageServices>().storage.read('firstname')]),
        });
      }
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
        "updatedAt": DateTime.now(),
        'seenby': [Get.find<StorageServices>().storage.read('firstname')],
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

  createChat_from_inside_image() async {
    chatmessage.clear();
    try {
      final XFile? result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        Uint8List uint8list =
            Uint8List.fromList(File(result.path).readAsBytesSync());
        final ref =
            await FirebaseStorage.instance.ref().child("files/${result.path}");
        uploadTask = ref.putData(uint8list);
        final snapshot = await uploadTask!.whenComplete(() {});
        String fileLink = await snapshot.ref.getDownloadURL();

        var postDocumentReference = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatDocumentID.value);
        postDocumentReference.update({
          'chatmessages': FieldValue.arrayUnion([
            {
              "message": fileLink,
              "sender": Get.find<StorageServices>().storage.read('id'),
              "receiver": sendtoID.value,
              "datecreated": DateTime.now().toString(),
              "isText": false
            }
          ]),
          "updatedAt": DateTime.now(),
          'seenby': [Get.find<StorageServices>().storage.read('firstname')],
        });
        Future.delayed(Duration(seconds: 1), () {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
        if (isOnline.value == false) {
          Get.find<NotificationServices>().sendNotification(
              userToken: fcmToken.value,
              message: Get.find<StorageServices>().storage.read('firstname') +
                  "sent an image.",
              title: Get.find<StorageServices>().storage.read('firstname') +
                  " " +
                  Get.find<StorageServices>().storage.read('lastname'),
              subtitle: "");
        }
      } else {
        // User canceled the picker
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  oncloseUpdateSeenBy() async {
    var res = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocumentID.value)
        .get();
    List seenby = res.get('seenby');
    bool isExist = false;
    for (var i = 0; i < seenby.length; i++) {
      if (seenby[i] == Get.find<StorageServices>().storage.read('firstname')) {
        isExist = true;
      }
    }
    if (isExist == false) {
      var postDocumentReference = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDocumentID.value);
      postDocumentReference.update({
        'seenby': FieldValue.arrayUnion(
            [Get.find<StorageServices>().storage.read('firstname')]),
      });
    }
  }

  @override
  void onClose() async {
    oncloseUpdateSeenBy();
    listener!.cancel();
    listener_tocustomer!.cancel();
    super.onClose();
  }
}
