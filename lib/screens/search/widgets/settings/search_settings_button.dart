import 'dart:convert';
import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_dialog.dart';

class SearchSettingsButton extends StatelessWidget {
  Function onChanged;
  List<String> selectedExtensions = [];
  List<Extension> availableDomains = [];

  SearchSettingsButton({
    Key? key,
    required this.onChanged,
    required this.selectedExtensions,
  }) : super(key: key)  {
    setAvailableDomains();
  }

  void setAvailableDomains() {
    rootBundle.loadString('assets/json/domain_list.json')
      .then((response) {
        List data = json.decode(response);
        availableDomains = data
            .map((item) {
              Extension extension = Extension.fromJson(item);
              extension.selected = selectedExtensions.contains(extension.extension);
              return extension;
            })
            .toList();
      });
  }

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
                    availableDomains: availableDomains,
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
