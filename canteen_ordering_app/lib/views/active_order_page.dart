import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'order_card.dart';

class OrderListWidget extends StatelessWidget {
  final OrderController ordcon = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CanteenOrder>>(
      future: ordcon.getActiveOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No orders found.'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(              
               orderIndex: index
              );
            },
          );
        }
      },
    );
  }
}
