import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oceanix/services/colors_services.dart';
import 'package:oceanix/src/home_screen/model/home_records_model.dart';
import 'package:intl/intl.dart';
import '../../../services/location_services.dart';

class NavigateController extends GetxController {
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? camera_controller;
  RxList<Marker> marker = <Marker>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Records record = Records(
      id: "",
      name: "",
      locations: [],
      datecreated: DateTime.now(),
      startingtime: DateTime.now(),
      endingtime: DateTime.now(),
      temperature: 0.0,
      weather: "");
  RxString name = ''.obs;
  RxString datecreated = ''.obs;
  RxString duration = ''.obs;
  RxString weather = ''.obs;
  @override
  void onInit() async {
    record = await Get.arguments['record'];
    name.value = record.name;
    datecreated.value = DateFormat('yMMMd').format(record.datecreated) +
        " " +
        DateFormat('jm').format(record.datecreated);
    duration.value =
        getDuration(start: record.startingtime, end: record.endingtime);
    weather.value = record.weather;
    for (var i = 0; i < record.locations.length; i++) {
      polylineCoordinates
          .add(LatLng(record.locations[i].lat, record.locations[i].long));
    }
    await addPolyLine(polylineCoordinates);
    if (record.locations.length > 0) {
      marker.add(Marker(
        position: LatLng(record.locations[0].lat, record.locations[0].long),
        markerId: MarkerId(0.toString()),
      ));
      marker.add(Marker(
        position: LatLng(record.locations[record.locations.length - 1].lat,
            record.locations[record.locations.length - 1].long),
        markerId: MarkerId(1.toString()),
      ));
    }
    super.onInit();
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: ColorServices.mainColor,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  animateCamera() async {
    if (record.locations.length > 0) {
      await camera_controller!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(record.locations[0].lat, record.locations[0].long),
        zoom: 18.4746,
      )));
    }
  }

  myLocationAnimate() async {
    var locationData =
        await Get.find<LocationServices>().location.getLocation();
    await camera_controller!
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 18.4746,
    )));
  }

  getDuration({required DateTime start, required DateTime end}) {
    Duration dur = end.difference(start);
    return (dur.inHours % 24).toString().padLeft(2, '0') +
        ":" +
        (dur.inMinutes % 60).toString().padLeft(2, '0') +
        ":" +
        (dur.inSeconds % 60).toString().padLeft(2, '0');
  }
}
