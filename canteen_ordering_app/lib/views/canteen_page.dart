import 'package:flutter/material.dart';

import 'canteen_card.dart';

class CanteenListPage extends StatelessWidget {
  final List<Map<String, dynamic>> canteens = [
    {
      'name': 'Canteen A',
      'timings': '8:00 AM - 8:00 PM',
      'isOpen': true,
    },
    {
      'name': 'Canteen B',
      'timings': '9:00 AM - 7:00 PM',
      'isOpen': false,
    },
    {
      'name': 'Canteen C',
      'timings': '10:00 AM - 6:00 PM',
      'isOpen': true,
    },
    {
      'name': 'Canteen D',
      'timings': '7:00 AM - 9:00 PM',
      'isOpen': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen List'),
      ),
      body: ListView.builder(
        itemCount: canteens.length,
        itemBuilder: (BuildContext context, int index) {
          final canteen = canteens[index];
          return CanteenCard(
            canteenName: canteen['name'],
            canteenTimings: canteen['timings'],
            isOpen: canteen['isOpen'],
          );
        },
      ),
    );
  }
}
