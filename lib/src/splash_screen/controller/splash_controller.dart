import 'dart:async';

import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/view/home_view.dart';

import '../../../services/getstorage_services.dart';
import '../../../services/notification_services.dart';
import '../../login_screen/view/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigate_to_homescreen();
    super.onInit();
  }

  navigate_to_homescreen() async {
    Timer(Duration(seconds: 3), () {
      if (Get.find<StorageServices>().storage.read('id') == null) {
        Get.to(() => LoginView());
      } else {
        Get.to(() => HomeView());
        Get.find<NotificationServices>().getToken();
      }
    });
  }
}
