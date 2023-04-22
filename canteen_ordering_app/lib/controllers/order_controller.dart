import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final canteencon = Get.find<CanteenController>();
  Map<MenuItem,int>? cartTracker = {};

  void onAddPressed(MenuItem item){

      cartTracker![item] = (cartTracker![item] == null? 1 : cartTracker![item]! + 1); 

  }

  void onRemovePressed(MenuItem item){

      cartTracker![item] = (cartTracker![item] == null? -1: cartTracker![item]! - 1);

      if(cartTracker![item]! <= 0 ){

            cartTracker!.remove(item);


      }


  }

  Future<List<MenuItem>> getMenuItems(String type) async {

      final menusCollection = _firestore.collection('menus');
      final menuDoc = await menusCollection.where("canteen_id",isEqualTo: canteencon.currentCanteenID).get();
      final MenuItemList = menuDoc.docs.map((doc) => MenuItem.fromFirestoreDocument(doc.data())).toList();

      List<MenuItem> reqType = MenuItemList.where((item) => item.type == type).toList();
      return reqType;
}
}
