class MenuItem {
  String? id;
  String? name;
  String? type;
  int? price;

  MenuItem({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
  });

  factory MenuItem.fromFirestoreDocument(Map<String, dynamic> firestoreDocument) {

    return MenuItem(id: firestoreDocument['id'],name:firestoreDocument['name'],type:firestoreDocument['type'],price:firestoreDocument['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'type': type,
      'price': price,
    };
  }
factory MenuItem.fromMap(Map<String, dynamic> map) {
  return MenuItem(
    id: map['id'] as String?,
    name: map['name'] as String?,
    type: map['type'] as String?,
    price: map['price'] as int?,
  );
}

}
