import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/views/menu_items_list.dart';
import 'package:canteen_ordering_app/views/canteen_cart.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  OrderController ordercon = Get.find<OrderController>();
  OrderController ordcon = Get.find<OrderController>();
  CanteenController cancon = Get.find<CanteenController>();
  List<Widget>? _children;
  
  int _currentIndex = 0;

  @override
  void initState() {

      _children = [ MenuItemList(itemType: 'F',), MenuItemList(itemType:'D'),];

      super.initState();
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(cancon.canteenMap[cancon.currentCanteenID]!.canteenName!),
      actions: [IconButton(icon: const Icon(Icons.shopping_cart),
                           onPressed: () {

                              if(!ordcon.cartEmpty()){ // TODO: replace this later by isCanteenSelected(): bool api

                                Get.to(CartWidget());

                              }
                              else
                              {
                                Get.snackbar("", "Cart is Empty");

                              }

                           }
                            
      )]
      ),

      body: _children![_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label:""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label:""
          ),
          
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
