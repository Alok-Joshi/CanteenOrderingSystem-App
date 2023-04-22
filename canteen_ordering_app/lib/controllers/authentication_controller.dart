import 'package:canteen_ordering_app/views/canteen_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends GetxController {

     Rx<User?> _userFromFirebase = Rx<User?>(null);
     final auth = FirebaseAuth.instance;
     Future SignIn(String email, String password) async 
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


//now visualize the menu page. It will have a navigation bar. One page will show the menu, one page will show drinks, and one page will show the 
// menu: [canteen_id, menu: list[food_items]]
// food_item: [name, type [drink: food], price]
// create a menu item card with 2 buttons . Should display the two things: Name, quantity, and price. 
// create a cart 

