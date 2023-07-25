import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/services/getstorage_services.dart';

import '../../../services/notification_services.dart';
import '../model/home_post_model.dart';
import '../model/home_records_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    if (Get.find<StorageServices>().storage.read('usertype') == 'Fisherman') {
      await getRecordings();
      hometext.value = "Navigation & Logs";
    } else {
      hometext.value = "Feed & Posting";
    }
    getPost();
    isLoading.value = false;
    super.onInit();
  }

  final ImagePicker picker = ImagePicker();
  TextEditingController post = TextEditingController();

  RxString hometext = "".obs;
  RxBool isLoading = true.obs;

  RxList<Records> recordsList = <Records>[].obs;
  RxList<Post> postList = <Post>[].obs;

  // RxString fileName = ''.obs;
  // RxString filePath = ''.obs;
  // RxString fileType = ''.obs;
  RxList imagesPick = [].obs;
  UploadTask? uploadTask;
  RxBool isPosting = false.obs;

  DocumentReference? userDocumentReference;

  getRecordings() async {
    try {
      List data = [];
      var res = await FirebaseFirestore.instance
          .collection('tracking')
          .where('userid',
              isEqualTo: Get.find<StorageServices>().storage.read('id'))
          .orderBy('datecreated', descending: true)
          .limit(100)
          .get();
      var records = res.docs;
      for (var i = 0; i < records.length; i++) {
        Map obj = {
          "id": records[i].id,
          "name": records[i]['name'],
          "locations": records[i]['locations'],
          "datecreated": records[i]['datecreated'].toDate().toString(),
          "startingtime": records[i]['startingtime'].toDate().toString(),
          "endingtime": records[i]['endingtime'].toDate().toString(),
          "temperature": records[i]['temperature'],
          "weather": records[i]['weather'],
        };
        data.add(obj);
      }

      recordsList.assignAll(await recordsFromJson(jsonEncode(data)));
      recordsList.sort((b, a) => a.datecreated.compareTo(b.datecreated));
    } on Exception catch (e) {
      print(e);
    }
  }

  getPost() async {
    try {
      List data = [];
      var res = await FirebaseFirestore.instance
          .collection('post')
          .orderBy('datecreated', descending: true)
          .limit(100)
          .get();
      var post = res.docs;
      for (var i = 0; i < post.length; i++) {
        var userDetail = await post[i]['user'].get();
        Map obj = {
          "id": post[i].id,
          "image": post[i]['image'],
          "likes": post[i]['likes'],
          "datecreated": post[i]['datecreated'].toDate().toString(),
          "message": post[i]['message'],
          "user": userDetail.data(),
          "userid": post[i]['userid'],
        };
        data.add(obj);
      }
      postList.assignAll(await postFromJson(jsonEncode(data)));
      postList.sort((b, a) => a.datecreated.compareTo(b.datecreated));
    } on Exception catch (e) {
      print(e);
    }
  }

  deletePost({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(documentID)
          .delete();
      postList.removeWhere((element) => element.id == documentID);
    } catch (e) {}
  }

  getDuration({required DateTime start, required DateTime end}) {
    Duration dur = end.difference(start);
    return (dur.inHours % 24).toString().padLeft(2, '0') +
        ":" +
        (dur.inMinutes % 60).toString().padLeft(2, '0') +
        ":" +
        (dur.inSeconds % 60).toString().padLeft(2, '0');
  }

  pickFilesInGallery() async {
    imagesPick.clear();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.length > 0) {
      for (var i = 0; i < result.length; i++) {
        imagesPick.add({
          "filePath": result[i].path,
          "fileName": result[i].name,
          "fileType": result[i].path.split('.').last
        });
      }
    } else {
      // User canceled the picker
    }
    print(imagesPick);
  }

  postSomething() async {
    isPosting(true);
    try {
      String fileLink = '';
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));
      List imageLinkList = [];
      if (imagesPick.length > 0) {
        for (var i = 0; i < imagesPick.length; i++) {
          Uint8List uint8list = Uint8List.fromList(
              File(imagesPick[i]['filePath']).readAsBytesSync());
          final ref = await FirebaseStorage.instance
              .ref()
              .child("files/${imagesPick[i]['fileName']}");
          uploadTask = ref.putData(uint8list);
          final snapshot = await uploadTask!.whenComplete(() {});
          fileLink = await snapshot.ref.getDownloadURL();
          imageLinkList.add(fileLink);
        }
      }
      await FirebaseFirestore.instance.collection('post').add({
        "message": post.text,
        "image": imageLinkList,
        "user": userDocumentReference,
        "userid": Get.find<StorageServices>().storage.read('id'),
        "comments": [],
        "likes": [],
        "datecreated": DateTime.now()
      });
      Get.back();
      Get.snackbar("Message", "Posted", backgroundColor: ColorServices.white);
      getPost();
    } catch (e) {
      print(e);
    }
    isPosting(false);
  }

  checkIfLike({required Post post, required int index}) {
    RxBool isExist = false.obs;
    for (var i = 0; i < post.likes.length; i++) {
      if (post.likes[i] == Get.find<StorageServices>().storage.read('id')) {
        isExist.value = true;
        postList[index].isLike.value = true;
      }
    }
  }

  likeOrRemoveLike(
      {required bool isLike,
      required String documentID,
      required Post post,
      required User userDetails,
      required int index}) async {
    if (isLike == true) {
      // remove like
      try {
        var postDocumentReference =
            await FirebaseFirestore.instance.collection('post').doc(documentID);

        postDocumentReference.update({
          'likes': FieldValue.arrayRemove(
              [Get.find<StorageServices>().storage.read('id')])
        });
        postList[index].isLike.value = false;
        postList[index].likesCount.value = postList[index].likesCount.value - 1;
      } on Exception catch (e) {
        print(e);
      }
    } else {
      // like post
      try {
        var postDocumentReference =
            await FirebaseFirestore.instance.collection('post').doc(documentID);
        postDocumentReference.update({
          'likes': FieldValue.arrayUnion(
              [Get.find<StorageServices>().storage.read('id')])
        });
        postList[index].isLike.value = true;
        postList[index].likesCount.value = postList[index].likesCount.value + 1;
        Get.find<NotificationServices>().sendNotification(
            userToken: userDetails.fcmToken,
            message:
                "Hi ${userDetails.firstname}, ${Get.find<StorageServices>().storage.read('firstname')} likes your post",
            title: "Message",
            subtitle: "");
      } on Exception catch (e) {
        print("ERROR : ${e}");
      }
    }
  }
}
