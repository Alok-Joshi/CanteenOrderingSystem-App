import 'package:canteen_ordering_app/controllers/order_controller.dart';
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
  Future<List<MenuItem>>? foodItems;
  Future<List<MenuItem>>? drinkItems;
  OrderController ordcon = Get.find<OrderController>();
  List<Widget>? _children;
  
  int _currentIndex = 0;

  @override
  void initState(){

      foodItems = ordercon.getMenuItems("F");
      drinkItems = ordercon.getMenuItems("D");
      _children = [ MenuItemList(menuItems: foodItems,),CartWidget(), ];
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children![_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
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
