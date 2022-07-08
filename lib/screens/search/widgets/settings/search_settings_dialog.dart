import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/screens/search/widgets/input/search_input.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_close.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_list.dart';
import 'package:flutter/material.dart';

class SearchSettingsDialog extends StatefulWidget {
  List<Extension> extensions = [];
  List selectedDomains;
  Function onChanged;

  SearchSettingsDialog({
    Key? key,
    required this.extensions,
    required this.selectedDomains,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchSettingsDialog> createState() => _SearchSettingsDialogState();
}

class _SearchSettingsDialogState extends State<SearchSettingsDialog> {
  String currentSearch = '';
  List<Extension> filteredExtensions = [];

  @override
  void initState() {
    filteredExtensions = widget.extensions;
    filteredExtensions.sort((a, b) => b.selected ? 1 : -1);
    super.initState();
  }

  void updateSearch(String? value) {
    setState(() {
      currentSearch = value ?? '';
      filteredExtensions = widget.extensions
          .where((item) => item.extension.startsWith(currentSearch))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const ObjectKey('product_search_filter_dialog'),
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 400,
              maxHeight: 700,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SearchInput(
                        onChanged: updateSearch,
                        value: currentSearch,
                      ),
                      SearchSettingsClose(),
                    ],
                  ),
                ),
                SearchSettingsList(extensions: filteredExtensions),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
