import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:canteen_ordering_app/models/menu.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final canteencon = Get.find<CanteenController>();
  final authcon = Get.find<AuthenticationController>();
  Map<String,MapEntry<MenuItem,int>> cartTracker = {};
  List<MenuItem>? foodItems;
  List<MenuItem>? drinkItems;
  RxList<CanteenOrder> activeOrders = <CanteenOrder>[].obs;
  RxList<CanteenOrder> pastOrders = <CanteenOrder>[].obs;

  Map<String, CanteenOrder> orderTracker = {};

Future<int> findSmallestUnusedTokenNumber(String canteenId) async {
  int tokenNumber = 1;
  var querySnapshot = await _firestore
      .collection('orders')
      .where('canteen_id', isEqualTo: canteenId)
      .get();

  querySnapshot.docs.forEach((doc) {
    if (doc.data()['token_number']  == tokenNumber) {
      tokenNumber++;
    }
  });

  return tokenNumber;
}


 Stream<List<CanteenOrder>> pastOrderStream(){

    
    var pastOrdersStream =_firestore.collection("orders").where("user_id",isEqualTo:authcon.userFromFirebase.value!.uid).where("status", whereIn: ["Completed"]).snapshots().map((event){

        return event.docs.map((e) => CanteenOrder.fromDocumentSnapshot(e),).toList();

    }
    ,);

    return pastOrdersStream;


  }
  Stream<List<CanteenOrder>> orderStream(){

    
    var activeOrderStream =_firestore.collection("orders").where("user_id",isEqualTo:authcon.userFromFirebase.value!.uid).where("status", whereIn: ["In Progress","Placed","Ready"]).snapshots().map((event){

        return event.docs.map((e) => CanteenOrder.fromDocumentSnapshot(e),).toList();

    }
    ,);

    return activeOrderStream;


  }
  @override
  void onInit(){
    super.onInit();

    activeOrders.bindStream(orderStream());
    pastOrders.bindStream(pastOrderStream());

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
  Future<CanteenOrder> getOrderObject() async {

      var user_id = authcon.userFromFirebase.value!.uid;
      var canteen_id = canteencon.currentCanteenID;
      var status = "Placed";
      var foodItems = cartTracker.values.where((element) => element.value>0).toList();
      var token =  await findSmallestUnusedTokenNumber(canteen_id);
  

      return CanteenOrder(userId: user_id, tokenNumber: token, canteenId: canteen_id, status: status, foodItems: foodItems);


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

     CanteenOrder newOrder = await getOrderObject();
     DocumentReference ref = await _firestore.collection('orders').add(newOrder.toMap());
     newOrder.orderId = ref.id;
     orderTracker[ref.id] = newOrder;


     clearState(); 


}
}