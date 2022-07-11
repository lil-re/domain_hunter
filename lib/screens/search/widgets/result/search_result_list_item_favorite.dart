import 'dart:convert';
import 'package:domain_hunter/models/domain.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultListItemFavorite extends StatefulWidget {
  Domain domain;
  Function onChanged;

  SearchResultListItemFavorite({
    Key? key,
    required this.domain,
    required this.onChanged,
  });

  @override
  State<SearchResultListItemFavorite> createState() =>
      _SearchResultListItemFavoriteState();
}

class _SearchResultListItemFavoriteState
    extends State<SearchResultListItemFavorite> {
  late Domain domain;

  IconData icon = Icons.favorite_border;

  @override
  void initState() {
    domain = widget.domain;
    setIcon();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchResultListItemFavorite oldWidget) {
    super.didUpdateWidget(oldWidget);
    domain = widget.domain;
    setIcon();
  }

  void setIcon() {
    setState(() {
      icon = domain.selected ? Icons.favorite : Icons.favorite_border;
    });
  }

  void updateDomain() {
    setState(() {
      domain.selected = !domain.selected;
    });
  }

  Future saveDomain() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Try reading data from the 'items' key.
    String stringData = prefs.getString('selected_domains') ?? '{}';

    // Convert String into JsonData
    JsonData domains = jsonDecode(stringData);

    // Update selected domains
    domains.containsKey(domain.getDomainName())
        ? domains.remove(domain.getDomainName())
        : domains[domain.getDomainName()] = domain.toJson();

    // Save JSON string to 'selected_domains' key.
    await prefs.setString(
      'selected_domains',
      jsonEncode(domains),
    );
  }

  void onPressed() async {
    updateDomain();
    setIcon();
    await saveDomain();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.pink,
        size: 26,
      ),
    );
  }
}
