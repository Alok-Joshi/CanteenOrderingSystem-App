import 'package:canteen_ordering_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.put(AuthenticationController());
    ;
      return GetMaterialApp(
      title: 'Ordering App',
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
