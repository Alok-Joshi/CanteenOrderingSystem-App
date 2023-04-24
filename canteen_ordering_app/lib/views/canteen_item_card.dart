import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:get/get.dart';

class MenuItemCard extends StatefulWidget {
  final MenuItem menuItem;
  int selectedQuantity = 0;
  OrderController ordcon = Get.find<OrderController>();

  MenuItemCard({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.menuItem.name!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '₹ ${widget.menuItem.price}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      widget.ordcon.onRemovePressed(widget.menuItem.id);
                    });
                  },
                ),
                Text(
                  '${widget.ordcon.getQuantity(widget.menuItem.id)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      widget.ordcon.onAddPressed(widget.menuItem.id);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

