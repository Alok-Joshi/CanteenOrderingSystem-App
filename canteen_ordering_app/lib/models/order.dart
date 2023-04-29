import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
//TODO: Add a timestamp
class CanteenOrder {
  String? orderId;
  int? tokenNumber;
  String? userId;
  String? canteenId;
  List<MapEntry<MenuItem, int>>? foodItems;
  String? status; //Placed, In Progress, Ready

  CanteenOrder({
    this.orderId,
    this.userId,
    this.canteenId,
    this.foodItems,
    this.status,
  });

  factory CanteenOrder.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String,dynamic>> doc) {
    final data = doc.data();
    final List<MapEntry<MenuItem, int>> foodItems = (data['food_items'] as List<dynamic>)
        .map((e) => MapEntry<MenuItem, int>(
              MenuItem.fromMap(e['menu_item']),
              e['quantity'] as int,
            ))
        .toList();
    return CanteenOrder(
      orderId: doc.id,
      userId: data['user_id'] as String?,
      canteenId: data['canteen_id'] as String?,
      foodItems: foodItems,
      status: data['status'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'canteen_id': canteenId,
      'food_items': foodItems?.map((e) => {
            'menu_item': e.key.toMap(),
            'quantity': e.value,
          }).toList(),
      'status': status,
    };
  }
}
