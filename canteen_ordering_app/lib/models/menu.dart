import 'menu_item.dart';

class Menu {
  String? menuId;
  String? canteenId;
  List<MenuItem>? foodItems;

  Menu({
    required this.menuId,
    required this.canteenId,
    required this.foodItems,
  });

  Menu.fromFirestoreDocument(Map<String, dynamic> firestoreDocument) {
    menuId = firestoreDocument['menu_id'];
    canteenId = firestoreDocument['canteen_id'];
    foodItems = (firestoreDocument['food_items'] as List)
        .map((item) => MenuItem.fromFirestoreDocument(item))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'menu_id': menuId,
      'canteen_id': canteenId,
      'food_items': foodItems!.map((item) => item.toMap()).toList(),
    };
  }
}
