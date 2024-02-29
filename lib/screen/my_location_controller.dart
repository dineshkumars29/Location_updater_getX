import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:location_updater/model/location_values.dart';
import 'package:location_updater/services/common_widgets.dart';
import 'package:location_updater/services/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
    as GeoLocator;

class MylocationController extends GetxController {
  RxList buttonList = [
    {
      "text": "Request Location Permission",
      "background_color": Colors.blue,
      "text_color": Colors.white,
    },
    {
      "text": "Request Notification Permission",
      "background_color": Colors.yellow,
      "text_color": Colors.black
    },
    {
      "text": "Start Location Update",
      "background_color": Colors.green,
      "text_color": Colors.white
    },
    {
      "text": "Stop Location Update",
      "background_color": Colors.red,
      "text_color": Colors.white
    }
  ].obs;

  Timer? timer;
  RxList<LocationValues> locationValues = <LocationValues>[].obs;
  final Location location = Location();
  PermissionStatus? permissionGranted;
  Position? currentPosition;
  RxDouble currentSpeed = 0.0.obs;
  RxBool isLocationEnable = false.obs;
  RxBool isLocationUpdateStarted = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  saveData(List<LocationValues> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = LocationValues.encode(data);
    await prefs.setString('location_key', encodedData);
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? decodedData = prefs.getString('location_key');

    if (decodedData != null) {
      locationValues.value = LocationValues.decode(decodedData);
    }
  }

  startUpdateToTheUser() {
    timer = Timer.periodic(const Duration(seconds: 30), ((timer) {
      getCurrentLocation();
    }));
  }

  stopUpdateToTheUser(context) {
    isLocationUpdateStarted == false;
    timer?.cancel();
    notify(context, "Location update stoped");
  }

  Future<void> checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();

    permissionGranted = permissionGrantedResult;
    print(permissionGranted);
  }

  Future<void> requestPermission(context) async {
    if (permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();

      permissionGranted = permissionRequestedResult;
      isLocationEnable.value = false;
    } else {
      isLocationEnable.value = false;
      notify(context, "Permission already granted");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLocationEnable.value = false;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: GeoLocator.LocationAccuracy.best);
      double speed = await Geolocator.getCurrentPosition(
              desiredAccuracy: GeoLocator.LocationAccuracy.best)
          .then((value) => value.speed);

      currentPosition = position;
      currentSpeed.value = speed;
      locationValues.add(LocationValues(
          latitude: currentPosition!.latitude,
          longitude: currentPosition!.longitude,
          speed: speed));
      print(locationValues);
      saveData(locationValues);
    } catch (e) {
      isLocationEnable.value = false;
      print(e);
    }
  }

  permission.PermissionStatus? status;

  notificationAccess(context) async {
    status = await permission.Permission.notification.request();
    if (status != null) {
      if (status!.isGranted) {
        NotificationService().initNotification();
        NotificationService().showNotification(
            title: 'Hello!', body: 'Notification Permission granted');
      } else {
        isLocationEnable.value = false;
        notify(context,
            "Please enable notification permission for future updates");
      }
    } else {
      isLocationEnable.value = false;
      notify(context, "notification permission already granted");
    }
  }

  notify(context, String message) {
    if (status == null) {
      Commonwidget.message(context, message);
    } else if (status!.isGranted) {
      NotificationService().showNotification(title: 'Hello!', body: message);
    } else {
      Commonwidget.message(context, message);
    }
  }
}
