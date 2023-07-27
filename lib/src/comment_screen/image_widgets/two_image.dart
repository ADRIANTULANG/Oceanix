import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/comments_controller.dart';

class TwoImage extends GetView<CommentsController> {
  const TwoImage({super.key, required this.image1, required this.image2});
  final String image1;
  final String image2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        height: 35.h,
        width: 100.w,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image1))),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image2))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
