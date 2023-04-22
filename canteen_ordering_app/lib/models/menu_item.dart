class MenuItem {
  String? name;
  String? type;
  int? price;

  MenuItem({
    required this.name,
    required this.type,
    required this.price,
  });

  MenuItem.fromFirestoreDocument(Map<String, dynamic> firestoreDocument) {
    name = firestoreDocument['name'];
    type = firestoreDocument['type'];
    price = firestoreDocument['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'price': price,
    };
  }
}
