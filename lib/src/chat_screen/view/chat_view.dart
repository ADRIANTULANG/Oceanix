import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/chat_screen/controller/chat_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../services/getstorage_services.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  children: [
                    Obx(
                      () => Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(controller.receiverImage.value)),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Obx(
                      () => Text(
                        controller.receiverName.value,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Chats",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 1.w,
              ),
              Divider(),
              Expanded(
                child: Container(
                  child: Obx(
                    () => ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 10,
                              ),
                              child: Align(
                                alignment:
                                    (controller.messages[index].receiver ==
                                            Get.find<StorageServices>()
                                                .storage
                                                .read('id')
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        (controller.messages[index].receiver ==
                                                Get.find<StorageServices>()
                                                    .storage
                                                    .read('id')
                                            ? Colors.grey.shade200
                                            : Colors.cyan[50]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    controller.messages[index].message,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 7.w,
                                right: 7.w,
                              ),
                              child: Align(
                                  alignment:
                                      (controller.messages[index].receiver ==
                                              Get.find<StorageServices>()
                                                  .storage
                                                  .read('id')
                                          ? Alignment.topLeft
                                          : Alignment.topRight),
                                  child: Text(
                                    DateFormat('yMMMd').format(controller
                                            .messages[index].datecreated) +
                                        " " +
                                        DateFormat('jm').format(controller
                                            .messages[index].datecreated),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 9.sp),
                                  )),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 10.h,
                padding: EdgeInsets.only(bottom: 2.h, left: 3.w, right: 3.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 5.h,
                      width: 85.w,
                      child: TextField(
                        controller: controller.chatmessage,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Type something..'),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          controller.createChat_from_inside(
                              chattext: controller.chatmessage.text);
                        },
                        child: Icon(Icons.send))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
