import 'package:cloud_firestore/cloud_firestore.dart';

class Canteen {
  final String? canteenId;
  final String? ownerId;
  final String? canteenName;
  final DateTime? canteenStartTime;
  final DateTime? canteenEndTime;
  final bool? isOpen;

  Canteen({
    required this.canteenId,
    required this.ownerId,
    required this.canteenName,
    required this.canteenStartTime,
    required this.canteenEndTime,
    required this.isOpen,
  });

  factory Canteen.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    final currentTime = DateTime.now();

    bool is_open = currentTime.isAfter(data['canteen_start_time'].toDate()) && currentTime.isAfter(data['canteen_end_time']);
    return Canteen(
      canteenId: documentSnapshot.id,
      ownerId: data['owner_id'],
      canteenName: data['canteen_name'],
      canteenStartTime: data['canteen_start_time'].toDate(),
      canteenEndTime: data['canteen_end_time'].toDate(),
      isOpen: is_open,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'canteen_id': canteenId,
      'owner_id': ownerId,
      'canteen_name': canteenName,
      'canteen_start_time': Timestamp.fromDate(canteenStartTime),
      'canteen_end_time': Timestamp.fromDate(canteenEndTime),
    };
  }
}
