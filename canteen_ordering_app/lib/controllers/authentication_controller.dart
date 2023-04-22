import 'package:canteen_ordering_app/views/canteen_page.dart';
import 'package:get/get.dart';



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
    if (userFromFirebase != null) {

        Get.to(CanteenListPage());

    } else {

        //TODO:reload page, 
        //Get.pop(), followed by get.off(Login Page(isWrongPassword = True))
        print("fail");

    }
  }



}