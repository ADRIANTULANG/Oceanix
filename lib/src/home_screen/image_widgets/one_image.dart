import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class OneImage extends GetView<HomeController> {
  const OneImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
      child: Container(
        height: 25.h,
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth, image: NetworkImage(image))),
      ),
    );
  }
}
