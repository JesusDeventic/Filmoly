/// Modelo de usuario devuelto por la API de Filmoly (WordPress).
class FilmolyUser {
  int id;
  String username;
  String email;
  String displayName;
  List<String> roles;

  FilmolyUser({
    this.id = 0,
    this.username = '',
    this.email = '',
    this.displayName = '',
    List<String>? roles,
  }) : roles = roles ?? [];

  bool get isEmpty => id == 0 && username.isEmpty;

  factory FilmolyUser.fromJson(Map<String, dynamic> json) {
    final rolesRaw = json['roles'];
    final roles = rolesRaw is List
        ? (rolesRaw).map((e) => e.toString()).toList()
        : <String>[];
    return FilmolyUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      displayName: (json['display_name'] as String?) ?? '',
      roles: roles,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'display_name': displayName,
        'roles': roles,
      };
}
