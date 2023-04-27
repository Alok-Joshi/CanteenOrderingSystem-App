import 'package:canteen_ordering_app/views/canteen_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/models/canteen.dart';
import 'canteen_card.dart';
import 'package:intl/intl.dart';

class CanteenListPage extends StatefulWidget {
  @override
  _CanteenListPageState createState() => _CanteenListPageState();
}

class _CanteenListPageState extends State<CanteenListPage> {
  final CanteenController _canteenController = Get.find<CanteenController>();
  late Future<List<Canteen>> _canteensFuture;

  @override
  void initState() {
    super.initState();
    _canteensFuture = _canteenController.getCanteens();
    Get.put(OrderController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen List'),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart),
                     tooltip: 'Open Cart',
                     onPressed: (){
                            if(!Get.find<OrderController>().cartEmpty()){

                                Get.to(CartWidget());

                            }
                            else
                            {
                                Get.snackbar("", "Cart is Empty");
                              
                            }
                     })
        ]
      ),
      body: FutureBuilder(
        future: _canteensFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Canteen>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a progress indicator if still waiting for data to load
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle any errors here
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show a message if there are no canteens to display
            return Center(
              child: Text('No canteens found.'),
            );
          } else {
            // Display the list of canteens using the CanteenCard widget
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final canteen = snapshot.data![index];

                return CanteenCard(
                  canteen_id: canteen.canteenId!,
                  canteenName: canteen.canteenName!,
                  canteenTimings:
                      '${DateFormat('h:mm a').format(canteen.canteenStartTime!)} - ${DateFormat('h:mm a').format(canteen.canteenEndTime!)}',
                  isOpen: canteen.isOpen!,
                );
              },
            );
          }
        },
      ),
    );
  }
}
