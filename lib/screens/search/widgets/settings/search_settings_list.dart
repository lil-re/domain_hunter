import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_list_item.dart';
import 'package:flutter/material.dart';

class SearchSettingsList extends StatefulWidget {
  List<Extension> items;

  SearchSettingsList({
    Key? key,
    required this.items,
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
        itemCount: widget.items.length,
        padding: const EdgeInsets.only(bottom: 50),
        itemBuilder: (context, index) {
          return SearchSettingsListItem(item: widget.items[index]);
        },
      ),
    );
  }
}
