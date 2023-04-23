import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:canteen_ordering_app/models/menu.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final canteencon = Get.find<CanteenController>();
  Map<MenuItem,int>? cartTracker = {};
  //TODO: Make above map a map of cartTrackers, where we track carts for every canteen Map<String, Map<MenuItem,int>> , where String is key (canteen_id). Hence while querying,
  //first extract the currentCanteenID, and then proceed 

  void onAddPressed(MenuItem item){

      cartTracker![item] = (cartTracker![item] == null? 1 : cartTracker![item]! + 1); 

  }

  void onRemovePressed(MenuItem item){

      if(cartTracker![item] == null) return;

      cartTracker![item] = (cartTracker![item] == null? -1: cartTracker![item]! - 1);

      if(cartTracker![item]! <= 0 ){

            cartTracker!.remove(item);


      }


  }
  int getQuantity(MenuItem item){

      if(cartTracker![item] == null){
        return 0;
      }
      else return cartTracker![item]!;


  }

  Future<List<MenuItem>> getMenuItems(String type) async {

      final menusCollection =  _firestore.collection('menus');
      final menuDoc = await menusCollection.where("canteen_id",isEqualTo: canteencon.currentCanteenID).get();
      Menu MenuItemList = Menu.fromFirestoreDocument(menuDoc.docs[0].data()); //TODO: handle empty menus 
        




      return MenuItemList.foodItems!.where((element) => element.type == type).toList();
}
}
//order: [user_id:str, canteen_id: str, food_items: [name, qty], status: string (preparing)]
