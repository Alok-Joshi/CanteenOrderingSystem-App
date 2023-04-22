import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';

class CartWidget extends StatefulWidget {

  const CartWidget({Key? key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int _totalPrice = 0;
  OrderController ordcon = Get.find<OrderController>();


  void _updateTotalPrice() {
    
      _totalPrice = ordcon.cartTracker!.values.reduce((value,element) => value + element);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemlist = ordcon.cartTracker!.entries.toList();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: ordcon.cartTracker!.length,
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
                           ordcon.onRemovePressed(item.key);
                          _updateTotalPrice();
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(item.value.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                             ordcon.onAddPressed(item.key);
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
                onPressed: () {
                  // TODO: Implement order functionality
                  print('Order Placed!');
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
