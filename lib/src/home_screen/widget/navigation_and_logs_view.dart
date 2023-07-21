import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:oceanix/src/navigate_screen/view/navigate_view.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class NavigationAndLogsView extends GetView<HomeController> {
  const NavigationAndLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 3.h),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.recordsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: InkWell(
                          onTap: () async {
                            Get.to(() => NavigateView(), arguments: {
                              "record": controller.recordsList[index]
                            });
                          },
                          child: Container(
                            height: 13.h,
                            width: 100.w,
                            child: Row(
                              children: [
                                Container(
                                  height: 13.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: ColorServices.mainColor),
                                  child: Icon(
                                    Icons.navigation,
                                    color: Colors.white,
                                    size: 25.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.recordsList[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp),
                                        ),
                                        Text(
                                            DateFormat('yMMMd').format(
                                                    controller
                                                        .recordsList[index]
                                                        .datecreated) +
                                                " " +
                                                DateFormat('jm').format(
                                                    controller
                                                        .recordsList[index]
                                                        .datecreated),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 11.sp)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 15.sp,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                                controller.getDuration(
                                                    start: controller
                                                        .recordsList[index]
                                                        .startingtime,
                                                    end: controller
                                                        .recordsList[index]
                                                        .endingtime),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11.sp))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.cloud,
                                              size: 15.sp,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                                controller
                                                    .recordsList[index].weather,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11.sp)),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                                controller.recordsList[index]
                                                        .temperature
                                                        .toString() +
                                                    " ℃",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11.sp)),
                                          ],
                                        )
                                      ]),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
