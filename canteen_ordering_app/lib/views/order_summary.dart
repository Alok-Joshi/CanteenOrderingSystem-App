import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';

class OrderSummaryPage extends StatelessWidget {
  CanteenOrder order = Get.find<OrderController>().orderTracker[Get.find<OrderController>().activeOrders[0].orderId]!;

  OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Token: ${order.orderId}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            
            Text(
              'Food Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.foodItems!.length,
              itemBuilder: (context, index) {
                final foodItem = order.foodItems![index];
                return Text(
                  '${foodItem.value} x ${foodItem.key.name} = ₹${foodItem.key.price ! * foodItem.value}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Status: ${order.status}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
