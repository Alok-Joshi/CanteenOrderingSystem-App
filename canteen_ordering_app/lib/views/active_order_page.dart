import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'order_card.dart';

class OrderListWidget extends StatelessWidget {
  final OrderController ordcon = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
   
      
      
          return ListView.builder(
            itemCount: ordcon.activeOrders.value.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(              
               orderIndex: index
              );
            },
          );
        }
}
