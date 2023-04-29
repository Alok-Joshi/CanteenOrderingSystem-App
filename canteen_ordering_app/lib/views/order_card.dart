import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {

      final CanteenController cancon = Get.find<CanteenController>();
      final OrderController ordcon = Get.find<OrderController>();
      int orderIndex;

  OrderCard({
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${cancon.canteenMap[ordcon.activeOrders[orderIndex].canteenId]!.canteenName}', //orderID for now

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),Text(
              'Token No: ${ordcon.activeOrders[orderIndex].orderId}', //orderID for now
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${ordcon.activeOrders[orderIndex].status}',
              style: TextStyle(
                color: _getStatusColor(ordcon.activeOrders[orderIndex].status),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' ₹${0}', //TODO: write a method to get this detail later
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
              children: ordcon.activeOrders[orderIndex].foodItems!.map( (item) {
                
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
      case 'Placed':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Ready':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}