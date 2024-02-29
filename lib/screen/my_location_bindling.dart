import 'package:get/get.dart';
import 'package:location_updater/screen/my_location_controller.dart';

class MyLocationBuilder extends Bindings {
  @override
  void dependencies() {
    Get.put<MylocationController>(MylocationController());
  }
}
