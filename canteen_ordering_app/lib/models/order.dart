import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';

class CanteenOrder {
  String? orderId;
  int? tokenNumber;
  String? userId;
  String? canteenId;
  DateTime? creationTime;
  List<MapEntry<MenuItem, int>>? foodItems;
  String? status; //Placed, In Progress, Ready

  CanteenOrder({
    this.orderId,
    this.userId,
    this.tokenNumber,
    this.canteenId,
    this.foodItems,
    this.status,
    this.creationTime
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
      tokenNumber:data['token_number'] as int?,
      canteenId: data['canteen_id'] as String?,
      foodItems: foodItems,
      status: data['status'] as String?,
      creationTime: data['creation_time'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'canteen_id': canteenId,
      'token_number':tokenNumber,
      'food_items': foodItems?.map((e) => {
            'menu_item': e.key.toMap(),
            'quantity': e.value,
          }).toList(),
      'status': status,
      'creation_time': Timestamp.fromDate(creationTime!)
    };
  }
}
