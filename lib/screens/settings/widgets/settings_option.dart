import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsOption extends StatelessWidget {
  String title;
  String text;
  String buttonLabel;
  String? buttonLink;
  Function? onPressed = () {};
  bool displayDivider = true;

  SettingsOption({
    Key? key,
    required this.title,
    required this.text,
    required this.buttonLabel,
    this.buttonLink,
    this.onPressed,
    this.displayDivider = true,
  }) : super(key: key);

  void onOptionPresed() async {
    if (buttonLink != null && buttonLink!.isNotEmpty) {
      Uri uri = Uri.parse(buttonLink!);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } else if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayDivider)
          Divider(
            color: Colors.grey.shade500,
          ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onOptionPresed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.blue.shade100,
            ),
            child: Text(
              buttonLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
