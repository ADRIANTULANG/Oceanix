import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class TwoImage extends GetView<HomeController> {
  const TwoImage({super.key, required this.image1, required this.image2});
  final String image1;
  final String image2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
      child: Container(
        height: 25.h,
        width: 100.w,
        decoration: BoxDecoration(border: Border.all()),
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
