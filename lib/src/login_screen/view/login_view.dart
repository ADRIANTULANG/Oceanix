import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../services/colors_services.dart';
import '../../register_screen/view/register_view.dart';
import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: ColorServices.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: ColorServices.black,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/logologin.jpg"))),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: controller.email,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 3.w),
                    alignLabelWithHint: false,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: controller.password,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 3.w),
                    alignLabelWithHint: false,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: SizedBox(
                width: 100.w,
                height: 7.h,
                child: ElevatedButton(
                    child: Text("LOGIN", style: TextStyle(fontSize: 18.sp)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorServices.mainColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () {
                      if (controller.email.text.isEmpty ||
                          controller.password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Empty field'),
                        ));
                      } else if (controller.email.text.isEmail == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid Email'),
                        ));
                      } else {
                        controller.login();
                      }
                      // controller.sampleEmail();
                    }),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                children: [
                  Text(
                    "Dont have an account? ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 11.sp,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  InkWell(
                    onTap: () async {
                      Get.to(() => RegistrationView());
                    },
                    child: Text(
                      "Sign up.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
