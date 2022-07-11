import 'dart:async';
import 'dart:convert';
import 'package:domain_hunter/models/domain.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:flutter/material.dart';
import 'package:domain_hunter/screens/search/widgets/input/search_input.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesContainer extends StatefulWidget {
  FavoritesContainer({Key? key}) : super(key: key);

  @override
  State<FavoritesContainer> createState() => FavoritesContainerState();
}

class FavoritesContainerState extends State<FavoritesContainer> {
  String? search;
  List<Domain> domains = [];
  List<Domain> favorites = [];

  /*
  ** State
  */
  @override
  void initState() {
    super.initState();
    setFavoritesList();
  }

  /*
  ** Search
  */
  void updateLabel(String? value) {
    setState(() {
      search = value;
      setDomainList(value ?? '');
    });
  }

  /*
  ** Domains
  */
  void setDomainList([String search = '']) {
    setState(() {
      domains = favorites
          .where((Domain element) => element.getDomainName().contains(search))
          .toList();
    });
  }

  /*
  ** Favorites
  */
  void setFavoritesList() async {
    // Obtain shared preferences.
    SharedPreferences instance = await SharedPreferences.getInstance();
    String stringData = instance.getString('selected_domains') ?? '{}';
    JsonData jsonData = jsonDecode(stringData);
    Iterable jsonValues = jsonData.values;
    setState(() {
      favorites = jsonValues
          .map((dynamic element) => Domain.fromFavorite(element))
          .toList();
    });
    setDomainList();
  }

  /*
  ** UI
  */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              SearchInput(
                onChanged: updateLabel,
                value: search,
              ),
            ],
          ),
        ),
        SearchResultList(domains: domains),
      ],
    );
  }
}
