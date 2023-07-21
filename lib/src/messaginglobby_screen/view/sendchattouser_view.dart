import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/messaginglobby_screen/controller/messaginglobby_controller.dart';
import 'package:sizer/sizer.dart';

class SendChatToUser extends GetView<MessagingLobbyController> {
  const SendChatToUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text(
                "New Message",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: controller.search_user,
                  onChanged: (value) {
                    controller.searchUsers(
                        keyword: controller.search_user.text);
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Search user',
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Container(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.usersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 7.h,
                                    width: 13.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(controller
                                                        .usersList[index]
                                                        .image ==
                                                    ""
                                                ? "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
                                                : controller
                                                    .usersList[index].image))),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.usersList[index].firstname +
                                            " " +
                                            controller
                                                .usersList[index].lastname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        controller.usersList[index].email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Obx(
                                () => Checkbox(
                                    value: controller
                                        .usersList[index].isSelected.value,
                                    onChanged: (value) {
                                      for (var i = 0;
                                          i < controller.usersList.length;
                                          i++) {
                                        if (controller.usersList[index].id ==
                                            controller.usersList[i].id) {
                                          controller.usersList[i].isSelected
                                              .value = true;
                                        } else {
                                          controller.usersList[i].isSelected
                                              .value = false;
                                        }
                                      }
                                      for (var i = 0;
                                          i <
                                              controller
                                                  .usersList_masterList.length;
                                          i++) {
                                        if (controller.usersList[index].id ==
                                            controller
                                                .usersList_masterList[i].id) {
                                          controller.usersList_masterList[i]
                                              .isSelected.value = true;
                                        } else {
                                          controller.usersList_masterList[i]
                                              .isSelected.value = false;
                                        }
                                      }
                                    }),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 7.h,
                    width: 75.w,
                    child: TextField(
                      controller: controller.message,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 3.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Type something..',
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      if (controller.message.text.isNotEmpty) {
                        controller.createChat();
                      }
                    },
                    child: Container(
                        height: 7.h,
                        padding: EdgeInsets.only(left: 3.w),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.send_rounded,
                          size: 35.sp,
                        )),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
