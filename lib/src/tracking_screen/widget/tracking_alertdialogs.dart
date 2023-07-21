import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/tracking_screen/controller/tracking_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';

class TrackingAlertDialogs {
  static showPutName({required TrackingController controller}) async {
    TextEditingController name = TextEditingController();
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
            "Save tracking",
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
              controller: name,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 3.w),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Tracking Name',
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
                child: Text("Save", style: TextStyle(fontSize: 18.sp)),
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
                  if (name.text.isNotEmpty) {
                    controller.saveToDatabase(name: name.text);
                  }
                }),
          ),
        ],
      ),
    )));
  }

  static showWarningToExit({required TrackingController controller}) async {
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
            "Warning",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "The App is still recording your location, are you sure you want to exit?",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30.w,
                height: 7.h,
                child: ElevatedButton(
                    child: Text("No",
                        style: TextStyle(fontSize: 18.sp, color: Colors.black)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorServices.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () {
                      Get.back();
                    }),
              ),
              SizedBox(
                width: 30.w,
                height: 7.h,
                child: ElevatedButton(
                    child: Text("Yes", style: TextStyle(fontSize: 18.sp)),
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
                      if (controller.timer != null) {
                        controller.timer!.cancel();
                      }
                      Get.back();
                      Get.back();
                    }),
              ),
            ],
          ),
        ],
      ),
    )));
  }
}
