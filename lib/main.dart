import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_updater/route/app_page.dart';
import 'package:location_updater/route/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.myLocationApp,
    );
  }
}
