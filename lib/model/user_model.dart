/// Modelo de usuario devuelto por la API de Filmaniak (WordPress).
///
/// Coincide con la estructura de `filmaniak_get_full_user_data()` en `usuario.php`.
class FilmaniakUser {
  int id;
  String username;
  String email;
  String websiteUrl;
  String displayName;
  String firstName;
  String lastName;
  String registeredAt;
  String description;
  String avatarUrl;
  String language;
  String titleDisplayPreference;
  String dateFormat;
  String weekStart;
  String country;
  String birthdate;
  bool isRetrotecaUser;
  bool marketingConsent;
  String accountStatus;
  String lastLogin;
  String reviewStatus;
  String reviewPromptedAt;

  /// Comentarios aprobados (solo relleno típico en listado `/users`).
  int commentCount;

  FilmaniakUser({
    this.id = 0,
    this.username = '',
    this.email = '',
    this.websiteUrl = '',
    this.displayName = '',
    this.firstName = '',
    this.lastName = '',
    this.registeredAt = '',
    this.description = '',
    this.avatarUrl = '',
    this.language = 'en',
    this.titleDisplayPreference = 'localized',
    this.dateFormat = 'dd/MM/yyyy',
    this.weekStart = 'monday',
    this.country = '',
    this.birthdate = '',
    this.isRetrotecaUser = false,
    this.marketingConsent = false,
    this.accountStatus = 'active',
    this.lastLogin = '',
    this.reviewStatus = 'none',
    this.reviewPromptedAt = '',
    this.commentCount = 0,
  });

  bool get isEmpty => id == 0 && username.isEmpty;

  factory FilmaniakUser.fromJson(Map<String, dynamic> json) {
    return FilmaniakUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: (json['username'] as String?) ?? '',
      // El backend usa `user_email`; admitimos también `email` por compatibilidad.
      email: (json['user_email'] as String?) ??
          (json['email'] as String?) ??
          '',
      websiteUrl: (json['user_url'] as String?) ?? '',
      displayName: (json['display_name'] as String?) ?? '',
      firstName: (json['first_name'] as String?) ?? '',
      lastName: (json['last_name'] as String?) ?? '',
      registeredAt: (json['user_registered'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      avatarUrl: (json['avatar_url'] as String?) ?? '',
      language: (json['language'] as String?) ?? 'es',
      titleDisplayPreference:
          (json['title_display_preference'] as String?) ?? 'localized',
      dateFormat: (json['date_format'] as String?) ?? 'dd/MM/yyyy',
      weekStart: (json['start_day_week'] as String?) ?? 'monday',
      country: (json['country'] as String?) ?? '',
      birthdate: (json['birthdate'] as String?) ?? '',
      isRetrotecaUser: (json['filmaniak_retroteca_user'] as bool?) ?? false,
      marketingConsent: (json['marketing_consent'] as bool?) ?? false,
      accountStatus: (json['account_status'] as String?) ?? 'active',
      lastLogin: (json['filmaniak_last_login'] as String?) ?? '',
      reviewStatus:
          (json['filmaniak_review_status'] as String?) ?? 'none',
      reviewPromptedAt:
          (json['filmaniak_review_prompted_at'] as String?) ?? '',
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        // El endpoint /user/update espera `user_email`
        'user_email': email,
        'user_url': websiteUrl,
        'display_name': displayName,
        'first_name': firstName,
        'last_name': lastName,
        'description': description,
        'language': language,
        'title_display_preference': titleDisplayPreference,
        'date_format': dateFormat,
        'start_day_week': weekStart,
        'country': country,
        'birthdate': birthdate,
        'filmaniak_retroteca_user': isRetrotecaUser,
        'marketing_consent': marketingConsent,
      };
}
