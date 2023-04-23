import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/models/canteen.dart';

class CanteenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentCanteenID = "";

  Future<List<Canteen>> getCanteens() async {

      final canteenCollection = _firestore.collection('canteens');
      final canteenDocuments = await canteenCollection.get();
      final canteenList = canteenDocuments.docs
          .map((doc) => Canteen.fromFirestore(doc))
          .toList();
      return canteenList;
}
}
