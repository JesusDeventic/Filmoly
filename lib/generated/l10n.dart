// GENERATED CODE - DO NOT MODIFY BY HAND
// Flutter Intl / Filmoly l10n

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:filmoly/generated/intl/messages_all.dart';

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appName =>
      Intl.message('Filmoly', name: 'appName', desc: '', args: []);
  String get signIn =>
      Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  String get signUp =>
      Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  String get userOrEmail =>
      Intl.message('Username or email', name: 'userOrEmail', desc: '', args: []);
  String get password =>
      Intl.message('Password', name: 'password', desc: '', args: []);
  String get keepSession =>
      Intl.message('Keep me signed in', name: 'keepSession', desc: '', args: []);
  String get forgotPassword =>
      Intl.message('Forgot password?', name: 'forgotPassword', desc: '', args: []);
  String get username =>
      Intl.message('Username', name: 'username', desc: '', args: []);
  String get email =>
      Intl.message('Email', name: 'email', desc: '', args: []);
  String get confirmPassword =>
      Intl.message('Confirm password', name: 'confirmPassword', desc: '', args: []);
  String get displayName =>
      Intl.message('Display name (optional)', name: 'displayName', desc: '', args: []);
  String get sendCode =>
      Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  String get verificationCode =>
      Intl.message('Verification code (6 digits)', name: 'verificationCode', desc: '', args: []);
  String get newPassword =>
      Intl.message('New password', name: 'newPassword', desc: '', args: []);
  String get confirm =>
      Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  String get back =>
      Intl.message('Back', name: 'back', desc: '', args: []);
  String get theme =>
      Intl.message('Theme', name: 'theme', desc: '', args: []);
  String get language =>
      Intl.message('Language', name: 'language', desc: '', args: []);
  String get version =>
      Intl.message('Version', name: 'version', desc: '', args: []);
  String get currentAppVersionText =>
      Intl.message('Current version', name: 'currentAppVersionText', desc: '', args: []);
  String get close =>
      Intl.message('Close', name: 'close', desc: '', args: []);
  String get error =>
      Intl.message('Error', name: 'error', desc: '', args: []);
  String get success =>
      Intl.message('Success', name: 'success', desc: '', args: []);
  String get fieldRequired =>
      Intl.message('This field is required', name: 'fieldRequired', desc: '', args: []);
  String get invalidEmail =>
      Intl.message('Invalid email', name: 'invalidEmail', desc: '', args: []);
  String get passwordMinLength =>
      Intl.message('At least 8 characters', name: 'passwordMinLength', desc: '', args: []);
  String get passwordMismatch =>
      Intl.message('Passwords do not match', name: 'passwordMismatch', desc: '', args: []);
  String get usernameMinLength =>
      Intl.message('At least 3 characters', name: 'usernameMinLength', desc: '', args: []);
  String get code6Digits =>
      Intl.message('Code must be 6 digits', name: 'code6Digits', desc: '', args: []);
  String get welcome =>
      Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  String get codeSent =>
      Intl.message('If the account exists, a code has been sent to the email.', name: 'codeSent', desc: '', args: []);
  String get passwordChanged =>
      Intl.message('Password reset successfully.', name: 'passwordChanged', desc: '', args: []);
  String get logout =>
      Intl.message('Log out', name: 'logout', desc: '', args: []);
  String get appVersionChangeLogTitle =>
      Intl.message('Changelog', name: 'appVersionChangeLogTitle', desc: '', args: []);
  String get appVersion10Code =>
      Intl.message('v1.0.0', name: 'appVersion10Code', desc: '', args: []);
  String get appVersion10Description =>
      Intl.message('· Initial release of Filmoly.\n· Login, register and password recovery.\n· Connection with La Retroteca (WordPress).', name: 'appVersion10Description', desc: '', args: []);
  String get languageArabic =>
      Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  String get languageCatalan =>
      Intl.message('Catalan', name: 'languageCatalan', desc: '', args: []);
  String get languageChinese =>
      Intl.message('Chinese', name: 'languageChinese', desc: '', args: []);
  String get languageDutch =>
      Intl.message('Dutch', name: 'languageDutch', desc: '', args: []);
  String get languageEnglish =>
      Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  String get languageFrench =>
      Intl.message('French', name: 'languageFrench', desc: '', args: []);
  String get languageGerman =>
      Intl.message('German', name: 'languageGerman', desc: '', args: []);
  String get languageHindi =>
      Intl.message('Hindi', name: 'languageHindi', desc: '', args: []);
  String get languageItalian =>
      Intl.message('Italian', name: 'languageItalian', desc: '', args: []);
  String get languageJapanese =>
      Intl.message('Japanese', name: 'languageJapanese', desc: '', args: []);
  String get languageKorean =>
      Intl.message('Korean', name: 'languageKorean', desc: '', args: []);
  String get languagePolish =>
      Intl.message('Polish', name: 'languagePolish', desc: '', args: []);
  String get languagePortuguese =>
      Intl.message('Portuguese', name: 'languagePortuguese', desc: '', args: []);
  String get languageRomanian =>
      Intl.message('Romanian', name: 'languageRomanian', desc: '', args: []);
  String get languageRussian =>
      Intl.message('Russian', name: 'languageRussian', desc: '', args: []);
  String get languageSpanish =>
      Intl.message('Spanish', name: 'languageSpanish', desc: '', args: []);
  String get languageSwedish =>
      Intl.message('Swedish', name: 'languageSwedish', desc: '', args: []);
  String get languageTurkish =>
      Intl.message('Turkish', name: 'languageTurkish', desc: '', args: []);
  String get languageUkrainian =>
      Intl.message('Ukrainian', name: 'languageUkrainian', desc: '', args: []);
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  /// Inglés primero para fallback; resto en orden alfabético por clave.
  List<Locale> get supportedLocales => const <Locale>[
        Locale('en'),
        Locale('ar'),
        Locale('ca'),
        Locale('de'),
        Locale('es'),
        Locale('fr'),
        Locale('hi'),
        Locale('it'),
        Locale('ja'),
        Locale('ko'),
        Locale('nl'),
        Locale('pl'),
        Locale('pt'),
        Locale('ro'),
        Locale('ru'),
        Locale('sv'),
        Locale('tr'),
        Locale('uk'),
        Locale('zh'),
      ];

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
