import 'package:canteen_ordering_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/views/login_page.dart';
import 'package:canteen_ordering_app/views/canteen_page.dart';
import 'package:canteen_ordering_app/controllers/authentication_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.put(AuthenticationController());
    return GetMaterialApp(
      title: 'Ordering App',
      debugShowCheckedModeBanner: false,
      home: CanteenListPage()
    );
  }
}
