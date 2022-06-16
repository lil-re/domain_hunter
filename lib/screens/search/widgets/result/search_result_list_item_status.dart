import 'package:flutter/material.dart';

class SearchResultListItemStatus extends StatelessWidget {
  String status;
  IconData icon = Icons.check_circle;
  Color color = Colors.green;

  SearchResultListItemStatus({
    Key? key,
    required this.status,
  }) : super(key: key) {
    setIcon(status);
    setColor(status);
  }

  void setIcon(String status) {
    // Set icon
  }

  void setColor(String status) {
    // Set color
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: 22,
    );
  }
}
