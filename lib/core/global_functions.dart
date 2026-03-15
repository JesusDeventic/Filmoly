import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/core/secure_storage.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

final _secureStorage = FilmolySecureStorage();

Future<void> loadAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  globalCurrentVersionApp = info.version;
}

void unFocusGlobal() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> logoutUser() async {
  await FilmolyApi.logoutAndClear();
}

/// Intenta restaurar sesión leyendo el token del secure storage y validándolo con /auth/me.
Future<bool> loginUser() async {
  final token = await _secureStorage.getToken();
  if (token == null || token.isEmpty) return false;
  final user = await FilmolyApi.validateToken(token);
  if (user == null) return false;
  globalUserToken = token;
  globalCurrentUser = user;
  return true;
}

/// Nombre del idioma según el locale actual (para el desplegable).
String getLanguageName(String code) {
  switch (code) {
    case 'ar':
      return S.current.languageArabic;
    case 'ca':
      return S.current.languageCatalan;
    case 'de':
      return S.current.languageGerman;
    case 'en':
      return S.current.languageEnglish;
    case 'es':
      return S.current.languageSpanish;
    case 'fr':
      return S.current.languageFrench;
    case 'hi':
      return S.current.languageHindi;
    case 'it':
      return S.current.languageItalian;
    case 'ja':
      return S.current.languageJapanese;
    case 'ko':
      return S.current.languageKorean;
    case 'nl':
      return S.current.languageDutch;
    case 'pl':
      return S.current.languagePolish;
    case 'pt':
      return S.current.languagePortuguese;
    case 'ro':
      return S.current.languageRomanian;
    case 'ru':
      return S.current.languageRussian;
    case 'sv':
      return S.current.languageSwedish;
    case 'tr':
      return S.current.languageTurkish;
    case 'uk':
      return S.current.languageUkrainian;
    case 'zh':
      return S.current.languageChinese;
    default:
      return code;
  }
}

/// Solo el nombre nativo (sin paréntesis), como en Fitcron.
String getNativeLanguageName(String code) {
  final fullName = getLanguageName(code);
  final idx = fullName.indexOf('(');
  if (idx != -1) return fullName.substring(0, idx).trim();
  return fullName;
}

/// Emoji de bandera por código de idioma, como en Fitcron.
String getLanguageFlag(String code) {
  switch (code) {
    case 'en':
      return '🇺🇸';
    case 'de':
      return '🇩🇪';
    case 'fr':
      return '🇫🇷';
    case 'it':
      return '🇮🇹';
    case 'pt':
      return '🇵🇹';
    case 'es':
      return '🇪🇸';
    case 'ca':
      return '🏴';
    case 'ar':
      return '🇸🇦';
    case 'zh':
      return '🇨🇳';
    case 'ja':
      return '🇯🇵';
    case 'ko':
      return '🇰🇷';
    case 'hi':
      return '🇮🇳';
    case 'tr':
      return '🇹🇷';
    case 'pl':
      return '🇵🇱';
    case 'ru':
      return '🇷🇺';
    case 'nl':
      return '🇳🇱';
    case 'ro':
      return '🇷🇴';
    case 'sv':
      return '🇸🇪';
    case 'uk':
      return '🇺🇦';
    default:
      return '🌐';
  }
}
