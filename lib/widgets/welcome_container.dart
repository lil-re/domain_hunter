import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Image(
          image: AssetImage('assets/images/cherry-house-hunter.png'),
          width: 200,
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.hunt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
