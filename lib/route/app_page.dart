import 'package:get/get.dart';
import 'package:location_updater/screen/my_location_app.dart';
import 'package:location_updater/screen/my_location_bindling.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage(
      name: "/myLocationApp",
      page: () => MyLocationApp(),
      binding: MyLocationBuilder(),
      preventDuplicates: true,
    ),
  ];
}
