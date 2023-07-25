import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/getstorage_services.dart';
import 'package:oceanix/src/messaginglobby_screen/controller/messaginglobby_controller.dart';
import 'package:oceanix/src/messaginglobby_screen/view/sendchattouser_view.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../services/colors_services.dart';
import '../../chat_screen/view/chat_view.dart';
import '../model/messaginglobby_chat_model.dart';

class MessagingLobyyView extends GetView<MessagingLobbyController> {
  const MessagingLobyyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MessagingLobbyController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(Get.find<StorageServices>()
                                      .storage
                                      .read('image') ==
                                  ""
                              ? "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
                              : Get.find<StorageServices>()
                                  .storage
                                  .read('image'))),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    Get.find<StorageServices>().storage.read('firstname') +
                        " " +
                        Get.find<StorageServices>().storage.read('lastname'),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Messages",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Divider(),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.lobbyChatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          String receiverDocumentID = '';
                          User? userDetails;

                          for (var i = 0;
                              i < controller.lobbyChatList[index].users.length;
                              i++) {
                            if (controller.lobbyChatList[index].users[i].id !=
                                Get.find<StorageServices>()
                                    .storage
                                    .read('id')) {
                              receiverDocumentID =
                                  controller.lobbyChatList[index].users[i].id;
                              userDetails =
                                  controller.lobbyChatList[index].users[i];
                            }
                          }

                          Get.to(() => ChatView(), arguments: {
                            "chatDocumentID":
                                controller.lobbyChatList[index].id,
                            "sendtoID": receiverDocumentID,
                            "userDetails": userDetails
                          });
                          await controller.onOpenUpdateSeenBy(
                              chatDocumentID:
                                  controller.lobbyChatList[index].id);
                          Future.delayed(Duration(seconds: 3), () {
                            controller.lobbyChatList[index].isSeen.value = true;
                          });
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller
                                                    .lobbyChatList[index]
                                                    .usertodisplay
                                                    .image ==
                                                ""
                                            ? "https://firebasestorage.googleapis.com/v0/b/oceanix-f6af3.appspot.com/o/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg?alt=media&token=11992427-ec8d-4c8c-9552-b21585aa6335"
                                            : controller.lobbyChatList[index]
                                                .usertodisplay.image)),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.lobbyChatList[index]
                                              .usertodisplay.firstname +
                                          " " +
                                          controller.lobbyChatList[index]
                                              .usertodisplay.lastname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                    Container(
                                      width: 70.w,
                                      child: Row(
                                        children: [
                                          Text(
                                            controller
                                                        .lobbyChatList[index]
                                                        .chatmessages[0]
                                                        .sender ==
                                                    Get.find<StorageServices>()
                                                        .storage
                                                        .read('id')
                                                ? "you: "
                                                : "",
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9.sp),
                                          ),
                                          Text(
                                            controller
                                                        .lobbyChatList[index]
                                                        .chatmessages[0]
                                                        .isText ==
                                                    true
                                                ? controller
                                                    .lobbyChatList[index]
                                                    .chatmessages[0]
                                                    .message
                                                : "sent an image.",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      DateFormat('yMMMd').format(controller
                                              .lobbyChatList[index]
                                              .chatmessages[0]
                                              .datecreated) +
                                          " " +
                                          DateFormat('jm').format(controller
                                              .lobbyChatList[index]
                                              .chatmessages[0]
                                              .datecreated),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 7.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Obx(
                              () => controller
                                          .lobbyChatList[index].isSeen.value ==
                                      true
                                  ? SizedBox()
                                  : Container(
                                      height: 4.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(
                                          color: ColorServices.mainColor,
                                          shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 7.sp),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => SendChatToUser());
          },
          child: Icon(Icons.send_rounded),
        ),
      ),
    );
  }
}
