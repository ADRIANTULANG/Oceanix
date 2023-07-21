import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';

class CreatePostView extends GetView<HomeController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isPosting.value == true
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFadingCircle(
                  color: ColorServices.mainColor,
                  size: 45.sp,
                ),
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  "Create Post",
                  style: TextStyle(color: Colors.black),
                ),
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Container(
                height: 100.h,
                width: 100.w,
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Write something",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 20.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.post,
                        maxLines: 20,
                        maxLength: 400,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Attach image",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        controller.pickFilesInGallery();
                      },
                      child: Obx(
                        () => controller.fileName.value == ''
                            ? Container(
                                height: 35.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all()),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 50.sp,
                                    ),
                                    Text(
                                      "Click here to pick image",
                                      style: TextStyle(
                                          fontSize: 11.sp, color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: 35.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: FileImage(
                                            File(controller.filePath.value))),
                                    border: Border.all()),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: SizedBox(
                  width: 100.w,
                  height: 7.h,
                  child: ElevatedButton(
                      child: Text("POST", style: TextStyle(fontSize: 18.sp)),
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
                        controller.postSomething();
                      }),
                ),
              ),
            ),
    );
  }
}
