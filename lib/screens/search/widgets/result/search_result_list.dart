import 'package:domain_hunter/models/domain.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list_item.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatefulWidget {
  List<Domain> items;

  SearchResultList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
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
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 50,
        ),
        itemBuilder: (context, index) {
          return SearchResultListItem(item: widget.items[index]);
        },
      ),
    );
  }
}
