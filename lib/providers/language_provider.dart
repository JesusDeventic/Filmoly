import 'package:filmoly/core/user_preferences.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  /// Por defecto inglés; en fallo de idioma o no soportado se usa inglés.
  static const String defaultLanguage = 'en';

  String _currentLanguage = defaultLanguage;
  String? _previousLanguage;

  String get currentLanguage => _currentLanguage;
  String? get previousLanguage => _previousLanguage;

  final UserPreferences _prefs = UserPreferences();

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final saved = await _prefs.getLanguage();
    if (saved != null && saved.isNotEmpty) {
      _currentLanguage = saved;
    } else {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      if (S.delegate.supportedLocales
          .any((locale) => locale.languageCode == systemLocale.languageCode)) {
        _currentLanguage = systemLocale.languageCode;
      } else {
        _currentLanguage = defaultLanguage;
      }
      await _prefs.setLanguage(_currentLanguage);
    }
    await _loadS(currentLanguage);
    notifyListeners();
  }

  Future<void> _loadS(String languageCode) async {
    try {
      await S.load(Locale(languageCode));
    } catch (_) {
      // En fallo, cargar inglés
      _currentLanguage = defaultLanguage;
      await _prefs.setLanguage(defaultLanguage);
      await S.load(const Locale('en'));
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (_currentLanguage != newLanguage) {
      _previousLanguage = _currentLanguage;
      _currentLanguage = newLanguage;
      await _prefs.setLanguage(newLanguage);
      try {
        await S.load(Locale(newLanguage));
      } catch (_) {
        _currentLanguage = defaultLanguage;
        await _prefs.setLanguage(defaultLanguage);
        await S.load(const Locale('en'));
      }
      notifyListeners();
    }
  }
}
