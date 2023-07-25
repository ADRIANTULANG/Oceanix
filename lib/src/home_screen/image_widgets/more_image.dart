import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class MoreImage extends GetView<HomeController> {
  const MoreImage({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.remaining,
  });
  final String image1;
  final String image2;
  final String image3;
  final String remaining;

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
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image1))),
                    )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image2))),
                    ))
                  ],
                ),
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
                              fit: BoxFit.cover, image: NetworkImage(image3))),
                    )),
                    Expanded(
                        child: Container(
                      child: Center(
                        child: Text(
                          remaining + "+",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      ),
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
