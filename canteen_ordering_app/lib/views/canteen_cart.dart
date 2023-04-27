import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'package:canteen_ordering_app/models/order.dart';
import 'package:canteen_ordering_app/views/order_summary.dart';

class CartWidget extends StatefulWidget {
  OrderController ordcon = Get.find<OrderController>();
  AuthenticationController authcon = Get.find<AuthenticationController>();
  CanteenController cancon = Get.find<CanteenController>();

  CartWidget({Key? key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int _totalPrice = 0;


  void _updateTotalPrice() {
    
      _totalPrice = widget.ordcon.cartTracker.entries.fold(0, (acc,entry) => acc + entry.value.key.price! * entry.value.value);
  }

  @override
  void initState() {
    _updateTotalPrice();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    var itemlist = widget.ordcon.getCartEntries();
    return Scaffold(
    appBar: AppBar(title: Text(widget.cancon.canteenMap[widget.cancon.currentCanteenID]!.canteenName!)),
    body:Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: itemlist.length,
            itemBuilder: (BuildContext context, int index) {
              final item = itemlist[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(item.key.name!),
                  subtitle: Text('₹${item.key.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {setState(() {
                           widget.ordcon.onRemovePressed(item.key.id);
                          _updateTotalPrice();
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(item.value.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                             widget.ordcon.onAddPressed(item.key.id);
                            _updateTotalPrice();
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ₹$_totalPrice',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () async {
                  // TODO: Implement order functionality
                  await widget.ordcon.createOrder();
                  Get.off(OrderSummaryPage());
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ],
    )
    );
  }
}
