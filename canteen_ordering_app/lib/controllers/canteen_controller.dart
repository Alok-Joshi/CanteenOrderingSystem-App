import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/models/canteen.dart';

class CanteenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Canteen>> getCanteens() async {
    try {
      final canteenCollection = _firestore.collection('canteen');
      final canteenDocuments = await canteenCollection.get();
      final canteenList = canteenDocuments.docs
          .map((doc) => Canteen.fromFirestore(doc))
          .toList();
      return canteenList;
    } catch (e) {
      // Handle any errors here
      print(e.toString());
    }
  }
}
