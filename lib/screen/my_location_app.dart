import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:location_updater/screen/my_location_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyLocationApp extends GetView<MylocationController> {
  const MyLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 2 : 1;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLocationEnable.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.8)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 200,
                              top: MediaQuery.of(context).size.height / 200),
                          child: const Text(
                            "Test App",
                            style:
                                TextStyle(color: Colors.white, fontSize: 26.0),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        GridView.builder(
                          itemCount: controller.buttonList.length,
                          controller: ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (index == 0) {
                                  controller.isLocationEnable.value = true;
                                  controller.requestPermission(context);
                                  controller.checkPermissions();
                                }
                                if (index == 1) {
                                  controller.notificationAccess(context);
                                }
                                if (index == 2) {
                                  if (controller.isLocationUpdateStarted ==
                                      false) {
                                    alertDialog(context);
                                  } else {
                                    controller.notify(context,
                                        "update location currently processing");
                                  }
                                }
                                if (index == 3) {
                                  controller.stopUpdateToTheUser(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.buttonList[index]
                                      ["background_color"],
                                  foregroundColor: controller.buttonList[index]
                                      ["text_color"],
                                  fixedSize: const Size.fromHeight(30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              child: Text(controller.buttonList[index]["text"]),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (1 / .14),
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 30.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 200,
                        right: MediaQuery.of(context).size.width / 200,
                        top: MediaQuery.of(context).size.height / 200,
                        bottom: MediaQuery.of(context).size.height / 200),
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.2)),
                    child: GridView.builder(
                      itemCount: controller.locationValues.length,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 30,
                              right: MediaQuery.of(context).size.width / 200,
                              top: MediaQuery.of(context).size.height / 200,
                              bottom: MediaQuery.of(context).size.height / 200),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 200,
                              right: MediaQuery.of(context).size.width / 200,
                              top: MediaQuery.of(context).size.height / 200,
                              bottom: MediaQuery.of(context).size.height / 200),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.07)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Request${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Lat: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "Lat ${controller.locationValues[index].latitude?.toStringAsFixed(3)}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Lng: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "${controller.locationValues[index].longitude?.toStringAsFixed(3)}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Speed: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "${controller.locationValues[index].speed?.toStringAsFixed(3)}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (1 / .25),
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  alertDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40,
              top: MediaQuery.of(context).size.height / 40,
              bottom: MediaQuery.of(context).size.height / 40),
          content: const Text('Do you want to start your Location Update?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.checkPermissions();
                if (controller.permissionGranted == PermissionStatus.denied) {
                  Navigator.of(context).pop();
                  controller.notify(context,
                      "Please enable location permission for future updates");
                  // Commonwidget.message(context,
                  //     "Please enable location permission for future updates");
                } else if (controller.permissionGranted ==
                    PermissionStatus.granted) {
                  Navigator.of(context).pop();
                  controller.isLocationEnable.value = true;
                  controller.startUpdateToTheUser();
                  controller.isLocationUpdateStarted == true;
                  controller.notify(context,
                      "current location status update for every 30s is started");
                } else {}
              },
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
