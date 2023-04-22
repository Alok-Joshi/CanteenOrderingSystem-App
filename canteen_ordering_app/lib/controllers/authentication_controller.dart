import 'package:canteen_ordering_app/views/canteen_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends GetxController {

     Rx<User?> _userFromFirebase = Rx<User?>(null);
     final auth = FirebaseAuth.instance;
     Future SignIn(String email, String password)
     {
            UserCredential userCredential = await auth.signInWithEmailAndPassword( email: email, password: password );

     }

    @override
    void onReady(){

        _userFromFirebase.bindStream(auth.authStateChanges());
        ever(_userFromFirebase, actionOnLogin);

    }
    void actionOnLogin(User? userFromFirebase) {
    if (userFromFirebase != null) { //valid login

        Get.to(CanteenListPage());

    } else {

        //TODO:reload page, 
        //Get.pop(), followed by get.off(Login Page(isWrongPassword = True))
        print("fail");

    }
  }



}

//1) canteen model [canteen_id, owner_id, canteen_name, canteen_start_time, canteen_end_time]
//2) Now make a controller for canteens
//3) use Init method in widget to change call controller canteen name
