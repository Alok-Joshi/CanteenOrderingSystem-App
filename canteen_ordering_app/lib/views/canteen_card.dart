import 'package:flutter/material.dart';

class CanteenCard extends StatelessWidget {
  final String canteenName;
  final String canteenTimings;
  final bool isOpen;

  CanteenCard({required this.canteenName, required this.canteenTimings, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
    );
  }
}
