import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list_item_status.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_list_item_status.dart';
import 'package:domain_hunter/widgets/custom_box_decoration.dart';
import 'package:flutter/material.dart';

class SearchSettingsListItem extends StatelessWidget {
  Extension extension;
  Function onChanged;

  SearchSettingsListItem({
    Key? key,
    required this.extension,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ObjectKey('search_settings_list_item_gesture_detector'),
      onTap: () {},
      child: Container(
        decoration: customBoxDecoration(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '.${extension.extension}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SearchSettingsListItemStatus(
              extension: extension,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
