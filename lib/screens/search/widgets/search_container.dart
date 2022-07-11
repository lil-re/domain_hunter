import 'dart:async';
import 'dart:convert';
import 'package:domain_hunter/models/domain.dart';
import 'package:domain_hunter/models/extension.dart';
import 'package:domain_hunter/utilities/types.dart';
import 'package:domain_hunter/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:domain_hunter/screens/search/widgets/input/search_input.dart';
import 'package:domain_hunter/screens/search/widgets/result/search_result_list.dart';
import 'package:domain_hunter/screens/search/widgets/settings/search_settings_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchContainer extends StatefulWidget {
  SearchContainer({Key? key}) : super(key: key);

  @override
  State<SearchContainer> createState() => SearchContainerState();
}

class SearchContainerState extends State<SearchContainer> {
  final List<String> defaultExtensions = [
    'com',
    'net',
    'org',
    'co',
    'io',
    'app'
  ];

  bool loading = false;
  Timer? debounce;
  String? search;
  List<Domain> domains = [];
  List<Extension> extensions = [];
  JsonData favorites = {};

  /*
  ** State
  */
  @override
  void initState() {
    super.initState();
    setFavoritesList();
    setExtensionList();
  }

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
  }

  void updateLoading() {
    setState(() {
      loading = !loading;
    });
  }

  /*
  ** Search
  */
  void updateLabel(String? value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        search = value;
        setDomainList();
      });
    });
  }

  /*
  ** Domains
  */
  void setDomainList() async {
    updateLoading();

    if (search != null && search!.isNotEmpty && extensions.isNotEmpty) {
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
    updateLoading();
  }

  Uri getApiUrl() {
    String tlds = extensions
        .where((Extension extension) => extension.selected)
        .map((Extension extension) => '%22${extension.extension}%22')
        .join(',');

    return Uri.parse(
      'https://domaintyper.com/API/DomainCheckAsync?domain=$search&tlds=[$tlds]',
    );
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
    List<Domain> domains = json.map((element) {
      Domain domain = Domain.fromJson(element);
      domain.selected = favorites.containsKey(domain.getDomainName());
      return domain;
    }).toList();
    domains.sort((a, b) => a.tld.compareTo(b.tld));
    return domains;
  }

  /*
  ** Extensions
  */
  Future setExtensionList() async {
    List<String> extensionsData = await getExtensionsData();
    String response = await rootBundle.loadString(
      'assets/json/domain_list.json',
    );
    List jsonData = json.decode(response);

    setState(() {
      extensions = getExtensionNames(jsonData, extensionsData);
    });
  }

  Future setDefaultExtensions() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save a list of strings to 'selected_extensions' key.
    await prefs.setStringList(
      'selected_extensions',
      defaultExtensions,
    );
  }

  Future<List<String>> getExtensionsData() async {
    // Obtain shared preferences.
    SharedPreferences instance = await SharedPreferences.getInstance();
    List<String>? extensions = instance.getStringList('selected_extensions');

    if (extensions == null || extensions.isEmpty) {
      setDefaultExtensions();
      return defaultExtensions;
    }
    return extensions;
  }

  List<Extension> getExtensionNames(
    List jsonData,
    List<String> extensionsData,
  ) {
    return jsonData.map((item) {
      Extension extension = Extension.fromJson(item);
      extension.selected = extensionsData.contains(extension.extension);
      return extension;
    }).toList();
  }

  /*
  ** Extensions
  */
  void setFavoritesList() async {
    // Obtain shared preferences.
    SharedPreferences instance = await SharedPreferences.getInstance();
    String stringData = instance.getString('selected_domains') ?? '{}';
    setState(() {
      favorites = jsonDecode(stringData);
    });
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
              SearchSettingsButton(
                onChanged: () {
                  setExtensionList();
                  setDomainList();
                },
                extensions: extensions,
              ),
            ],
          ),
        ),
        if (loading) CircularProgressIndicator(color: Colors.blue.shade800),
        if (!loading && domains.isEmpty) const WelcomeContainer(),
        if (!loading && domains.isNotEmpty) SearchResultList(domains: domains),
      ],
    );
  }
}
