import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration({
  double radius = 10,
  Color color = Colors.white,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: const Border.fromBorderSide(
      BorderSide(
        width: 1,
        color: Color(0xFFE6E6E6),
        style: BorderStyle.solid,
      ),
    ),
    boxShadow: [
      BoxShadow(
        spreadRadius: 10,
        blurRadius: 10,
        color: Colors.grey.withOpacity(0.1),
        offset: const Offset(10, 10), // changes position of shadow
      ),
    ],
  );
}
