import 'package:canteen_ordering_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  Get.put(AuthenticationController());
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return GetMaterialApp(
      title: 'Ordering App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData( primarySwatch: Colors.deepPurple,
                        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
      )
    

    );
  }
}
