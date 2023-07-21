import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/view/home_view.dart';

import '../../../services/getstorage_services.dart';
import '../../../services/notification_services.dart';
import '../widget/login_screen_alertdialog.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  login() async {
    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.text)
        .where('password', isEqualTo: password.text)
        .limit(1)
        .get();

    if (res.docs.length > 0) {
      var userDetails = res.docs[0];
      var profileImage = userDetails['image'];

      if (userDetails['image'] == '') {
        profileImage =
            'https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335';
      }
      Get.find<StorageServices>().saveCredentials(
        usertype: userDetails['usertype'],
        id: userDetails.id,
        email: userDetails['email'],
        password: userDetails['password'],
        firstname: userDetails['firstname'],
        lastname: userDetails['lastname'],
        image: profileImage,
        contactno: userDetails['contactno'],
      );
      Get.offAll(() => HomeView());
      Get.find<NotificationServices>().getToken();
    } else {
      LoginAlertDialog.showAccountNotFound();
    }
  }
}
