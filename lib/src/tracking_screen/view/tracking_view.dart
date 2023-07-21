import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/src/tracking_screen/controller/tracking_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/location_services.dart';
import '../widget/tracking_alertdialogs.dart';

class TrackingView extends GetView<TrackingController> {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackingController());
    return WillPopScope(
      onWillPop: () => controller.getBack(controller: controller),
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                child: Obx(
                  () => GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          Get.find<LocationServices>().locationData!.latitude!,
                          Get.find<LocationServices>()
                              .locationData!
                              .longitude!),
                      zoom: 14.4746,
                    ),
                    markers: controller.marker.toSet(),
                    myLocationEnabled: true,
                    onCameraMove: (position) {
                      // if (controller.status.value == 'Has Order') {
                      //   controller.onCameraMove(
                      //       latlng: position.target, position: position);
                      // }
                    },
                    // polylines: Set<Polyline>.of(controller.polylines.values),
                    onCameraMoveStarted: () {
                      print("camera started");
                    },
                    onMapCreated: (GoogleMapController g_controller) async {
                      if (controller.googleMapController.isCompleted) {
                      } else {
                        controller.googleMapController.complete(g_controller);
                      }
                      controller.camera_controller = await g_controller;
                    },
                  ),
                ),
              ),
              Positioned(
                  child: Container(
                height: 10.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Obx(
                    () => controller.isNavigating.value == false
                        ? InkWell(
                            onTap: () {
                              controller.recordLocations();
                              Get.snackbar(
                                  "Message", "Currently recording locations..",
                                  backgroundColor: Colors.white);
                              controller.isNavigating.value = true;
                            },
                            child: Container(
                              height: 7.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorServices.mainColor),
                              alignment: Alignment.center,
                              child: Text(
                                "Start Navigating",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18.sp),
                              ),
                            ),
                          )
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (controller.isPaused.value == false) {
                                      controller.isPaused.value = true;
                                      Get.snackbar("Message", "Tracking paused",
                                          backgroundColor: Colors.white);
                                    } else {
                                      controller.isPaused.value = false;
                                      Get.snackbar(
                                          "Message", "Tracking resumed",
                                          backgroundColor: Colors.white);
                                    }
                                  },
                                  child: Container(
                                    height: 7.h,
                                    width: 43.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorServices.mainColor),
                                    child: Obx(
                                      () => controller.isPaused.value == false
                                          ? Icon(
                                              Icons.pause_circle,
                                              size: 25.sp,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.play_arrow,
                                              size: 25.sp,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    TrackingAlertDialogs.showPutName(
                                        controller: controller);
                                  },
                                  child: Container(
                                    height: 7.h,
                                    width: 43.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorServices.mainColor),
                                    child: Icon(
                                      Icons.save_rounded,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
