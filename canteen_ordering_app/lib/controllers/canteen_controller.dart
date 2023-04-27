import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_app/models/canteen.dart';

class CanteenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String,Canteen> canteenMap = {};
  String currentCanteenID = "";

  Future<List<Canteen>> getCanteens() async {

      final canteenCollection = _firestore.collection('canteens');
      final canteenDocuments = await canteenCollection.get();
      final canlist = canteenDocuments.docs
          .map((doc) => Canteen.fromFirestore(doc))
          .toList();
      
      for(Canteen canteens in canlist){
          canteenMap[canteens.canteenId!] = canteens;

      } 
      return canlist;
}
}
