import 'package:domain_hunter/models/domain.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list_item_favorite.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list_item_status.dart';
import 'package:domain_hunter/widgets/custom_box_decoration.dart';
import 'package:flutter/material.dart';

class SearchResultListItem extends StatelessWidget {
  Domain domain;

  SearchResultListItem({
    Key? key,
    required this.domain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ObjectKey('search_result_list_item_gesture_detector'),
      onTap: () {},
      child: Container(
        decoration: customBoxDecoration(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchResultListItemStatus(status: domain.status),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                domain.getDomainName(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SearchResultListItemFavorite(
              domain: domain,
              onChanged: () {},
            ),
          ],
        ),
      ),
    );
  }
}
