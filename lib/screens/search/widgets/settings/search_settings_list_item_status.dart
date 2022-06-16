import 'package:domain_hunter/models/extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSettingsListItemStatus extends StatelessWidget {
  Extension item;
  IconData icon = Icons.star_border;
  Color color = Colors.blue;

  SearchSettingsListItemStatus({
    Key? key,
    required this.item,
  }) : super(key: key) {
    setIcon(item);
  }

  void setIcon(Extension item) {
    icon = item.selected ? Icons.star : Icons.star_border;
  }

  void onPressed() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'items' key.
    List<String> items = prefs.getStringList('selected_extensions') ?? [];
    // Save an list of strings to 'selected_domains' key.
    await prefs.setStringList(
      'selected_extensions',
      <String>[...items, item.extension],
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: 22,
      ),
    );
  }
}
