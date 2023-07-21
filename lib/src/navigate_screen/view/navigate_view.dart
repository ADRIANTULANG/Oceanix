import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oceanix/src/navigate_screen/controller/navigate_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/colors_services.dart';
import '../../../services/location_services.dart';

class NavigateView extends GetView<NavigateController> {
  const NavigateView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavigateController());
    return Scaffold(
      body: Stack(
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
                      Get.find<LocationServices>().locationData!.longitude!),
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
                polylines: Set<Polyline>.of(controller.polylines.values),
                onCameraMoveStarted: () {
                  print("camera started");
                },
                onMapCreated: (GoogleMapController g_controller) async {
                  if (controller.googleMapController.isCompleted) {
                  } else {
                    controller.googleMapController.complete(g_controller);
                  }
                  controller.camera_controller = await g_controller;
                  controller.animateCamera();
                },
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 20.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            controller.name.value,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15.sp),
                          )),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Obx(() => Text(
                                controller.duration.value,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp),
                              )),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            controller.datecreated.value,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp),
                          )),
                      Row(
                        children: [
                          Icon(
                            Icons.cloud_sharp,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Obx(() => Text(
                                controller.weather.value,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp),
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      controller.myLocationAnimate();
                    },
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorServices.mainColor),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "My Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(
                            Icons.my_location_rounded,
                            size: 20.sp,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
