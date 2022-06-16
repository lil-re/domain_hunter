import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchInput extends StatefulWidget {
  String? title;
  String? value;
  Function(String?) onChanged;

  SearchInput({
    Key? key,
    this.title,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  String? search;

  @override
  void didUpdateWidget(SearchInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    search = widget.value;
  }

  updateSearch(String? value) {
    setState(() {
      search = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        key: const ObjectKey('search_input'),
        initialValue: search,
        style: const TextStyle(fontSize: 16, height: 1),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          hintText: widget.title ?? AppLocalizations.of(context)!.search,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey.shade100,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue.shade100,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
