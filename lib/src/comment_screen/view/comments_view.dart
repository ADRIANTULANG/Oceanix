import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/comment_screen/image_widgets/more_image.dart';
import 'package:oceanix/src/comment_screen/image_widgets/one_image.dart';
import 'package:oceanix/src/comment_screen/image_widgets/three_image.dart';
import 'package:oceanix/src/comment_screen/image_widgets/two_image.dart';
import 'package:oceanix/src/comment_screen/widget/view_postpictures.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';
import '../alertdialog/comment_alertdialog.dart';
import '../controller/comments_controller.dart';

class CommentView extends GetView<CommentsController> {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CommentsController());
    return Obx(() => controller.isLoading.value == true
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
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.post!.image.length == 0
                        ? SizedBox(
                            height: 5.h,
                          )
                        : SizedBox(),
                    InkWell(
                      onTap: () {
                        if (controller.post!.image.length > 0) {
                          Get.to(() => ViewPostPictures(
                              imagesList: controller.post!.image));
                        }
                      },
                      child: controller.post!.image.length == 0
                          ? SizedBox()
                          : controller.post!.image.length == 1
                              ? OneImage(image: controller.post!.image[0])
                              : controller.post!.image.length == 2
                                  ? TwoImage(
                                      image1: controller.post!.image[0],
                                      image2: controller.post!.image[1])
                                  : controller.post!.image.length == 3
                                      ? ThreeImage(
                                          image1: controller.post!.image[0],
                                          image2: controller.post!.image[1],
                                          image3: controller.post!.image[2])
                                      : controller.post!.image.length > 3
                                          ? MoreImage(
                                              image1: controller.post!.image[0],
                                              image2: controller.post!.image[1],
                                              image3: controller.post!.image[2],
                                              remaining: (controller
                                                          .post!.image.length -
                                                      3)
                                                  .toString(),
                                            )
                                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Post",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    controller.post!.message == ""
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 5.w),
                            child: Text(
                              controller.post!.message,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 11.sp),
                            ),
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Comments",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: InkWell(
                        onTap: () {
                          CommentAlertDialog.showCreateComment(
                              controller: controller);
                        },
                        child: Container(
                          height: 6.5.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(width: 1, color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 2.w),
                          child: Text(
                            "Whats on your mind..",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.sp,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.commentList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Container(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 6.h,
                                          width: 10.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(controller
                                                            .commentList[index]
                                                            .user
                                                            .image ==
                                                        ""
                                                    ? "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
                                                    : controller
                                                        .commentList[index]
                                                        .user
                                                        .image)),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          controller
                                              .commentList[index].user.email,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 1.h, bottom: 1.h, left: 3.w),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 1.h,
                                            bottom: 1.h,
                                            left: 3.w,
                                            right: 3.w),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan[50],
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            controller
                                                .commentList[index].comment,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 11.sp,
                                                color: Colors.grey[700]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
  }
}
