import 'dart:convert';
import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_dialog.dart';

class SearchSettingsClose extends StatelessWidget {

  SearchSettingsClose({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 60,
          width: 60,
          color: Colors.blue.shade100,
          child: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.blue.shade800,
            tooltip: 'Filters',
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
