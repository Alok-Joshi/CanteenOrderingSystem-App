import 'package:canteen_ordering_app/views/canteen_menu_page.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanteenCard extends StatelessWidget {
  final String canteen_id;
  final String canteenName;
  final String canteenTimings;
  final bool isOpen;

  CanteenCard({
    required this.canteen_id,
    required this.canteenName,
    required this.canteenTimings,
    required this.isOpen,
  });

  void onTap(){


    if(isOpen){
    Get.find<CanteenController>().currentCanteenID = canteen_id;
    Get.put(OrderController());
    Get.to(BottomNavBarWidget());
    }
    else
    {

        Get.snackbar("Error", "Canteen is closed");

    }


  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                canteenName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                canteenTimings,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                isOpen ? "Open" : "Closed",
                style: TextStyle(
                  color: isOpen ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
