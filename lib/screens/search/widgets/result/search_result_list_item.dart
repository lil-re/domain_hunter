import 'package:domain_hunter/screens/search/widgets/result/search_result_list_item_status.dart';
import 'package:domain_hunter/widgets/custom_box_decoration.dart';
import 'package:flutter/material.dart';

class SearchResultListItem extends StatelessWidget {
  Map item;

  SearchResultListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ObjectKey('search_result_list_item_gesture_detector'),
      onTap: () {},
      child: Container(
        decoration: customBoxDecoration(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'domain.name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SearchResultListItemStatus(status: '')
          ],
        ),
      ),
    );
  }
}
