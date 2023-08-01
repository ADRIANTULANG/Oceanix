import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../login_screen/widget/login_screen_alertdialog.dart';
import '../../register_screen/controller/register_controller.dart';

class OtpController extends GetxController {
  String firstname = Get.find<RegistrationController>().firstname.text;
  String lastname = Get.find<RegistrationController>().lastname.text;
  String email = Get.find<RegistrationController>().email.text;
  String password = Get.find<RegistrationController>().password.text;
  String contact = Get.find<RegistrationController>().contact.text;
  String verifIDReceived = Get.find<RegistrationController>().verifIDReceived;
  String usertype = Get.find<RegistrationController>().usertype.value;
  RxBool isVerifyingOTP = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, context) async {
    try {
      isVerifyingOTP(true);
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        var deviceInfo = DeviceInfoPlugin();
        var androidDeviceInfo = await deviceInfo.androidInfo;
        try {
          await FirebaseFirestore.instance.collection("users").add({
            "image": "",
            "contactno": contact,
            "firstname": firstname,
            "lastname": lastname,
            "password": password,
            "email": email,
            "usertype": usertype,
            "isonline": false,
            "deviceID": androidDeviceInfo.id,
            "deviceName":
                androidDeviceInfo.brand + " " + androidDeviceInfo.product,
          });
          Get.back();
          Get.back();
          LoginAlertDialog.showSuccessCreateAccount();
        } on Exception catch (e) {
          print("something went wrong $e");
        }
      }
      isVerifyingOTP(false);
    } on FirebaseAuthException catch (e) {
      print(e);
      isVerifyingOTP(false);
    }
  }
}
