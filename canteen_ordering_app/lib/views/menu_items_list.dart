import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'canteen_item_card.dart';

class MenuItemList extends StatelessWidget {
  final String? itemType;
  OrderController ordcon = Get.find<OrderController>();

  MenuItemList({required this.itemType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: ordcon.getMenuItems(itemType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final menuItems = snapshot.data!;

        return ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            final menuItem = menuItems[index];
            return MenuItemCard(
              menuItem: menuItem,
            );
          },
        );
      },
    );
  }

  
}

