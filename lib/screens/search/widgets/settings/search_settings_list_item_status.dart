import 'package:domain_hunter/models/extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSettingsListItemStatus extends StatefulWidget {
  Extension extension;
  Function onChanged;

  SearchSettingsListItemStatus({
    Key? key,
    required this.extension,
    required this.onChanged,
  });

  @override
  State<SearchSettingsListItemStatus> createState() =>
      _SearchSettingsListItemStatusState();
}

class _SearchSettingsListItemStatusState
    extends State<SearchSettingsListItemStatus> {
  late Extension extension;

  IconData icon = Icons.star_border;

  @override
  void initState() {
    extension = widget.extension;
    setIcon();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchSettingsListItemStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
    extension = widget.extension;
    setIcon();
  }

  void setIcon() {
    setState(() {
      icon = extension.selected ? Icons.star : Icons.star_border;
    });
  }

  void updateExtension() {
    setState(() {
      extension.selected = !extension.selected;
    });
  }

  Future saveExtension() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Try reading data from the 'items' key.
    List<String> extensions = prefs.getStringList('selected_extensions') ?? [];

    // Update selected extensions
    int index = extensions.indexOf(extension.extension);
    index > -1
        ? extensions.removeAt(index)
        : extensions.add(extension.extension);

    // Save a list of strings to 'selected_domains' key.
    await prefs.setStringList(
      'selected_extensions',
      <String>[...extensions],
    );
  }

  void onPressed() async {
    updateExtension();
    setIcon();
    await saveExtension();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.blue,
        size: 22,
      ),
    );
  }
}
