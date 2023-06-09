import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {

      final CanteenController cancon = Get.find<CanteenController>();
      int orderIndex;

  OrderCard({
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {

    var time = DateFormat("HH:mm");

    return GetX<OrderController>(
    builder:(ordcon){ return Card(
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
                      '${cancon.canteenMap[ordcon.activeOrders.value[orderIndex].canteenId]!.canteenName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time.format(ordcon.activeOrders.value[orderIndex].creationTime!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            
            Text(
              'Token No: ${ordcon.activeOrders.value[orderIndex].tokenNumber}', //orderID for now
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${ordcon.activeOrders.value[orderIndex].status}',
              style: TextStyle(
                color: _getStatusColor(ordcon.activeOrders.value[orderIndex].status),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' ₹${ordcon.getPrice(orderIndex)}', 
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
              children: ordcon.activeOrders.value[orderIndex].foodItems!.map( (item) {
                
                return Text('${item.key.name} X ${item.value}');
              }).toList(),
            ),
          ],
        ),
      ),
    );
    },
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