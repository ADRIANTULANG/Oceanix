import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/comment_screen/controller/comments_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';

class CommentAlertDialog {
  static showCreateComment({required CommentsController controller}) async {
    TextEditingController comment = TextEditingController();
    Get.dialog(AlertDialog(
        content: Container(
      height: 40.h,
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
            height: 20.h,
            width: 100.w,
            child: TextField(
              maxLength: 300,
              maxLines: 14,
              controller: comment,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
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
                  if (comment.text.isNotEmpty) {
                    controller.commentToPost(comment: comment.text);
                  }
                }),
          ),
        ],
      ),
    )));
  }
}
