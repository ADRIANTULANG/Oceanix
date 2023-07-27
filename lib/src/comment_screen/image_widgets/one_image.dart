import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/comments_controller.dart';

class OneImage extends GetView<CommentsController> {
  const OneImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        height: 35.h,
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth, image: NetworkImage(image))),
      ),
    );
  }
}
