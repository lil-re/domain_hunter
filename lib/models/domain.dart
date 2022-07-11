import 'package:domain_hunter/utilities/types.dart';

class Domain {
  String domain;
  String tld;
  bool status;
  bool selected;

  Domain({
    required this.domain,
    required this.tld,
    required this.status,
    this.selected = false,
  });

  factory Domain.fromJson(JsonData jsonData) {
    return Domain(
      domain: jsonData['domain'],
      tld: jsonData['tld'],
      status: jsonData['status'].toLowerCase() == 'true',
    );
  }

  factory Domain.fromFavorite(JsonData jsonData) {
    return Domain(
      domain: jsonData['domain'],
      tld: jsonData['tld'],
      status: jsonData['status'],
      selected: jsonData['selected'],
    );
  }

  JsonData toJson() {
    return {
      'domain': domain,
      'tld': tld,
      'status': status,
      'selected': selected,
    };
  }

  String getDomainName() {
    return '$domain.$tld';
  }
}
