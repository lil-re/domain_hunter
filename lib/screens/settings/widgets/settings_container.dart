import 'package:flutter/material.dart';
import 'package:domain_hunter/screens/settings/widgets/settings_option.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key}) : super(key: key);

  void removeData() {}

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
            onPressed: removeData,
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
