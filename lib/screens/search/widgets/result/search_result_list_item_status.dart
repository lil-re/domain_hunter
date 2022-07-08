import 'package:flutter/material.dart';

class SearchResultListItemStatus extends StatelessWidget {
  bool status;
  IconData icon = Icons.check_circle;
  Color color = Colors.green;

  SearchResultListItemStatus({
    Key? key,
    required this.status,
  }) : super(key: key) {
    setIcon(status);
    setColor(status);
  }

  void setIcon(bool status) {
    icon = status ? Icons.check_circle : Icons.cancel;
  }

  void setColor(bool status) {
    color = status ? Colors.green : Colors.red;
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
