import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class ThreeImage extends GetView<HomeController> {
  const ThreeImage(
      {super.key,
      required this.image1,
      required this.image2,
      required this.image3});
  final String image1;
  final String image2;
  final String image3;
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
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image2))),
                    )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image3))),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
