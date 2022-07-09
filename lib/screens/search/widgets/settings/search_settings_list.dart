import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_list_item.dart';
import 'package:flutter/material.dart';

class SearchSettingsList extends StatefulWidget {
  List<Extension> extensions;
  Function onChanged;

  SearchSettingsList({
    Key? key,
    required this.extensions,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchSettingsList> createState() => _SearchSettingsListState();
}

class _SearchSettingsListState extends State<SearchSettingsList> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: widget.extensions.length,
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 50,
        ),
        itemBuilder: (context, index) {
          return SearchSettingsListItem(
            extension: widget.extensions[index],
            onChanged: widget.onChanged,
          );
        },
      ),
    );
  }
}
