import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class ViewPostPictures extends GetView<HomeController> {
  const ViewPostPictures({super.key, required this.imagesList});
  final List imagesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.black,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 100.h,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            // autoPlay: false,
          ),
          items: imagesList
              .map((item) => Container(
                    child: Center(
                        child: Image.network(
                      item,
                      fit: BoxFit.fitWidth,
                      height: 100.h,
                    )),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
