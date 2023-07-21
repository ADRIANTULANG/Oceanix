import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/services/getstorage_services.dart';

import '../../../services/notification_services.dart';
import '../../home_screen/model/home_post_model.dart';
import '../model/comments_model.dart';

class CommentsController extends GetxController {
  Post? post;
  RxBool isLoading = true.obs;
  DocumentReference? userDocumentReference;
  RxList<Comment> commentList = <Comment>[].obs;
  @override
  void onInit() async {
    userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    post = await Get.arguments['post'];
    getComments();
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });

    super.onInit();
  }

  getComments() async {
    try {
      List data = [];
      var res = await FirebaseFirestore.instance
          .collection('post')
          .doc(post!.id)
          .get();
      var comments = res.get('comments');
      for (var i = 0; i < comments.length; i++) {
        var userDetail = await comments[i]['user'].get();
        Map obj = {
          "comment": comments[i]['comment'],
          "datecreated": comments[i]['datecreated'].toDate().toString(),
          "user": userDetail.data(),
        };
        data.add(obj);
      }
      commentList.assignAll(await commentFromJson(jsonEncode(data)));
      commentList.sort((b, a) => a.datecreated.compareTo(b.datecreated));
    } on Exception catch (e) {
      print(e);
    }
  }

  commentToPost({required String comment}) async {
    try {
      var postDocumentReference =
          await FirebaseFirestore.instance.collection('post').doc(post!.id);
      postDocumentReference.update({
        'comments': FieldValue.arrayUnion([
          {
            "user": userDocumentReference,
            "userid": Get.find<StorageServices>().storage.read('id'),
            "comment": comment,
            "datecreated": DateTime.now()
          }
        ])
      });
      Get.back();
      Get.snackbar("Message", "Comment posted",
          backgroundColor: ColorServices.white);
      getComments();
      Get.find<NotificationServices>().sendNotification(
          userToken: post!.user.fcmToken,
          message:
              "Hi ${post!.user.firstname}, ${Get.find<StorageServices>().storage.read('firstname')} commented on your post",
          title: "Message",
          subtitle: "");
    } on Exception catch (e) {
      print(e);
    }
  }
}
