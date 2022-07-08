import 'dart:async';
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
  Timer? debounce;
  String? search;
  List<Domain> domains = [];

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
  }

  void updateLabel(String? value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        search = value;
        setDomainList();
      });
    });
  }

  void updateSettings() {
    // update settings
  }

  void setDomainList() async {
    if (search != null && search!.isNotEmpty) {
      Uri url = getApiUrl();
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String data = getDomainsData(response);
        List json = jsonDecode(data);
        setState(() {
          domains = getDomainNames(json);
        });
      }
    } else {
      setState(() {
        domains = [];
      });
    }
  }

  Uri getApiUrl() {
    return Uri.parse(
        'https://domaintyper.com/API/DomainCheckAsync?domain=$search&tlds=[%22com%22,%22net%22,%22org%22,%22fr%22]');
  }

  String getDomainsData(http.Response response) {
    RegExp regex = RegExp(r'(}{)');
    String body = response.body;
    Iterable<RegExpMatch> matches = regex.allMatches(body).toList().reversed;
    matches.forEach(
      (RegExpMatch match) {
        String left = body.substring(0, match.start + 1);
        String right = body.substring(match.end - 1, body.length);
        body = '$left,$right';
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
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              SearchInput(
                onChanged: updateLabel,
                value: search,
              ),
              SearchSettingsButton(
                selectedExtensions: widget.selectedExtensions,
                onChanged: updateSettings,
              ),
            ],
          ),
          SearchResultList(items: domains)
        ],
      ),
    );
  }
}
