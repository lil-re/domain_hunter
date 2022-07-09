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
  List<Extension> selectedExtensions = [];
  List<Extension> availableExtensions = [];

  @override
  void initState() {
    super.initState();
    updateSearch();
  }

  void updateSearch([String? value]) {
    setState(() {
      currentSearch = value ?? '';
      selectedExtensions = widget.extensions
          .where(
            (Extension extension) =>
                extension.selected &&
                extension.extension.startsWith(currentSearch),
          )
          .toList();
      availableExtensions = widget.extensions
          .where(
            (Extension extension) =>
                !extension.selected &&
                extension.extension.startsWith(currentSearch),
          )
          .toList();

      selectedExtensions.sort((a, b) => a.extension.compareTo(b.extension));
      availableExtensions.sort((a, b) => a.extension.compareTo(b.extension));
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
                SearchSettingsList(
                  extensions: [
                    ...selectedExtensions,
                    ...availableExtensions,
                  ],
                  onChanged: () {
                    updateSearch();
                    widget.onChanged();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
