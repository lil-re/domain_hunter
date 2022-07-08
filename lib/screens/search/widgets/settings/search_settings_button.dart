import 'dart:convert';
import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_dialog.dart';

class SearchSettingsButton extends StatelessWidget {
  Function onChanged;
  List<Extension> extensions;

  SearchSettingsButton({
    Key? key,
    required this.extensions,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          key: const ObjectKey('search_settings_container'),
          height: 60,
          width: 60,
          color: Colors.blue.shade100,
          child: IconButton(
            key: const ObjectKey('search_settings_button'),
            icon: const Icon(Icons.settings),
            color: Colors.blue.shade800,
            tooltip: 'Filters',
            iconSize: 30,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SearchSettingsDialog(
                    onChanged: onChanged,
                    extensions: extensions,
                    selectedDomains: const [],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
