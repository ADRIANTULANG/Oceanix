import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';

class HomeAlertdialogs {
  static showPutName({required HomeController controller}) async {
    TextEditingController comment = TextEditingController();
    Get.dialog(AlertDialog(
        content: Container(
      height: 25.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comment something..",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Container(
            height: 7.h,
            width: 100.w,
            child: TextField(
              controller: comment,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 3.w),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: '',
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            height: 7.h,
            child: ElevatedButton(
                child: Text("Done", style: TextStyle(fontSize: 14.sp)),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorServices.mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.white)))),
                onPressed: () {
                  if (comment.text.isNotEmpty) {}
                }),
          ),
        ],
      ),
    )));
  }

  static showLogoutDialog({required HomeController controller}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Logout?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.logout();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.green),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}
