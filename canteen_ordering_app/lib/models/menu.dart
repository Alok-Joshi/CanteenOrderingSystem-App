import 'menu_item.dart';

class Menu {
  String? canteenId;
  List<MenuItem>? foodItems;

  Menu({
    required this.canteenId,
    required this.foodItems,
  });

  factory Menu.fromFirestoreDocument(Map<String, dynamic> firestoreDocument) {
    var canteenId = firestoreDocument['canteen_id'];
    var foodItems = (firestoreDocument['food_items'] as List)
        .map((item) => MenuItem.fromFirestoreDocument(item))
        .toList();
    

    return Menu(canteenId:canteenId, foodItems:foodItems);
  }

  Map<String, dynamic> toMap() {
    return {
      'canteen_id': canteenId,
      'food_items': foodItems!.map((item) => item.toMap()).toList(),
    };
  }
}
