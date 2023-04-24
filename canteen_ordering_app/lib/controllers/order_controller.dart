import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:canteen_ordering_app/models/menu.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'dart:math';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final canteencon = Get.find<CanteenController>();
  final authcon = Get.find<AuthenticationController>();
  Map<String,MapEntry<MenuItem,int>>? cartTracker = {};
  List<MenuItem>? foodItems;
  List<MenuItem>? drinkItems;

  Map<String, CanteenOrder> orderTracker = {};
  String currentOrderID = "";

  void onAddPressed(String? itemId){

      cartTracker![itemId!] = MapEntry(cartTracker![itemId]!.key, cartTracker![itemId]!.value+1);


  }

  void onRemovePressed(String? itemId){

      cartTracker![itemId!] = MapEntry(cartTracker![itemId]!.key, max(0,cartTracker![itemId]!.value-1));

  }
  int getQuantity(String? itemId){

     
      return cartTracker![itemId]!.value;

  }
  CanteenOrder getOrderObject(){

      var user_id = authcon.userFromFirebase.value!.uid;
      var canteen_id = canteencon.currentCanteenID;
      var status = "placed";
      var foodItems = cartTracker!.values.where((element) => element.value>0).toList();
  

      return CanteenOrder(userId: user_id, canteenId: canteen_id, status: status, foodItems: foodItems);


  }
  List<MapEntry<MenuItem,int>> getCartEntries(){

      var foodItems = cartTracker!.values.where((element) => element.value>0).toList();
      return foodItems;



  }
  Future<List<MenuItem>>? getMenuItems(String? type) async {

      if(type == 'F' && foodItems != null){

        return Future.value(foodItems);
      }
      else if(type == 'D' && drinkItems != null){

        return Future.value(drinkItems);
      }

      final menusCollection =  _firestore.collection('menus');
      final menuDoc = await menusCollection.where("canteen_id",isEqualTo: canteencon.currentCanteenID).get();
      var canteenMenu = Menu.fromFirestoreDocument(menuDoc.docs[0].data()); //TODO: handle empty menus 

      var items =  canteenMenu.foodItems!.where((element) => element.type == type).toList();


      if(type == 'F'){
        foodItems =  items;

      }
      else
      {
        drinkItems =  items;
          
      }

      for( MenuItem item in items){
          cartTracker![item.id!] = MapEntry(item,0);
      }

      return Future.value(items);

}

void clearState(){
    //empty the order selection history.
    cartTracker = {};
    foodItems = null;
    drinkItems = null;

}
Future createOrder() async {

     CanteenOrder newOrder = getOrderObject();
     DocumentReference ref = await _firestore.collection('orders').add(newOrder.toMap());
     newOrder.orderId = ref.id;
     orderTracker[ref.id] = newOrder;
     currentOrderID = ref.id;
     clearState(); 

}
}
//order: [order_id, user_id:str, canteen_id: str, food_items: [{food_item: menu_item,qty:qty},], status: string (preparing/ready)]
//ActiveOrderPage: Order summary page which simply displays the order created above
//tracking the order: 