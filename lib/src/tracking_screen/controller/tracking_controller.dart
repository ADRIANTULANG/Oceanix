import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/services/getstorage_services.dart';
import 'package:oceanix/services/location_services.dart';
import 'package:oceanix/src/home_screen/controller/home_controller.dart';
import 'package:oceanix/src/tracking_screen/widget/tracking_alertdialogs.dart';

class TrackingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Timer? timer;

  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? camera_controller;
  RxList<Marker> marker = <Marker>[].obs;

  RxBool isNavigating = false.obs;
  RxBool isPaused = false.obs;

  List locationSave = [];

  DateTime? startingtime;

  recordLocations() async {
    startingtime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 30), (timer) async {
      if (isPaused.value == true) {
        print("timer is paused");
      } else {
        print(DateTime.now());
        var locationData =
            await Get.find<LocationServices>().location.getLocation();
        locationSave.add(
            {"lat": locationData.latitude, "long": locationData.longitude});
        marker.add(Marker(
          position: LatLng(locationData.latitude!, locationData.longitude!),
          markerId: MarkerId(DateTime.now().toString()),
        ));
      }
    });
  }

  saveToDatabase({required String name}) async {
    isNavigating.value = false;
    timer!.cancel();
    var userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    var locationData =
        await Get.find<LocationServices>().location.getLocation();
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=e8d0fb58be98abaee28d1d5f3d862246&units=metric"));
    print(response.body);
    List weatherList = jsonDecode(response.body)['weather'];
    var temp = jsonDecode(response.body)['main']['temp'];
    String weather = '';
    if (weatherList.length > 0) {
      weather = weatherList[0]['description'];
    }
    try {
      await FirebaseFirestore.instance.collection('tracking').add({
        "name": name,
        "datecreated": DateTime.now(),
        "locations": locationSave,
        "user": userDocumentReference,
        "userid": Get.find<StorageServices>().storage.read('id'),
        "weather": weather,
        "temperature": temp,
        "startingtime": startingtime,
        "endingtime": DateTime.now()
      });

      Get.back();
      Get.back();
      Get.snackbar("Message", "Record saved",
          backgroundColor: ColorServices.white);
      Get.find<HomeController>().getRecordings();
    } catch (e) {}
  }

  getBack({required TrackingController controller}) async {
    if (isNavigating.value == true) {
      TrackingAlertDialogs.showWarningToExit(controller: controller);
    } else {
      if (timer != null) {
        timer!.cancel();
      }
      Get.back();
    }
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }
}
