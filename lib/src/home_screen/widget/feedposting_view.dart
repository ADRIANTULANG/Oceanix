import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/comment_screen/view/comments_view.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import 'create_post.dart';

class FeedAndPosting extends GetView<HomeController> {
  const FeedAndPosting({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              onTap: () {
                controller.fileName.value = '';
                controller.filePath.value = '';
                controller.fileType.value = '';
                controller.post.clear();
                Get.to(() => CreatePostView());
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
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: Container(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      controller.checkIfLike(
                          post: controller.postList[index], index: index);
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
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
                                                    .postList[index]
                                                    .user
                                                    .image ==
                                                ""
                                            ? "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
                                            : controller
                                                .postList[index].user.image)),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  controller.postList[index].user.email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            controller.postList[index].message == ""
                                ? SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.only(top: 1.h, bottom: 1.h),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        controller.postList[index].message,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11.sp,
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                  ),
                            controller.postList[index].image == ""
                                ? SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.only(top: 1.h, bottom: 2.h),
                                    child: Container(
                                      height: 25.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(controller
                                                  .postList[index].image))),
                                    ),
                                  ),
                            Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    Get.to(() => CommentView(), arguments: {
                                      'post': controller.postList[index]
                                    });
                                  },
                                  child: Container(child: Icon(Icons.comment)),
                                )),
                                Container(
                                  height: 3.h,
                                  child: VerticalDivider(
                                    thickness: .3,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    await controller.likeOrRemoveLike(
                                        userDetails:
                                            controller.postList[index].user,
                                        post: controller.postList[index],
                                        isLike: controller
                                            .postList[index].isLike.value,
                                        documentID:
                                            controller.postList[index].id,
                                        index: index);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller
                                              .postList[index].likesCount.value
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Container(
                                          child: Obx(() => Icon(
                                                Icons.thumb_up,
                                                color: controller
                                                            .postList[index]
                                                            .isLike
                                                            .value ==
                                                        true
                                                    ? Colors.blue
                                                    : Colors.black,
                                                size: 25.sp,
                                              ))),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Divider(
                              color: Colors.grey[500],
                              thickness: .2,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
