import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'past_order_card.dart';

class PastOrderPage extends StatelessWidget {
  final OrderController ordcon = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
   
      
      
          return Scaffold(

            
            appBar: AppBar(title: Text("Past Orders")),

            body:ListView.builder(
            itemCount: ordcon.pastOrders.value.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(              
               orderIndex: index
              );
            },
          )
          );
        }
}