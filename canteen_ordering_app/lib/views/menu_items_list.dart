import 'package:flutter/material.dart';
import 'package:canteen_ordering_app/models/menu_item.dart';
import 'canteen_item_card.dart';

class MenuItemList extends StatelessWidget {
  final Future<List<MenuItem>>? menuItems;

  MenuItemList({required this.menuItems});

  @override
  Widget build(BuildContext context) {
       return FutureBuilder(
        future: menuItems,
        builder: (BuildContext context, AsyncSnapshot<List<MenuItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a progress indicator if still waiting for data to load
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle any errors here
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show a message if there are no canteens to display
            print(snapshot.data);
            return Center(
              child: Text('No items found.'),
            );
          } else {
            // Display the list of canteens using the CanteenCard widget
            return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        final menuItem = snapshot.data![index];
        return MenuItemCard(
          menuItem: menuItem,
        );
      },
            );
  
        }
        }
       );
}
}
