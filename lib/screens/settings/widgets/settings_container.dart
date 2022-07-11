import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:domain_hunter/screens/settings/widgets/settings_option.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key}) : super(key: key);

  Future resetExtensions() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save a list of strings to 'selected_extensions' key.
    await prefs.setStringList(
      'selected_extensions',
      <String>[],
    );
  }

  Future resetDomains() async {
    // Obtain shared preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save JSON string to 'selected_domains' key.
    await prefs.setString(
      'selected_domains',
      jsonEncode({}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SettingsOption(
            title: AppLocalizations.of(context)!.data,
            text: AppLocalizations.of(context)!.dataText,
            buttonLabel: AppLocalizations.of(context)!.dataButton,
            onPressed: () {
              resetExtensions();
              resetDomains();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blue.shade800,
                  content: Text(
                    AppLocalizations.of(context)!.dataDeleted,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
            displayDivider: false,
          ),
          SettingsOption(
            title: AppLocalizations.of(context)!.api,
            text: AppLocalizations.of(context)!.apiText,
            buttonLabel: AppLocalizations.of(context)!.apiButton,
            buttonLink: 'https://domaintyper.com',
          ),
          SettingsOption(
            title: AppLocalizations.of(context)!.sourceCode,
            text: AppLocalizations.of(context)!.sourceCodeText,
            buttonLabel: AppLocalizations.of(context)!.sourceCodeButton,
            buttonLink: 'https://github.com/lil-re/domain_hunter',
          ),
        ],
      ),
    );
  }
}
