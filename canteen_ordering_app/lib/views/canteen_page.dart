import 'package:canteen_ordering_app/controllers/authentication_controller.dart';
import 'package:canteen_ordering_app/views/canteen_cart.dart';
import 'package:canteen_ordering_app/views/login_page.dart';
import 'package:canteen_ordering_app/views/past_order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_ordering_app/controllers/canteen_controller.dart';
import 'package:canteen_ordering_app/controllers/order_controller.dart';
import 'package:canteen_ordering_app/models/canteen.dart';
import 'package:canteen_ordering_app/views/active_order_page.dart';
import 'package:canteen_ordering_app/views/past_order_page.dart';
import 'canteen_card.dart';
import 'package:intl/intl.dart';

class CanteenListPage extends StatefulWidget {
  @override
  
  _CanteenListPageState createState() => _CanteenListPageState();
}

class _CanteenListPageState extends State<CanteenListPage> {
  final CanteenController _canteenController = Get.find<CanteenController>();
  final AuthenticationController authcon = Get.find<AuthenticationController>();
  late Future<List<Canteen>> _canteensFuture;
  List<Widget> _children = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _canteensFuture = _canteenController.getCanteens();
    Get.put(OrderController());

    _children =_children = [
            FutureBuilder(
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
      OrderListWidget()




];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Alok Joshi"), //TODO: replace by display name later (configure display name, authcon.userFromFirebase.value!.email
              accountEmail: Text(authcon.userFromFirebase.value!.email!),
              
              ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Past Orders'),
              onTap: () {
                Get.to(PastOrderPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Signout'),
              onTap: () async {

                await authcon.signOut();
                Get.offAll(LoginPage());
              },
            ),
            
            
          ],
        ),
      ),
      appBar: AppBar(
        
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Canteens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Active Orders',
          ),
        ],
        onTap: (int index){

            setState((){ _currentIndex = index;});

        }, 
      ),
    );
  }
}
