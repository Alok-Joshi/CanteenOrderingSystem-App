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
  Map<String,MapEntry<MenuItem,int>> cartTracker = {};
  List<MenuItem>? foodItems;
  List<MenuItem>? drinkItems;
  List<CanteenOrder>  activeOrders  = [];
  List<CanteenOrder>? pastOrders;

  Map<String, CanteenOrder> orderTracker = {};

  @override
  Future<List<CanteenOrder>> getActiveOrders() async {


      if(activeOrders.length > 0){ //implies there are orders

        return activeOrders;
        
      }


      var activeOrdersdb = await _firestore.collection("orders").where('user_id',isEqualTo: authcon.userFromFirebase.value!.uid).where('status',whereIn:["In Progress", "Placed", "Ready"]).get();

      activeOrders = activeOrdersdb.docs.map((doc) => CanteenOrder.fromDocumentSnapshot(doc)).toList();
      return activeOrders;



  }
  bool cartEmpty(){


      int totalCost = cartTracker.entries.fold(0, (acc,entry) => acc + entry.value.key.price! * entry.value.value);
      return totalCost == 0;


  }
  void onAddPressed(String? itemId){

      cartTracker[itemId!] = MapEntry(cartTracker[itemId]!.key, cartTracker[itemId]!.value+1);


  }

  void onRemovePressed(String? itemId){

      cartTracker[itemId!] = MapEntry(cartTracker[itemId]!.key, max(0,cartTracker[itemId]!.value-1));

  }
  int getQuantity(String? itemId){

     
      return cartTracker[itemId]!.value;

  }
  CanteenOrder getOrderObject(){

      var user_id = authcon.userFromFirebase.value!.uid;
      var canteen_id = canteencon.currentCanteenID;
      var status = "Placed";
      var foodItems = cartTracker.values.where((element) => element.value>0).toList();
  

      return CanteenOrder(userId: user_id, canteenId: canteen_id, status: status, foodItems: foodItems);


  }
  List<MapEntry<MenuItem,int>> getCartEntries(){

      var foodItems = cartTracker.values.where((element) => element.value>0).toList();
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
          cartTracker[item.id!] = MapEntry(item,0);
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
     //order placed successfully, now get the token
     //newOrder.tokenNumber = await _firestore.collection('tokens').where(order_id == newOrder.orderId) commenting this out for now, cloud function not implemented yet

     activeOrders!.add(newOrder);
     //get the current order
     clearState(); 

}
}