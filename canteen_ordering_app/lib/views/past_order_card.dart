import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {

      final CanteenController cancon = Get.find<CanteenController>();
      final OrderController ordcon = Get.find<OrderController>();
      int orderIndex;

  OrderCard({
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {

    var time = DateFormat('MMMM d h:mm a');

     return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cancon.canteenMap[ordcon.pastOrders.value[orderIndex].canteenId]!.canteenName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time.format(ordcon.pastOrders.value[orderIndex].creationTime!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          Text(
              'Token No: ${ordcon.pastOrders.value[orderIndex].tokenNumber}', //orderID for now
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${ordcon.pastOrders.value[orderIndex].status}',
              style: TextStyle(
                color: _getStatusColor(ordcon.pastOrders.value[orderIndex].status),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' ₹${ordcon.pastOrders.value[orderIndex].foodItems!.fold(0,(acc,entry) => acc + (entry.key.price! * entry.value))}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Order Items:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ordcon.pastOrders.value[orderIndex].foodItems!.map( (item) {
                
                return Text('${item.key.name} X ${item.value}');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}