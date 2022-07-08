import 'package:domain_hunter/utilities/types.dart';

class Domain {
  String domain;
  String tld;
  bool status;

  Domain({
    required this.domain,
    required this.tld,
    required this.status,
  });

  factory Domain.fromJson(JsonData jsonData) {
    return Domain(
      domain: jsonData['domain'],
      tld: jsonData['tld'],
      status: jsonData['status'].toLowerCase() == 'true',
    );
  }

  String getDomainName() {
    return '$domain.$tld';
  }
}
