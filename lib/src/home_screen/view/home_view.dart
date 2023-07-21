import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/src/home_screen/widget/feedposting_view.dart';
import 'package:oceanix/src/home_screen/widget/navigation_and_logs_view.dart';
import 'package:sizer/sizer.dart';
import '../../../services/getstorage_services.dart';
import '../../tracking_screen/view/tracking_view.dart';
import '../controller/home_controller.dart';
import '../widget/home_appdrawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Obx(
      () => controller.isLoading.value == true
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFadingCircle(
                  color: ColorServices.mainColor,
                  size: 45.sp,
                ),
              ),
            )
          : Scaffold(
              drawer: HomeAppDrawer.showAppDrawer(controller: controller),
              body: SafeArea(
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.hometext.value,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Get.find<StorageServices>()
                                          .storage
                                          .read('usertype') !=
                                      "Fisherman"
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        controller.hometext.value =
                                            "Navigation & Logs";
                                      },
                                      child: Container(
                                        height: 7.h,
                                        width: 12.w,
                                        decoration: BoxDecoration(
                                          color: ColorServices.mainColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.location_on_rounded,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.hometext.value = "Feed & Posting";
                                },
                                child: Container(
                                  height: 7.h,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                    color: ColorServices.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.feed,
                                    color: Colors.white,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Builder(builder: (context) {
                                return InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                    // Get.offAll(() => LoginView());
                                    // Get.find<StorageServices>()
                                    //     .removeStorageCredentials();
                                  },
                                  child: Container(
                                    height: 7.h,
                                    width: 12.w,
                                    decoration: BoxDecoration(
                                      color: ColorServices.mainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person_2,
                                      color: Colors.white,
                                      size: 25.sp,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      Obx(
                        () => Container(
                            child:
                                controller.hometext.value == "Navigation & Logs"
                                    ? NavigationAndLogsView()
                                    : FeedAndPosting()),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton:
                  Obx(() => controller.hometext.value == "Navigation & Logs"
                      ? FloatingActionButton(
                          onPressed: () {
                            Get.to(() => TrackingView());
                          },
                          child: Icon(Icons.add_location_alt_sharp),
                        )
                      : SizedBox()),
            ),
    );
  }
}
