import 'package:canteen_ordering_app/views/canteen_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
class AuthenticationController extends GetxController {

     Rx<User?> userFromFirebase = Rx<User?>(null);
     final auth = FirebaseAuth.instance;
     Future signIn(String email, String password) async 
     {
            try{

            UserCredential userCredential = await auth.signInWithEmailAndPassword( email: email, password: password );
            userFromFirebase = userCredential.user.obs;
            Get.put(CanteenController());  
            Get.off(CanteenListPage());

            }
            on FirebaseAuthException catch (e) {

                    Get.snackbar("Error","Invalid Email or Password");

            }

     }



}


//now visualize the menu page. It will have a navigation bar. One page will show the menu, one page will show drinks, and one page will show the 
// menu: [canteen_id, menu: list[food_items]]
// food_item: [name, type [drink: food], price]
// create a menu item card with 2 buttons . Should display the two things: Name, quantity, and price. 
// create a cart 

