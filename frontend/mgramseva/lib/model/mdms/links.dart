class LinkResponse {
  final List<Links> links;

  const LinkResponse({
    required this.links,
  });

  factory LinkResponse.fromJson(Map<String, dynamic> json) => LinkResponse(
        links: (json['links'] as List<dynamic>)
            .map((item) => Links.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class Links {
  final String tenantID;
  final String dashboardURL;
  final int id;
  final bool isEnabled;
  final List<String> roles;

  const Links({
    required this.tenantID,
    required this.dashboardURL,
    required this.id,
    required this.isEnabled,
    required this.roles,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        tenantID: json['tenantID'] as String,
        dashboardURL: json['dashboardURL'] as String,
        id: json['id'] as int,
        isEnabled: json['isEnabled'] as bool,
        roles: (json['roles'] as List<dynamic>).cast<String>(),
      );
}