import 'package:domain_hunter/utilities/types.dart';

class Extension {
  String extension;
  String name;
  bool selected;

  Extension({
    required this.extension,
    required this.name,
    this.selected = false,
  });

  factory Extension.fromJson(JsonData jsonData) {
    return Extension(
      extension: jsonData['extension'],
      name: jsonData['name'],
    );
  }
}
