class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String libraryEntry = '/library/:id';
  static const String accountProfile = '/account-profile';
  static const String publicProfile = '/user/:username';
  static const String conversations = '/conversations';
  static const String chat = '/chat/:userId';

  static String publicProfileOf(String username) => '/user/$username';
  static String libraryEntryOf(int id) => '/library/$id';
  static String chatWith(int userId) => '/chat/$userId';
}
