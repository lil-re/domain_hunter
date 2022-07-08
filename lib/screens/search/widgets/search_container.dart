import 'dart:convert';
import 'package:domain_hunter/models/domain.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:domain_hunter/screens/search/widgets/input/search_input.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchContainer extends StatefulWidget {
  List<String> selectedExtensions = [];

  SearchContainer({Key? key}) : super(key: key) {
    // Obtain shared preferences.
    SharedPreferences.getInstance().then((instance) {
      selectedExtensions = instance.getStringList('selected_extensions') ?? [];
    });
  }

  @override
  State<SearchContainer> createState() => SearchContainerState();
}

class SearchContainerState extends State<SearchContainer> {
  List<Domain> domains = [];
  String? currentSearch;

  @override
  void initState() {
    super.initState();
    getDomainList();
  }

  void updateLabel(String? value) {
    setState(() {
      currentSearch = value;
      fetchData();
    });
  }

  void updateSettings() {
    // update settings
  }

  void fetchData() {
    // Fetch assets
  }

  Uri getApiUrl() {
    return Uri.parse(
        'https://domaintyper.com/API/DomainCheckAsync?domain=coucou&tlds=[%22com%22,%22net%22,%22org%22,%22fr%22]');
  }

  void getDomainList() async {
    Uri url = getApiUrl();

    // Await the http get response, then decode the json-formatted response.
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = getDomainsData(response);
      List json = jsonDecode(data);
      domains = getDomainNames(json);
      print(domains);
    } else {
      print('Request failed');
    }
  }

  String getDomainsData(http.Response response) {
    RegExp regex = RegExp(r'(}{)');
    String body = response.body;
    regex.allMatches(body).toList().reversed.forEach(
      (RegExpMatch match) {
        body =
            '${body.substring(0, match.start + 1)},${body.substring(match.end - 1, body.length)}';
      },
    );
    return '[$body]';
  }

  List<Domain> getDomainNames(List json) {
    return json.map((element) => Domain.fromJson(element)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SearchInput(
                    onChanged: updateLabel,
                    value: currentSearch,
                  ),
                  SearchSettingsButton(
                    selectedExtensions: widget.selectedExtensions,
                    onChanged: updateSettings,
                  ),
                ],
              )),
          SearchResultList(items: domains.map((e) => ({})).toList())
        ],
      ),
    );
  }
}
