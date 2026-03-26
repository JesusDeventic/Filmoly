// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

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

  /// `Filmaniak`
  String get appName {
    return Intl.message('Filmaniak', name: 'appName', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Create account`
  String get signUp {
    return Intl.message('Create account', name: 'signUp', desc: '', args: []);
  }

  /// `Username or email`
  String get userOrEmail {
    return Intl.message(
      'Username or email',
      name: 'userOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Keep me signed in`
  String get keepSession {
    return Intl.message(
      'Keep me signed in',
      name: 'keepSession',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Display name (optional)`
  String get displayName {
    return Intl.message(
      'Display name (optional)',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `Verification code (6 digits)`
  String get verificationCode {
    return Intl.message(
      'Verification code (6 digits)',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light mode`
  String get themeLight {
    return Intl.message('Light mode', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark mode`
  String get themeDark {
    return Intl.message('Dark mode', name: 'themeDark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Current version`
  String get currentAppVersionText {
    return Intl.message(
      'Current version',
      name: 'currentAppVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Could not verify the captcha. Please try again.`
  String get recaptchaError {
    return Intl.message(
      'Could not verify the captcha. Please try again.',
      name: 'recaptchaError',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'At least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `At least 4 characters`
  String get usernameMinLength {
    return Intl.message(
      'At least 4 characters',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `I have read and accept the`
  String get registerTermsAndConditionsAccept {
    return Intl.message(
      'I have read and accept the',
      name: 'registerTermsAndConditionsAccept',
      desc: '',
      args: [],
    );
  }

  /// `I agree to receive promotions and marketing communications`
  String get registerMarketingConsentAccept {
    return Intl.message(
      'I agree to receive promotions and marketing communications',
      name: 'registerMarketingConsentAccept',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions and privacy policy`
  String get registerTermsAndConditionsError {
    return Intl.message(
      'You must accept the terms and conditions and privacy policy',
      name: 'registerTermsAndConditionsError',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get andLabel {
    return Intl.message('and', name: 'andLabel', desc: '', args: []);
  }

  /// `The code must be 6 digits`
  String get code6Digits {
    return Intl.message(
      'The code must be 6 digits',
      name: 'code6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `If the account exists, a code has been sent to your email.`
  String get codeSent {
    return Intl.message(
      'If the account exists, a code has been sent to your email.',
      name: 'codeSent',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully.`
  String get passwordChanged {
    return Intl.message(
      'Password reset successfully.',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Changelog`
  String get appVersionChangeLogTitle {
    return Intl.message(
      'Changelog',
      name: 'appVersionChangeLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `v1.0.0`
  String get appVersion10Code {
    return Intl.message('v1.0.0', name: 'appVersion10Code', desc: '', args: []);
  }

  /// `·Initial release of Filmaniak.`
  String get appVersion10Description {
    return Intl.message(
      '·Initial release of Filmaniak.',
      name: 'appVersion10Description',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  /// `Catalan`
  String get languageCatalan {
    return Intl.message('Catalan', name: 'languageCatalan', desc: '', args: []);
  }

  /// `Chinese`
  String get languageChinese {
    return Intl.message('Chinese', name: 'languageChinese', desc: '', args: []);
  }

  /// `Dutch`
  String get languageDutch {
    return Intl.message('Dutch', name: 'languageDutch', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `French`
  String get languageFrench {
    return Intl.message('French', name: 'languageFrench', desc: '', args: []);
  }

  /// `German`
  String get languageGerman {
    return Intl.message('German', name: 'languageGerman', desc: '', args: []);
  }

  /// `Hindi`
  String get languageHindi {
    return Intl.message('Hindi', name: 'languageHindi', desc: '', args: []);
  }

  /// `Indonesian`
  String get languageIndonesian {
    return Intl.message(
      'Indonesian',
      name: 'languageIndonesian',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get languageItalian {
    return Intl.message('Italian', name: 'languageItalian', desc: '', args: []);
  }

  /// `Japanese`
  String get languageJapanese {
    return Intl.message(
      'Japanese',
      name: 'languageJapanese',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get languageKorean {
    return Intl.message('Korean', name: 'languageKorean', desc: '', args: []);
  }

  /// `Polish`
  String get languagePolish {
    return Intl.message('Polish', name: 'languagePolish', desc: '', args: []);
  }

  /// `Portuguese`
  String get languagePortuguese {
    return Intl.message(
      'Portuguese',
      name: 'languagePortuguese',
      desc: '',
      args: [],
    );
  }

  /// `Romanian`
  String get languageRomanian {
    return Intl.message(
      'Romanian',
      name: 'languageRomanian',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get languageRussian {
    return Intl.message('Russian', name: 'languageRussian', desc: '', args: []);
  }

  /// `Spanish`
  String get languageSpanish {
    return Intl.message('Spanish', name: 'languageSpanish', desc: '', args: []);
  }

  /// `Swedish`
  String get languageSwedish {
    return Intl.message('Swedish', name: 'languageSwedish', desc: '', args: []);
  }

  /// `Turkish`
  String get languageTurkish {
    return Intl.message('Turkish', name: 'languageTurkish', desc: '', args: []);
  }

  /// `Ukrainian`
  String get languageUkrainian {
    return Intl.message(
      'Ukrainian',
      name: 'languageUkrainian',
      desc: '',
      args: [],
    );
  }

  /// `Private messages`
  String get privateMessages {
    return Intl.message(
      'Private messages',
      name: 'privateMessages',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsLabel {
    return Intl.message(
      'Notifications',
      name: 'notificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Push notifications`
  String get pushNotificationsLabel {
    return Intl.message(
      'Push notifications',
      name: 'pushNotificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `You have no notifications.`
  String get notificationsEmptyText {
    return Intl.message(
      'You have no notifications.',
      name: 'notificationsEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get buttonReloadNotifications {
    return Intl.message(
      'Reload',
      name: 'buttonReloadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllAsRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Mark all notifications as read?`
  String get notificationMarkAllAsk {
    return Intl.message(
      'Mark all notifications as read?',
      name: 'notificationMarkAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notification marked as read.`
  String get notificationMarkedRead {
    return Intl.message(
      'Notification marked as read.',
      name: 'notificationMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `All notifications marked as read.`
  String get notificationsAllMarkedRead {
    return Intl.message(
      'All notifications marked as read.',
      name: 'notificationsAllMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `Could not mark the notification as read.`
  String get notificationMarkReadError {
    return Intl.message(
      'Could not mark the notification as read.',
      name: 'notificationMarkReadError',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get deleteAllNotifications {
    return Intl.message(
      'Delete all notifications',
      name: 'deleteAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications?`
  String get notificationDeleteAllAsk {
    return Intl.message(
      'Delete all notifications?',
      name: 'notificationDeleteAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notifications deleted.`
  String get notificationsDeletedOk {
    return Intl.message(
      'Notifications deleted.',
      name: 'notificationsDeletedOk',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete notifications.`
  String get notificationsDeletedError {
    return Intl.message(
      'Could not delete notifications.',
      name: 'notificationsDeletedError',
      desc: '',
      args: [],
    );
  }

  /// `No more items.`
  String get noMoreRecords {
    return Intl.message(
      'No more items.',
      name: 'noMoreRecords',
      desc: '',
      args: [],
    );
  }

  /// `Device notification permissions`
  String get notificationsPermissionHint {
    return Intl.message(
      'Device notification permissions',
      name: 'notificationsPermissionHint',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get notificationsStatusOn {
    return Intl.message(
      'ON',
      name: 'notificationsStatusOn',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get notificationsStatusOff {
    return Intl.message(
      'OFF',
      name: 'notificationsStatusOff',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get notificationsPermissionOpenSettings {
    return Intl.message(
      'Open settings',
      name: 'notificationsPermissionOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications in the browser`
  String get notificationsWebSettingsTitle {
    return Intl.message(
      'Notifications in the browser',
      name: 'notificationsWebSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.`
  String get notificationsWebSettingsBody {
    return Intl.message(
      'For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.',
      name: 'notificationsWebSettingsBody',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsLabel {
    return Intl.message('Settings', name: 'settingsLabel', desc: '', args: []);
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved successfully.`
  String get generalSettingsSaveSuccess {
    return Intl.message(
      'Settings saved successfully.',
      name: 'generalSettingsSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not save settings. Check your connection and try again.`
  String get generalSettingsSaveErrorGeneric {
    return Intl.message(
      'Could not save settings. Check your connection and try again.',
      name: 'generalSettingsSaveErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Settings cannot be saved. Please sign in again.`
  String get generalSettingsSaveErrorSession {
    return Intl.message(
      'Settings cannot be saved. Please sign in again.',
      name: 'generalSettingsSaveErrorSession',
      desc: '',
      args: [],
    );
  }

  /// `Could not open system settings.`
  String get generalSettingsOpenSystemSettingsError {
    return Intl.message(
      'Could not open system settings.',
      name: 'generalSettingsOpenSystemSettingsError',
      desc: '',
      args: [],
    );
  }

  /// `Start of week`
  String get weekStart {
    return Intl.message('Start of week', name: 'weekStart', desc: '', args: []);
  }

  /// `Monday`
  String get weekStartMonday {
    return Intl.message('Monday', name: 'weekStartMonday', desc: '', args: []);
  }

  /// `Sunday`
  String get weekStartSunday {
    return Intl.message('Sunday', name: 'weekStartSunday', desc: '', args: []);
  }

  /// `Date format`
  String get dateFormat {
    return Intl.message('Date format', name: 'dateFormat', desc: '', args: []);
  }

  /// `View my profile`
  String get showMyProfile {
    return Intl.message(
      'View my profile',
      name: 'showMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Account settings`
  String get accountSettings {
    return Intl.message(
      'Account settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get userSectionFAQs {
    return Intl.message('FAQs', name: 'userSectionFAQs', desc: '', args: []);
  }

  /// `Contact`
  String get userSectionContact {
    return Intl.message(
      'Contact',
      name: 'userSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get userSectionSessionClose {
    return Intl.message(
      'Log out',
      name: 'userSectionSessionClose',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app`
  String get dialogCloseAppTitle {
    return Intl.message(
      'Exit the app',
      name: 'dialogCloseAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit the app?`
  String get dialogCloseAppContent {
    return Intl.message(
      'Are you sure you want to exit the app?',
      name: 'dialogCloseAppContent',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get buttonClose {
    return Intl.message('Close', name: 'buttonClose', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get dialogCloseSessionContent {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'dialogCloseSessionContent',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get actionNo {
    return Intl.message('No', name: 'actionNo', desc: '', args: []);
  }

  /// `Yes`
  String get actionYes {
    return Intl.message('Yes', name: 'actionYes', desc: '', args: []);
  }

  /// `Home`
  String get menuHome {
    return Intl.message('Home', name: 'menuHome', desc: '', args: []);
  }

  /// `Collapse`
  String get collapseMenu {
    return Intl.message('Collapse', name: 'collapseMenu', desc: '', args: []);
  }

  /// `Expand`
  String get expandMenu {
    return Intl.message('Expand', name: 'expandMenu', desc: '', args: []);
  }

  /// `Go to home`
  String get goToHome {
    return Intl.message('Go to home', name: 'goToHome', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Incorrect credentials`
  String get wrongCredentials {
    return Intl.message(
      'Incorrect credentials',
      name: 'wrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.\nPlease wait {seconds} seconds before trying again.`
  String loginCountdownMessage(Object seconds) {
    return Intl.message(
      'Incorrect username or password.\nPlease wait $seconds seconds before trying again.',
      name: 'loginCountdownMessage',
      desc: '',
      args: [seconds],
    );
  }

  /// `Registration error`
  String get registerError {
    return Intl.message(
      'Registration error',
      name: 'registerError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `Could not connect to the Filmaniak server.`
  String get dialogErrorServerConnection {
    return Intl.message(
      'Could not connect to the Filmaniak server.',
      name: 'dialogErrorServerConnection',
      desc: '',
      args: [],
    );
  }

  /// `A new version of Filmaniak is available.\nUpdate the app to continue.`
  String get dialogErrorAppVersion {
    return Intl.message(
      'A new version of Filmaniak is available.\nUpdate the app to continue.',
      name: 'dialogErrorAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `The app is currently under maintenance. Please try again later.`
  String get dialogErrorServerMaintenance {
    return Intl.message(
      'The app is currently under maintenance. Please try again later.',
      name: 'dialogErrorServerMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Available version`
  String get currentServerVersionText {
    return Intl.message(
      'Available version',
      name: 'currentServerVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get dialogWarningTitle {
    return Intl.message(
      'Attention',
      name: 'dialogWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save your changes?`
  String get dialogConfirmSave {
    return Intl.message(
      'Save your changes?',
      name: 'dialogConfirmSave',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Reach us through any of our channels and we will get back to you as soon as possible.`
  String get textUserSupportDescription {
    return Intl.message(
      'Need help? Reach us through any of our channels and we will get back to you as soon as possible.',
      name: 'textUserSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link.`
  String get socialWebError {
    return Intl.message(
      'Could not open the link.',
      name: 'socialWebError',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get socialWhatsappLabel {
    return Intl.message(
      'WhatsApp',
      name: 'socialWhatsappLabel',
      desc: '',
      args: [],
    );
  }

  /// `Could not open WhatsApp.`
  String get socialWhatsappError {
    return Intl.message(
      'Could not open WhatsApp.',
      name: 'socialWhatsappError',
      desc: '',
      args: [],
    );
  }

  /// `Social media`
  String get menuBarSectionSocial {
    return Intl.message(
      'Social media',
      name: 'menuBarSectionSocial',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on social media.`
  String get socialNetworksText {
    return Intl.message(
      'Follow us on social media.',
      name: 'socialNetworksText',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPoliciesLabel {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPoliciesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditionsLabel {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cookie policy`
  String get cookiePolicyLabel {
    return Intl.message(
      'Cookie policy',
      name: 'cookiePolicyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Legal notice`
  String get legalNoticeLabel {
    return Intl.message(
      'Legal notice',
      name: 'legalNoticeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get socialMailLabel {
    return Intl.message('Email', name: 'socialMailLabel', desc: '', args: []);
  }

  /// `Telegram`
  String get socialTelegramLabel {
    return Intl.message(
      'Telegram',
      name: 'socialTelegramLabel',
      desc: '',
      args: [],
    );
  }

  /// `Filmaniak contact`
  String get subjectSupport {
    return Intl.message(
      'Filmaniak contact',
      name: 'subjectSupport',
      desc: '',
      args: [],
    );
  }

  /// `What is Filmaniak?`
  String get faq1Question {
    return Intl.message(
      'What is Filmaniak?',
      name: 'faq1Question',
      desc: '',
      args: [],
    );
  }

  /// `It is an app with a database of films, series and other audiovisual content, with tools that let users interact with other members, create lists, add ratings and reviews, and more.`
  String get faq1Answer {
    return Intl.message(
      'It is an app with a database of films, series and other audiovisual content, with tools that let users interact with other members, create lists, add ratings and reviews, and more.',
      name: 'faq1Answer',
      desc: '',
      args: [],
    );
  }

  /// `Can I watch films and series?`
  String get faq2Question {
    return Intl.message(
      'Can I watch films and series?',
      name: 'faq2Question',
      desc: '',
      args: [],
    );
  }

  /// `No, Filmaniak is not a streaming app; it only works as a database with various features around that content.`
  String get faq2Answer {
    return Intl.message(
      'No, Filmaniak is not a streaming app; it only works as a database with various features around that content.',
      name: 'faq2Answer',
      desc: '',
      args: [],
    );
  }

  /// `How do I delete my account?`
  String get faq3Question {
    return Intl.message(
      'How do I delete my account?',
      name: 'faq3Question',
      desc: '',
      args: [],
    );
  }

  /// `You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.`
  String get faq3Answer {
    return Intl.message(
      'You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.',
      name: 'faq3Answer',
      desc: '',
      args: [],
    );
  }

  /// `Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.`
  String get errorAuthInvalidUsername {
    return Intl.message(
      'Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.',
      name: 'errorAuthInvalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `The email is not valid.`
  String get errorAuthInvalidEmail {
    return Intl.message(
      'The email is not valid.',
      name: 'errorAuthInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get errorAuthInvalidPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'errorAuthInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `That username is already taken.`
  String get errorAuthUsernameExists {
    return Intl.message(
      'That username is already taken.',
      name: 'errorAuthUsernameExists',
      desc: '',
      args: [],
    );
  }

  /// `That email is already registered.`
  String get errorAuthEmailExists {
    return Intl.message(
      'That email is already registered.',
      name: 'errorAuthEmailExists',
      desc: '',
      args: [],
    );
  }

  /// `Registration could not be completed. Please try again.`
  String get errorAuthRegisterFailed {
    return Intl.message(
      'Registration could not be completed. Please try again.',
      name: 'errorAuthRegisterFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not create a session. Please try again later.`
  String get errorAuthSessionFailed {
    return Intl.message(
      'Could not create a session. Please try again later.',
      name: 'errorAuthSessionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get errorAuthTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'errorAuthTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Required fields are missing.`
  String get errorAuthMissingFields {
    return Intl.message(
      'Required fields are missing.',
      name: 'errorAuthMissingFields',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.`
  String get errorAuthInvalidCredentials {
    return Intl.message(
      'Incorrect username or password.',
      name: 'errorAuthInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `You must enter a username or email.`
  String get errorAuthMissingLogin {
    return Intl.message(
      'You must enter a username or email.',
      name: 'errorAuthMissingLogin',
      desc: '',
      args: [],
    );
  }

  /// `The code is not valid.`
  String get errorAuthInvalidCode {
    return Intl.message(
      'The code is not valid.',
      name: 'errorAuthInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded the maximum number of attempts.`
  String get errorAuthTooManyAttempts {
    return Intl.message(
      'You have exceeded the maximum number of attempts.',
      name: 'errorAuthTooManyAttempts',
      desc: '',
      args: [],
    );
  }

  /// `The code has expired.`
  String get errorAuthExpiredCode {
    return Intl.message(
      'The code has expired.',
      name: 'errorAuthExpiredCode',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorAuthGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorAuthGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get errorAuthWrongPassword {
    return Intl.message(
      'Incorrect password.',
      name: 'errorAuthWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the account. Please try again.`
  String get errorAuthDeleteAccountFailed {
    return Intl.message(
      'Could not delete the account. Please try again.',
      name: 'errorAuthDeleteAccountFailed',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get userAvatar {
    return Intl.message('Avatar', name: 'userAvatar', desc: '', args: []);
  }

  /// `Remove avatar`
  String get buttonDeleteAvatar {
    return Intl.message(
      'Remove avatar',
      name: 'buttonDeleteAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get userDescription {
    return Intl.message('Bio', name: 'userDescription', desc: '', args: []);
  }

  /// `Email`
  String get userEmail {
    return Intl.message('Email', name: 'userEmail', desc: '', args: []);
  }

  /// `Country`
  String get textfieldUserCountryLabel {
    return Intl.message(
      'Country',
      name: 'textfieldUserCountryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get textfieldUserBirthdayLabel {
    return Intl.message(
      'Date of birth',
      name: 'textfieldUserBirthdayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get textfieldDisplayNameLabel {
    return Intl.message(
      'Display name',
      name: 'textfieldDisplayNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get textfieldMailEmpty {
    return Intl.message(
      'Email is required',
      name: 'textfieldMailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get textfieldMailError {
    return Intl.message(
      'Invalid email',
      name: 'textfieldMailError',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get userYears {
    return Intl.message('years old', name: 'userYears', desc: '', args: []);
  }

  /// `Delete account`
  String get buttonDeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'buttonDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.`
  String get dialogDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.',
      name: 'dialogDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get dialogDeleteAccountPassword {
    return Intl.message(
      'Password',
      name: 'dialogDeleteAccountPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully.`
  String get messageUpdateSuccess {
    return Intl.message(
      'Profile updated successfully.',
      name: 'messageUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not update profile.`
  String get messageUpdateError {
    return Intl.message(
      'Could not update profile.',
      name: 'messageUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get messageGeneralError {
    return Intl.message(
      'Something went wrong.',
      name: 'messageGeneralError',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get messageDeleteAccountSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'messageDeleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete account.`
  String get messageDeleteAccountError {
    return Intl.message(
      'Could not delete account.',
      name: 'messageDeleteAccountError',
      desc: '',
      args: [],
    );
  }

  /// `Could not process the image.`
  String get errorProcessingImage {
    return Intl.message(
      'Could not process the image.',
      name: 'errorProcessingImage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get buttonConfirm {
    return Intl.message('Confirm', name: 'buttonConfirm', desc: '', args: []);
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message('Cancel', name: 'buttonCancel', desc: '', args: []);
  }

  /// `You have no conversations yet.`
  String get messagesEmpty {
    return Intl.message(
      'You have no conversations yet.',
      name: 'messagesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet. Say something!`
  String get messagesNoMessages {
    return Intl.message(
      'No messages yet. Say something!',
      name: 'messagesNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `Message deleted`
  String get messagesDeleted {
    return Intl.message(
      'Message deleted',
      name: 'messagesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `edited`
  String get messagesEdited {
    return Intl.message('edited', name: 'messagesEdited', desc: '', args: []);
  }

  /// `Write a message...`
  String get messagesTypeHint {
    return Intl.message(
      'Write a message...',
      name: 'messagesTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get messagesSend {
    return Intl.message('Send', name: 'messagesSend', desc: '', args: []);
  }

  /// `Edit`
  String get messagesEdit {
    return Intl.message('Edit', name: 'messagesEdit', desc: '', args: []);
  }

  /// `Delete`
  String get messagesDelete {
    return Intl.message('Delete', name: 'messagesDelete', desc: '', args: []);
  }

  /// `Delete this message?`
  String get messagesDeleteConfirm {
    return Intl.message(
      'Delete this message?',
      name: 'messagesDeleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get messagesRead {
    return Intl.message('Read', name: 'messagesRead', desc: '', args: []);
  }

  /// `Sent`
  String get messagesSent {
    return Intl.message('Sent', name: 'messagesSent', desc: '', args: []);
  }

  /// `Could not send the message.`
  String get messagesErrorSend {
    return Intl.message(
      'Could not send the message.',
      name: 'messagesErrorSend',
      desc: '',
      args: [],
    );
  }

  /// `Could not edit the message.`
  String get messagesErrorEdit {
    return Intl.message(
      'Could not edit the message.',
      name: 'messagesErrorEdit',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the message.`
  String get messagesErrorDelete {
    return Intl.message(
      'Could not delete the message.',
      name: 'messagesErrorDelete',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get buttonChangePassword {
    return Intl.message(
      'Change password',
      name: 'buttonChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully.`
  String get messageChangePasswordSuccess {
    return Intl.message(
      'Password changed successfully.',
      name: 'messageChangePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `User profile`
  String get publicProfileAppBarTitle {
    return Intl.message(
      'User profile',
      name: 'publicProfileAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `We could not find this user.`
  String get userNotFoundPublicProfileText {
    return Intl.message(
      'We could not find this user.',
      name: 'userNotFoundPublicProfileText',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryPublicProfile {
    return Intl.message(
      'Retry',
      name: 'retryPublicProfile',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get sendMessageTooltip {
    return Intl.message(
      'Send message',
      name: 'sendMessageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get shareTooltip {
    return Intl.message('Share', name: 'shareTooltip', desc: '', args: []);
  }

  /// `Copy link`
  String get copyProfileLink {
    return Intl.message(
      'Copy link',
      name: 'copyProfileLink',
      desc: '',
      args: [],
    );
  }

  /// `Link copied`
  String get copiedProfileLinkSnackbar {
    return Intl.message(
      'Link copied',
      name: 'copiedProfileLinkSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Show QR`
  String get showQrOption {
    return Intl.message('Show QR', name: 'showQrOption', desc: '', args: []);
  }

  /// `Share`
  String get shareOption {
    return Intl.message('Share', name: 'shareOption', desc: '', args: []);
  }

  /// `QR for @{username}`
  String qrTitle(Object username) {
    return Intl.message(
      'QR for @$username',
      name: 'qrTitle',
      desc: '',
      args: [username],
    );
  }

  /// `Profile of @{username} on Filmaniak`
  String profileShareSubject(Object username) {
    return Intl.message(
      'Profile of @$username on Filmaniak',
      name: 'profileShareSubject',
      desc: '',
      args: [username],
    );
  }

  /// `Last seen`
  String get lastAccessChipPrefix {
    return Intl.message(
      'Last seen',
      name: 'lastAccessChipPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusLabel {
    return Intl.message('Status', name: 'statusLabel', desc: '', args: []);
  }

  /// `Bio`
  String get bioLabel {
    return Intl.message('Bio', name: 'bioLabel', desc: '', args: []);
  }

  /// `Website / blog`
  String get webBlogLabel {
    return Intl.message(
      'Website / blog',
      name: 'webBlogLabel',
      desc: '',
      args: [],
    );
  }

  /// `https://yoursite.com`
  String get webBlogHint {
    return Intl.message(
      'https://yoursite.com',
      name: 'webBlogHint',
      desc: '',
      args: [],
    );
  }

  /// `Remove country`
  String get removeCountryTooltip {
    return Intl.message(
      'Remove country',
      name: 'removeCountryTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remove date`
  String get removeBirthdateTooltip {
    return Intl.message(
      'Remove date',
      name: 'removeBirthdateTooltip',
      desc: '',
      args: [],
    );
  }

  /// `No se ha podido completar la operación. Inténtalo más tarde.`
  String get errorApiGeneric {
    return Intl.message(
      'No se ha podido completar la operación. Inténtalo más tarde.',
      name: 'errorApiGeneric',
      desc: '',
      args: [],
    );
  }

  /// `No se ha podido conectar con el servidor. Revisa tu conexión o inténtalo más tarde.`
  String get errorApiNetwork {
    return Intl.message(
      'No se ha podido conectar con el servidor. Revisa tu conexión o inténtalo más tarde.',
      name: 'errorApiNetwork',
      desc: '',
      args: [],
    );
  }

  /// `No se ha podido completar la operación. Inténtalo más tarde.`
  String get errorApiEndpointUnavailable {
    return Intl.message(
      'No se ha podido completar la operación. Inténtalo más tarde.',
      name: 'errorApiEndpointUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Sesión no válida. Vuelve a iniciar sesión.`
  String get errorApiUnauthorized {
    return Intl.message(
      'Sesión no válida. Vuelve a iniciar sesión.',
      name: 'errorApiUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `No tienes permiso para hacer esto`
  String get errorApiForbidden {
    return Intl.message(
      'No tienes permiso para hacer esto',
      name: 'errorApiForbidden',
      desc: '',
      args: [],
    );
  }

  /// `No hemos encontrado lo que buscas`
  String get errorApiNotFound {
    return Intl.message(
      'No hemos encontrado lo que buscas',
      name: 'errorApiNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Ha ocurrido un error en el servidor. Inténtalo más tarde.`
  String get errorApiServer {
    return Intl.message(
      'Ha ocurrido un error en el servidor. Inténtalo más tarde.',
      name: 'errorApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Los datos enviados no son válidos`
  String get errorApiBadRequest {
    return Intl.message(
      'Los datos enviados no son válidos',
      name: 'errorApiBadRequest',
      desc: '',
      args: [],
    );
  }

  /// `Sesión no válida. Inicia sesión de nuevo.`
  String get errorApiSession {
    return Intl.message(
      'Sesión no válida. Inicia sesión de nuevo.',
      name: 'errorApiSession',
      desc: '',
      args: [],
    );
  }

  /// `Filtros`
  String get filtersTitle {
    return Intl.message('Filtros', name: 'filtersTitle', desc: '', args: []);
  }

  /// `Ordenar por`
  String get sortByLabel {
    return Intl.message('Ordenar por', name: 'sortByLabel', desc: '', args: []);
  }

  /// `Nombre (A-Z)`
  String get membersSortNameAsc {
    return Intl.message(
      'Nombre (A-Z)',
      name: 'membersSortNameAsc',
      desc: '',
      args: [],
    );
  }

  /// `Nombre (Z-A)`
  String get membersSortNameDesc {
    return Intl.message(
      'Nombre (Z-A)',
      name: 'membersSortNameDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edad (Ascendente)`
  String get membersSortAgeAsc {
    return Intl.message(
      'Edad (Ascendente)',
      name: 'membersSortAgeAsc',
      desc: '',
      args: [],
    );
  }

  /// `Edad (Descendente)`
  String get membersSortAgeDesc {
    return Intl.message(
      'Edad (Descendente)',
      name: 'membersSortAgeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Registro (más antiguo primero)`
  String get membersSortRegisteredAsc {
    return Intl.message(
      'Registro (más antiguo primero)',
      name: 'membersSortRegisteredAsc',
      desc: '',
      args: [],
    );
  }

  /// `Registro (más reciente primero)`
  String get membersSortRegisteredDesc {
    return Intl.message(
      'Registro (más reciente primero)',
      name: 'membersSortRegisteredDesc',
      desc: '',
      args: [],
    );
  }

  /// `Todos`
  String get allLabel {
    return Intl.message('Todos', name: 'allLabel', desc: '', args: []);
  }

  /// `Buscar miembro...`
  String get membersSearchHint {
    return Intl.message(
      'Buscar miembro...',
      name: 'membersSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Aplicar búsqueda`
  String get membersSearchApplyTooltip {
    return Intl.message(
      'Aplicar búsqueda',
      name: 'membersSearchApplyTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Miembros`
  String get membersLabel {
    return Intl.message('Miembros', name: 'membersLabel', desc: '', args: []);
  }

  /// `No se pudo cargar el directorio`
  String get membersErrorLoadTitle {
    return Intl.message(
      'No se pudo cargar el directorio',
      name: 'membersErrorLoadTitle',
      desc: '',
      args: [],
    );
  }

  /// `No hay miembros`
  String get membersEmptyTitle {
    return Intl.message(
      'No hay miembros',
      name: 'membersEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prueba con otra búsqueda o filtros`
  String get membersEmptySubtitle {
    return Intl.message(
      'Prueba con otra búsqueda o filtros',
      name: 'membersEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Restablecer`
  String get filterResetLabel {
    return Intl.message(
      'Restablecer',
      name: 'filterResetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Aplicar`
  String get filterApplyLabel {
    return Intl.message(
      'Aplicar',
      name: 'filterApplyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Conecta con otros usuarios`
  String get membersHomeCardSubtitle {
    return Intl.message(
      'Conecta con otros usuarios',
      name: 'membersHomeCardSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Lista`
  String get viewListLabel {
    return Intl.message('Lista', name: 'viewListLabel', desc: '', args: []);
  }

  /// `Cuadrícula`
  String get viewGridLabel {
    return Intl.message(
      'Cuadrícula',
      name: 'viewGridLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reseñas`
  String get reviewsLabel {
    return Intl.message('Reseñas', name: 'reviewsLabel', desc: '', args: []);
  }

  /// `Actividad`
  String get menuActivity {
    return Intl.message('Actividad', name: 'menuActivity', desc: '', args: []);
  }

  /// `Biblioteca`
  String get menuLibrary {
    return Intl.message('Biblioteca', name: 'menuLibrary', desc: '', args: []);
  }

  /// `Cuadrícula compacta`
  String get libraryLayoutCompact {
    return Intl.message(
      'Cuadrícula compacta',
      name: 'libraryLayoutCompact',
      desc: '',
      args: [],
    );
  }

  /// `Cuadrícula amplia`
  String get libraryLayoutComfortable {
    return Intl.message(
      'Cuadrícula amplia',
      name: 'libraryLayoutComfortable',
      desc: '',
      args: [],
    );
  }

  /// `Listado`
  String get libraryLayoutList {
    return Intl.message(
      'Listado',
      name: 'libraryLayoutList',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo cargar la biblioteca`
  String get libraryErrorLoad {
    return Intl.message(
      'No se pudo cargar la biblioteca',
      name: 'libraryErrorLoad',
      desc: '',
      args: [],
    );
  }

  /// `No hay resultados con estos filtros`
  String get libraryEmpty {
    return Intl.message(
      'No hay resultados con estos filtros',
      name: 'libraryEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Prueba a cambiar filtros o la búsqueda`
  String get libraryEmptySubtitle {
    return Intl.message(
      'Prueba a cambiar filtros o la búsqueda',
      name: 'libraryEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} resultados`
  String libraryResultsTotal(Object count) {
    return Intl.message(
      '$count resultados',
      name: 'libraryResultsTotal',
      desc: '',
      args: [count],
    );
  }

  /// `Texto a buscar`
  String get searchPlaceholder {
    return Intl.message(
      'Texto a buscar',
      name: 'searchPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Buscar en`
  String get librarySearchFieldLabel {
    return Intl.message(
      'Buscar en',
      name: 'librarySearchFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Publicación (más reciente)`
  String get libraryOrderDate {
    return Intl.message(
      'Publicación (más reciente)',
      name: 'libraryOrderDate',
      desc: '',
      args: [],
    );
  }

  /// `Publicación (más antigua)`
  String get libraryOrderDateAsc {
    return Intl.message(
      'Publicación (más antigua)',
      name: 'libraryOrderDateAsc',
      desc: '',
      args: [],
    );
  }

  /// `Modificación (más reciente)`
  String get libraryOrderModified {
    return Intl.message(
      'Modificación (más reciente)',
      name: 'libraryOrderModified',
      desc: '',
      args: [],
    );
  }

  /// `Modificación (más antigua)`
  String get libraryOrderModifiedAsc {
    return Intl.message(
      'Modificación (más antigua)',
      name: 'libraryOrderModifiedAsc',
      desc: '',
      args: [],
    );
  }

  /// `Título (A-Z)`
  String get libraryOrderTitle {
    return Intl.message(
      'Título (A-Z)',
      name: 'libraryOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Título (Z-A)`
  String get libraryOrderTitleDesc {
    return Intl.message(
      'Título (Z-A)',
      name: 'libraryOrderTitleDesc',
      desc: '',
      args: [],
    );
  }

  /// `Año (ascendente)`
  String get libraryOrderYearAsc {
    return Intl.message(
      'Año (ascendente)',
      name: 'libraryOrderYearAsc',
      desc: '',
      args: [],
    );
  }

  /// `Año (descendente)`
  String get libraryOrderYearDesc {
    return Intl.message(
      'Año (descendente)',
      name: 'libraryOrderYearDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mejor valoradas`
  String get libraryOrderRatingDesc {
    return Intl.message(
      'Mejor valoradas',
      name: 'libraryOrderRatingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Peor valoradas`
  String get libraryOrderRatingAsc {
    return Intl.message(
      'Peor valoradas',
      name: 'libraryOrderRatingAsc',
      desc: '',
      args: [],
    );
  }

  /// `Más valoraciones`
  String get libraryOrderRatingCount {
    return Intl.message(
      'Más valoraciones',
      name: 'libraryOrderRatingCount',
      desc: '',
      args: [],
    );
  }

  /// `Título`
  String get librarySearchTitle {
    return Intl.message(
      'Título',
      name: 'librarySearchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dirección`
  String get librarySearchDirector {
    return Intl.message(
      'Dirección',
      name: 'librarySearchDirector',
      desc: '',
      args: [],
    );
  }

  /// `Reparto`
  String get librarySearchCast {
    return Intl.message(
      'Reparto',
      name: 'librarySearchCast',
      desc: '',
      args: [],
    );
  }

  /// `Productora`
  String get librarySearchStudio {
    return Intl.message(
      'Productora',
      name: 'librarySearchStudio',
      desc: '',
      args: [],
    );
  }

  /// `Guión / Música / Fotografía`
  String get librarySearchCrew {
    return Intl.message(
      'Guión / Música / Fotografía',
      name: 'librarySearchCrew',
      desc: '',
      args: [],
    );
  }

  /// `TMDB ID`
  String get librarySearchTmdb {
    return Intl.message(
      'TMDB ID',
      name: 'librarySearchTmdb',
      desc: '',
      args: [],
    );
  }

  /// `IMDB ID`
  String get librarySearchImdb {
    return Intl.message(
      'IMDB ID',
      name: 'librarySearchImdb',
      desc: '',
      args: [],
    );
  }

  /// `Tu cuenta`
  String get homeProfileShortcutsTitle {
    return Intl.message(
      'Tu cuenta',
      name: 'homeProfileShortcutsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Anterior`
  String get previousLabel {
    return Intl.message('Anterior', name: 'previousLabel', desc: '', args: []);
  }

  /// `Siguiente`
  String get nextLabel {
    return Intl.message('Siguiente', name: 'nextLabel', desc: '', args: []);
  }

  /// `Buscar por título...`
  String get librarySearchPlaceholder {
    return Intl.message(
      'Buscar por título...',
      name: 'librarySearchPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Mostrar títulos`
  String get titleDisplayModeLabel {
    return Intl.message(
      'Mostrar títulos',
      name: 'titleDisplayModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `En mi idioma`
  String get titleDisplayModeLocalized {
    return Intl.message(
      'En mi idioma',
      name: 'titleDisplayModeLocalized',
      desc: '',
      args: [],
    );
  }

  /// `Título original`
  String get titleDisplayModeOriginal {
    return Intl.message(
      'Título original',
      name: 'titleDisplayModeOriginal',
      desc: '',
      args: [],
    );
  }

  /// `Categoría`
  String get libraryFilterCategoryLabel {
    return Intl.message(
      'Categoría',
      name: 'libraryFilterCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Estilo`
  String get libraryFilterStyleLabel {
    return Intl.message(
      'Estilo',
      name: 'libraryFilterStyleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Género`
  String get libraryFilterGenreLabel {
    return Intl.message(
      'Género',
      name: 'libraryFilterGenreLabel',
      desc: '',
      args: [],
    );
  }

  /// `Subgénero`
  String get libraryFilterSubgenreLabel {
    return Intl.message(
      'Subgénero',
      name: 'libraryFilterSubgenreLabel',
      desc: '',
      args: [],
    );
  }

  /// `Película`
  String get libraryTaxonomyCatPelicula {
    return Intl.message(
      'Película',
      name: 'libraryTaxonomyCatPelicula',
      desc: '',
      args: [],
    );
  }

  /// `Serie`
  String get libraryTaxonomyCatSerie {
    return Intl.message(
      'Serie',
      name: 'libraryTaxonomyCatSerie',
      desc: '',
      args: [],
    );
  }

  /// `Cortometraje`
  String get libraryTaxonomyCatCortometraje {
    return Intl.message(
      'Cortometraje',
      name: 'libraryTaxonomyCatCortometraje',
      desc: '',
      args: [],
    );
  }

  /// `Documental`
  String get libraryTaxonomyCatDocumental {
    return Intl.message(
      'Documental',
      name: 'libraryTaxonomyCatDocumental',
      desc: '',
      args: [],
    );
  }

  /// `Programa TV`
  String get libraryTaxonomyCatProgramatv {
    return Intl.message(
      'Programa TV',
      name: 'libraryTaxonomyCatProgramatv',
      desc: '',
      args: [],
    );
  }

  /// `Live Action`
  String get libraryTaxonomyStyleLiveaction {
    return Intl.message(
      'Live Action',
      name: 'libraryTaxonomyStyleLiveaction',
      desc: '',
      args: [],
    );
  }

  /// `Animación`
  String get libraryTaxonomyStyleAnimacion {
    return Intl.message(
      'Animación',
      name: 'libraryTaxonomyStyleAnimacion',
      desc: '',
      args: [],
    );
  }

  /// `Anime`
  String get libraryTaxonomyStyleAnime {
    return Intl.message(
      'Anime',
      name: 'libraryTaxonomyStyleAnime',
      desc: '',
      args: [],
    );
  }

  /// `Acción`
  String get libraryTaxonomyGenreAccion {
    return Intl.message(
      'Acción',
      name: 'libraryTaxonomyGenreAccion',
      desc: '',
      args: [],
    );
  }

  /// `Aventuras`
  String get libraryTaxonomyGenreAventuras {
    return Intl.message(
      'Aventuras',
      name: 'libraryTaxonomyGenreAventuras',
      desc: '',
      args: [],
    );
  }

  /// `Bélico`
  String get libraryTaxonomyGenreBelico {
    return Intl.message(
      'Bélico',
      name: 'libraryTaxonomyGenreBelico',
      desc: '',
      args: [],
    );
  }

  /// `Ciencia ficción`
  String get libraryTaxonomyGenreCienciaFiccion {
    return Intl.message(
      'Ciencia ficción',
      name: 'libraryTaxonomyGenreCienciaFiccion',
      desc: '',
      args: [],
    );
  }

  /// `Cine negro`
  String get libraryTaxonomyGenreCineNegro {
    return Intl.message(
      'Cine negro',
      name: 'libraryTaxonomyGenreCineNegro',
      desc: '',
      args: [],
    );
  }

  /// `Cine quinqui`
  String get libraryTaxonomyGenreCineQuinqui {
    return Intl.message(
      'Cine quinqui',
      name: 'libraryTaxonomyGenreCineQuinqui',
      desc: '',
      args: [],
    );
  }

  /// `Comedia`
  String get libraryTaxonomyGenreComedia {
    return Intl.message(
      'Comedia',
      name: 'libraryTaxonomyGenreComedia',
      desc: '',
      args: [],
    );
  }

  /// `Documental`
  String get libraryTaxonomyGenreDocumental {
    return Intl.message(
      'Documental',
      name: 'libraryTaxonomyGenreDocumental',
      desc: '',
      args: [],
    );
  }

  /// `Drama`
  String get libraryTaxonomyGenreDrama {
    return Intl.message(
      'Drama',
      name: 'libraryTaxonomyGenreDrama',
      desc: '',
      args: [],
    );
  }

  /// `Fantasía`
  String get libraryTaxonomyGenreFantasia {
    return Intl.message(
      'Fantasía',
      name: 'libraryTaxonomyGenreFantasia',
      desc: '',
      args: [],
    );
  }

  /// `Musical`
  String get libraryTaxonomyGenreMusical {
    return Intl.message(
      'Musical',
      name: 'libraryTaxonomyGenreMusical',
      desc: '',
      args: [],
    );
  }

  /// `Romance`
  String get libraryTaxonomyGenreRomance {
    return Intl.message(
      'Romance',
      name: 'libraryTaxonomyGenreRomance',
      desc: '',
      args: [],
    );
  }

  /// `Suspense / intriga`
  String get libraryTaxonomyGenreSuspense {
    return Intl.message(
      'Suspense / intriga',
      name: 'libraryTaxonomyGenreSuspense',
      desc: '',
      args: [],
    );
  }

  /// `Terror`
  String get libraryTaxonomyGenreTerror {
    return Intl.message(
      'Terror',
      name: 'libraryTaxonomyGenreTerror',
      desc: '',
      args: [],
    );
  }

  /// `Thriller`
  String get libraryTaxonomyGenreThriller {
    return Intl.message(
      'Thriller',
      name: 'libraryTaxonomyGenreThriller',
      desc: '',
      args: [],
    );
  }

  /// `Western`
  String get libraryTaxonomyGenreWestern {
    return Intl.message(
      'Western',
      name: 'libraryTaxonomyGenreWestern',
      desc: '',
      args: [],
    );
  }

  /// `1.ª Guerra Mundial`
  String get libraryTaxonomySub1aGuerraMundial {
    return Intl.message(
      '1.ª Guerra Mundial',
      name: 'libraryTaxonomySub1aGuerraMundial',
      desc: '',
      args: [],
    );
  }

  /// `2.ª Guerra Mundial`
  String get libraryTaxonomySub2aGuerraMundial {
    return Intl.message(
      '2.ª Guerra Mundial',
      name: 'libraryTaxonomySub2aGuerraMundial',
      desc: '',
      args: [],
    );
  }

  /// `3D`
  String get libraryTaxonomySub3d {
    return Intl.message('3D', name: 'libraryTaxonomySub3d', desc: '', args: []);
  }

  /// `Abusos sexuales`
  String get libraryTaxonomySubAbusosSexuales {
    return Intl.message(
      'Abusos sexuales',
      name: 'libraryTaxonomySubAbusosSexuales',
      desc: '',
      args: [],
    );
  }

  /// `Adaptación cómic`
  String get libraryTaxonomySubAdaptacionComic {
    return Intl.message(
      'Adaptación cómic',
      name: 'libraryTaxonomySubAdaptacionComic',
      desc: '',
      args: [],
    );
  }

  /// `Adaptación libro`
  String get libraryTaxonomySubAdaptacionLibro {
    return Intl.message(
      'Adaptación libro',
      name: 'libraryTaxonomySubAdaptacionLibro',
      desc: '',
      args: [],
    );
  }

  /// `Adaptación relato`
  String get libraryTaxonomySubAdaptacionRelato {
    return Intl.message(
      'Adaptación relato',
      name: 'libraryTaxonomySubAdaptacionRelato',
      desc: '',
      args: [],
    );
  }

  /// `Adaptación videojuego`
  String get libraryTaxonomySubAdaptacionVideojuego {
    return Intl.message(
      'Adaptación videojuego',
      name: 'libraryTaxonomySubAdaptacionVideojuego',
      desc: '',
      args: [],
    );
  }

  /// `Adolescencia`
  String get libraryTaxonomySubAdolescencia {
    return Intl.message(
      'Adolescencia',
      name: 'libraryTaxonomySubAdolescencia',
      desc: '',
      args: [],
    );
  }

  /// `American Gothic`
  String get libraryTaxonomySubAmericanGothic {
    return Intl.message(
      'American Gothic',
      name: 'libraryTaxonomySubAmericanGothic',
      desc: '',
      args: [],
    );
  }

  /// `Animales`
  String get libraryTaxonomySubAnimales {
    return Intl.message(
      'Animales',
      name: 'libraryTaxonomySubAnimales',
      desc: '',
      args: [],
    );
  }

  /// `Antigua Grecia`
  String get libraryTaxonomySubAntiguaGrecia {
    return Intl.message(
      'Antigua Grecia',
      name: 'libraryTaxonomySubAntiguaGrecia',
      desc: '',
      args: [],
    );
  }

  /// `Antigua Roma`
  String get libraryTaxonomySubAntiguaRoma {
    return Intl.message(
      'Antigua Roma',
      name: 'libraryTaxonomySubAntiguaRoma',
      desc: '',
      args: [],
    );
  }

  /// `Antiguo Egipto`
  String get libraryTaxonomySubAntiguoEgipto {
    return Intl.message(
      'Antiguo Egipto',
      name: 'libraryTaxonomySubAntiguoEgipto',
      desc: '',
      args: [],
    );
  }

  /// `Arqueología`
  String get libraryTaxonomySubArqueologia {
    return Intl.message(
      'Arqueología',
      name: 'libraryTaxonomySubArqueologia',
      desc: '',
      args: [],
    );
  }

  /// `Artes marciales`
  String get libraryTaxonomySubArtesMarciales {
    return Intl.message(
      'Artes marciales',
      name: 'libraryTaxonomySubArtesMarciales',
      desc: '',
      args: [],
    );
  }

  /// `Asesinos en serie`
  String get libraryTaxonomySubAsesinosEnSerie {
    return Intl.message(
      'Asesinos en serie',
      name: 'libraryTaxonomySubAsesinosEnSerie',
      desc: '',
      args: [],
    );
  }

  /// `Aventuras aéreas`
  String get libraryTaxonomySubAventurasAereas {
    return Intl.message(
      'Aventuras aéreas',
      name: 'libraryTaxonomySubAventurasAereas',
      desc: '',
      args: [],
    );
  }

  /// `Aventuras marinas`
  String get libraryTaxonomySubAventurasMarinas {
    return Intl.message(
      'Aventuras marinas',
      name: 'libraryTaxonomySubAventurasMarinas',
      desc: '',
      args: [],
    );
  }

  /// `Bandas / pandillas callejeras`
  String get libraryTaxonomySubBandasPandillasCallejeras {
    return Intl.message(
      'Bandas / pandillas callejeras',
      name: 'libraryTaxonomySubBandasPandillasCallejeras',
      desc: '',
      args: [],
    );
  }

  /// `Biblia`
  String get libraryTaxonomySubBiblia {
    return Intl.message(
      'Biblia',
      name: 'libraryTaxonomySubBiblia',
      desc: '',
      args: [],
    );
  }

  /// `Biográfico`
  String get libraryTaxonomySubBiografico {
    return Intl.message(
      'Biográfico',
      name: 'libraryTaxonomySubBiografico',
      desc: '',
      args: [],
    );
  }

  /// `Bizarro`
  String get libraryTaxonomySubBizarro {
    return Intl.message(
      'Bizarro',
      name: 'libraryTaxonomySubBizarro',
      desc: '',
      args: [],
    );
  }

  /// `Body horror`
  String get libraryTaxonomySubBodyHorror {
    return Intl.message(
      'Body horror',
      name: 'libraryTaxonomySubBodyHorror',
      desc: '',
      args: [],
    );
  }

  /// `Brujería / satanismo`
  String get libraryTaxonomySubBrujeria {
    return Intl.message(
      'Brujería / satanismo',
      name: 'libraryTaxonomySubBrujeria',
      desc: '',
      args: [],
    );
  }

  /// `Canibalismo`
  String get libraryTaxonomySubCanibalismo {
    return Intl.message(
      'Canibalismo',
      name: 'libraryTaxonomySubCanibalismo',
      desc: '',
      args: [],
    );
  }

  /// `Capa y espada`
  String get libraryTaxonomySubCapaYEspada {
    return Intl.message(
      'Capa y espada',
      name: 'libraryTaxonomySubCapaYEspada',
      desc: '',
      args: [],
    );
  }

  /// `Casas encantadas`
  String get libraryTaxonomySubCasasEncantadas {
    return Intl.message(
      'Casas encantadas',
      name: 'libraryTaxonomySubCasasEncantadas',
      desc: '',
      args: [],
    );
  }

  /// `Catástrofes`
  String get libraryTaxonomySubCatastrofes {
    return Intl.message(
      'Catástrofes',
      name: 'libraryTaxonomySubCatastrofes',
      desc: '',
      args: [],
    );
  }

  /// `Cine dentro de cine`
  String get libraryTaxonomySubCineDentroDeCine {
    return Intl.message(
      'Cine dentro de cine',
      name: 'libraryTaxonomySubCineDentroDeCine',
      desc: '',
      args: [],
    );
  }

  /// `Cine épico`
  String get libraryTaxonomySubCineEpico {
    return Intl.message(
      'Cine épico',
      name: 'libraryTaxonomySubCineEpico',
      desc: '',
      args: [],
    );
  }

  /// `Cine experimental`
  String get libraryTaxonomySubCineExperimental {
    return Intl.message(
      'Cine experimental',
      name: 'libraryTaxonomySubCineExperimental',
      desc: '',
      args: [],
    );
  }

  /// `Cine familiar`
  String get libraryTaxonomySubCineFamiliar {
    return Intl.message(
      'Cine familiar',
      name: 'libraryTaxonomySubCineFamiliar',
      desc: '',
      args: [],
    );
  }

  /// `Cine mudo`
  String get libraryTaxonomySubMudo {
    return Intl.message(
      'Cine mudo',
      name: 'libraryTaxonomySubMudo',
      desc: '',
      args: [],
    );
  }

  /// `Claustrofobia`
  String get libraryTaxonomySubClaustrofobia {
    return Intl.message(
      'Claustrofobia',
      name: 'libraryTaxonomySubClaustrofobia',
      desc: '',
      args: [],
    );
  }

  /// `Coches / automóviles`
  String get libraryTaxonomySubCochesAutomoviles {
    return Intl.message(
      'Coches / automóviles',
      name: 'libraryTaxonomySubCochesAutomoviles',
      desc: '',
      args: [],
    );
  }

  /// `Colegios / universidades`
  String get libraryTaxonomySubColegiosUniversidades {
    return Intl.message(
      'Colegios / universidades',
      name: 'libraryTaxonomySubColegiosUniversidades',
      desc: '',
      args: [],
    );
  }

  /// `Comedia de terror`
  String get libraryTaxonomySubComediaDeTerror {
    return Intl.message(
      'Comedia de terror',
      name: 'libraryTaxonomySubComediaDeTerror',
      desc: '',
      args: [],
    );
  }

  /// `Comedia romántica`
  String get libraryTaxonomySubComediaRomantica {
    return Intl.message(
      'Comedia romántica',
      name: 'libraryTaxonomySubComediaRomantica',
      desc: '',
      args: [],
    );
  }

  /// `Crimen`
  String get libraryTaxonomySubCrimen {
    return Intl.message(
      'Crimen',
      name: 'libraryTaxonomySubCrimen',
      desc: '',
      args: [],
    );
  }

  /// `Crossover`
  String get libraryTaxonomySubCrossover {
    return Intl.message(
      'Crossover',
      name: 'libraryTaxonomySubCrossover',
      desc: '',
      args: [],
    );
  }

  /// `Cuentos`
  String get libraryTaxonomySubCuentos {
    return Intl.message(
      'Cuentos',
      name: 'libraryTaxonomySubCuentos',
      desc: '',
      args: [],
    );
  }

  /// `Culto`
  String get libraryTaxonomySubCulto {
    return Intl.message(
      'Culto',
      name: 'libraryTaxonomySubCulto',
      desc: '',
      args: [],
    );
  }

  /// `Cyberpunk`
  String get libraryTaxonomySubCyberpunk {
    return Intl.message(
      'Cyberpunk',
      name: 'libraryTaxonomySubCyberpunk',
      desc: '',
      args: [],
    );
  }

  /// `Demonios`
  String get libraryTaxonomySubDemonios {
    return Intl.message(
      'Demonios',
      name: 'libraryTaxonomySubDemonios',
      desc: '',
      args: [],
    );
  }

  /// `Deportes`
  String get libraryTaxonomySubDeportes {
    return Intl.message(
      'Deportes',
      name: 'libraryTaxonomySubDeportes',
      desc: '',
      args: [],
    );
  }

  /// `Dictadura argentina`
  String get libraryTaxonomySubDictaduraArgentina {
    return Intl.message(
      'Dictadura argentina',
      name: 'libraryTaxonomySubDictaduraArgentina',
      desc: '',
      args: [],
    );
  }

  /// `Dictadura chilena`
  String get libraryTaxonomySubDictaduraChilena {
    return Intl.message(
      'Dictadura chilena',
      name: 'libraryTaxonomySubDictaduraChilena',
      desc: '',
      args: [],
    );
  }

  /// `Dinosaurios`
  String get libraryTaxonomySubDinosaurios {
    return Intl.message(
      'Dinosaurios',
      name: 'libraryTaxonomySubDinosaurios',
      desc: '',
      args: [],
    );
  }

  /// `Distopía`
  String get libraryTaxonomySubDistopia {
    return Intl.message(
      'Distopía',
      name: 'libraryTaxonomySubDistopia',
      desc: '',
      args: [],
    );
  }

  /// `Divulgativo / educativo`
  String get libraryTaxonomySubDivulgativoEducativo {
    return Intl.message(
      'Divulgativo / educativo',
      name: 'libraryTaxonomySubDivulgativoEducativo',
      desc: '',
      args: [],
    );
  }

  /// `Dragones`
  String get libraryTaxonomySubDragones {
    return Intl.message(
      'Dragones',
      name: 'libraryTaxonomySubDragones',
      desc: '',
      args: [],
    );
  }

  /// `Drama social`
  String get libraryTaxonomySubDramaSocial {
    return Intl.message(
      'Drama social',
      name: 'libraryTaxonomySubDramaSocial',
      desc: '',
      args: [],
    );
  }

  /// `Drogas`
  String get libraryTaxonomySubDrogas {
    return Intl.message(
      'Drogas',
      name: 'libraryTaxonomySubDrogas',
      desc: '',
      args: [],
    );
  }

  /// `Duendes`
  String get libraryTaxonomySubDuendes {
    return Intl.message(
      'Duendes',
      name: 'libraryTaxonomySubDuendes',
      desc: '',
      args: [],
    );
  }

  /// `Edad Media`
  String get libraryTaxonomySubEdadMedia {
    return Intl.message(
      'Edad Media',
      name: 'libraryTaxonomySubEdadMedia',
      desc: '',
      args: [],
    );
  }

  /// `Erotismo`
  String get libraryTaxonomySubErotismo {
    return Intl.message(
      'Erotismo',
      name: 'libraryTaxonomySubErotismo',
      desc: '',
      args: [],
    );
  }

  /// `Esclavitud`
  String get libraryTaxonomySubEsclavitud {
    return Intl.message(
      'Esclavitud',
      name: 'libraryTaxonomySubEsclavitud',
      desc: '',
      args: [],
    );
  }

  /// `Espacio / espacial`
  String get libraryTaxonomySubEspacial {
    return Intl.message(
      'Espacio / espacial',
      name: 'libraryTaxonomySubEspacial',
      desc: '',
      args: [],
    );
  }

  /// `Espada y brujería`
  String get libraryTaxonomySubEspadaYBrujeria {
    return Intl.message(
      'Espada y brujería',
      name: 'libraryTaxonomySubEspadaYBrujeria',
      desc: '',
      args: [],
    );
  }

  /// `Espionaje`
  String get libraryTaxonomySubEspionaje {
    return Intl.message(
      'Espionaje',
      name: 'libraryTaxonomySubEspionaje',
      desc: '',
      args: [],
    );
  }

  /// `Experimentos`
  String get libraryTaxonomySubExperimentos {
    return Intl.message(
      'Experimentos',
      name: 'libraryTaxonomySubExperimentos',
      desc: '',
      args: [],
    );
  }

  /// `Exploitation`
  String get libraryTaxonomySubExplotation {
    return Intl.message(
      'Exploitation',
      name: 'libraryTaxonomySubExplotation',
      desc: '',
      args: [],
    );
  }

  /// `Expresionismo alemán`
  String get libraryTaxonomySubExpresionismoAleman {
    return Intl.message(
      'Expresionismo alemán',
      name: 'libraryTaxonomySubExpresionismoAleman',
      desc: '',
      args: [],
    );
  }

  /// `Extraterrestres`
  String get libraryTaxonomySubExtraterrestres {
    return Intl.message(
      'Extraterrestres',
      name: 'libraryTaxonomySubExtraterrestres',
      desc: '',
      args: [],
    );
  }

  /// `Familia`
  String get libraryTaxonomySubFamilia {
    return Intl.message(
      'Familia',
      name: 'libraryTaxonomySubFamilia',
      desc: '',
      args: [],
    );
  }

  /// `Fantasmas`
  String get libraryTaxonomySubFantasmas {
    return Intl.message(
      'Fantasmas',
      name: 'libraryTaxonomySubFantasmas',
      desc: '',
      args: [],
    );
  }

  /// `Folk`
  String get libraryTaxonomySubFolk {
    return Intl.message(
      'Folk',
      name: 'libraryTaxonomySubFolk',
      desc: '',
      args: [],
    );
  }

  /// `Futurismo`
  String get libraryTaxonomySubFuturismo {
    return Intl.message(
      'Futurismo',
      name: 'libraryTaxonomySubFuturismo',
      desc: '',
      args: [],
    );
  }

  /// `Giallo`
  String get libraryTaxonomySubGiallo {
    return Intl.message(
      'Giallo',
      name: 'libraryTaxonomySubGiallo',
      desc: '',
      args: [],
    );
  }

  /// `Gore`
  String get libraryTaxonomySubGore {
    return Intl.message(
      'Gore',
      name: 'libraryTaxonomySubGore',
      desc: '',
      args: [],
    );
  }

  /// `Gótico`
  String get libraryTaxonomySubGotico {
    return Intl.message(
      'Gótico',
      name: 'libraryTaxonomySubGotico',
      desc: '',
      args: [],
    );
  }

  /// `Guerra civil española`
  String get libraryTaxonomySubGuerraCivilEspanola {
    return Intl.message(
      'Guerra civil española',
      name: 'libraryTaxonomySubGuerraCivilEspanola',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de Corea`
  String get libraryTaxonomySubGuerraDeCorea {
    return Intl.message(
      'Guerra de Corea',
      name: 'libraryTaxonomySubGuerraDeCorea',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de independencia americana`
  String get libraryTaxonomySubGuerraDeIndependenciaAmericana {
    return Intl.message(
      'Guerra de independencia americana',
      name: 'libraryTaxonomySubGuerraDeIndependenciaAmericana',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de Irak`
  String get libraryTaxonomySubGuerraDeIrak {
    return Intl.message(
      'Guerra de Irak',
      name: 'libraryTaxonomySubGuerraDeIrak',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de las Malvinas`
  String get libraryTaxonomySubGuerraDeLasMalvinas {
    return Intl.message(
      'Guerra de las Malvinas',
      name: 'libraryTaxonomySubGuerraDeLasMalvinas',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de Secesión`
  String get libraryTaxonomySubGuerraDeSecesion {
    return Intl.message(
      'Guerra de Secesión',
      name: 'libraryTaxonomySubGuerraDeSecesion',
      desc: '',
      args: [],
    );
  }

  /// `Guerra de Vietnam`
  String get libraryTaxonomySubGuerraDeVietnam {
    return Intl.message(
      'Guerra de Vietnam',
      name: 'libraryTaxonomySubGuerraDeVietnam',
      desc: '',
      args: [],
    );
  }

  /// `Guerra fría`
  String get libraryTaxonomySubGuerraFria {
    return Intl.message(
      'Guerra fría',
      name: 'libraryTaxonomySubGuerraFria',
      desc: '',
      args: [],
    );
  }

  /// `Guerras napoleónicas`
  String get libraryTaxonomySubGuerrasNapoleonicas {
    return Intl.message(
      'Guerras napoleónicas',
      name: 'libraryTaxonomySubGuerrasNapoleonicas',
      desc: '',
      args: [],
    );
  }

  /// `Halloween`
  String get libraryTaxonomySubHalloween {
    return Intl.message(
      'Halloween',
      name: 'libraryTaxonomySubHalloween',
      desc: '',
      args: [],
    );
  }

  /// `Hechos reales`
  String get libraryTaxonomySubHechosReales {
    return Intl.message(
      'Hechos reales',
      name: 'libraryTaxonomySubHechosReales',
      desc: '',
      args: [],
    );
  }

  /// `Historias cortas / antología`
  String get libraryTaxonomySubAntologia {
    return Intl.message(
      'Historias cortas / antología',
      name: 'libraryTaxonomySubAntologia',
      desc: '',
      args: [],
    );
  }

  /// `Histórico`
  String get libraryTaxonomySubHistorico {
    return Intl.message(
      'Histórico',
      name: 'libraryTaxonomySubHistorico',
      desc: '',
      args: [],
    );
  }

  /// `Hombres lobo`
  String get libraryTaxonomySubHombresLobo {
    return Intl.message(
      'Hombres lobo',
      name: 'libraryTaxonomySubHombresLobo',
      desc: '',
      args: [],
    );
  }

  /// `Home invasion`
  String get libraryTaxonomySubHomeInvasion {
    return Intl.message(
      'Home invasion',
      name: 'libraryTaxonomySubHomeInvasion',
      desc: '',
      args: [],
    );
  }

  /// `Homosexual`
  String get libraryTaxonomySubHomosexual {
    return Intl.message(
      'Homosexual',
      name: 'libraryTaxonomySubHomosexual',
      desc: '',
      args: [],
    );
  }

  /// `Humor negro`
  String get libraryTaxonomySubHumorNegro {
    return Intl.message(
      'Humor negro',
      name: 'libraryTaxonomySubHumorNegro',
      desc: '',
      args: [],
    );
  }

  /// `Independiente`
  String get libraryTaxonomySubIndependiente {
    return Intl.message(
      'Independiente',
      name: 'libraryTaxonomySubIndependiente',
      desc: '',
      args: [],
    );
  }

  /// `Infantil`
  String get libraryTaxonomySubInfantil {
    return Intl.message(
      'Infantil',
      name: 'libraryTaxonomySubInfantil',
      desc: '',
      args: [],
    );
  }

  /// `Japón feudal`
  String get libraryTaxonomySubJaponFeudal {
    return Intl.message(
      'Japón feudal',
      name: 'libraryTaxonomySubJaponFeudal',
      desc: '',
      args: [],
    );
  }

  /// `Juego`
  String get libraryTaxonomySubJuego {
    return Intl.message(
      'Juego',
      name: 'libraryTaxonomySubJuego',
      desc: '',
      args: [],
    );
  }

  /// `Juicios`
  String get libraryTaxonomySubJuicios {
    return Intl.message(
      'Juicios',
      name: 'libraryTaxonomySubJuicios',
      desc: '',
      args: [],
    );
  }

  /// `Kaiju eiga`
  String get libraryTaxonomySubKaijuEiga {
    return Intl.message(
      'Kaiju eiga',
      name: 'libraryTaxonomySubKaijuEiga',
      desc: '',
      args: [],
    );
  }

  /// `Krimi`
  String get libraryTaxonomySubKrimi {
    return Intl.message(
      'Krimi',
      name: 'libraryTaxonomySubKrimi',
      desc: '',
      args: [],
    );
  }

  /// `Locura`
  String get libraryTaxonomySubLocura {
    return Intl.message(
      'Locura',
      name: 'libraryTaxonomySubLocura',
      desc: '',
      args: [],
    );
  }

  /// `Mad doctor`
  String get libraryTaxonomySubMadDoctor {
    return Intl.message(
      'Mad doctor',
      name: 'libraryTaxonomySubMadDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Mafia`
  String get libraryTaxonomySubMafia {
    return Intl.message(
      'Mafia',
      name: 'libraryTaxonomySubMafia',
      desc: '',
      args: [],
    );
  }

  /// `Magia`
  String get libraryTaxonomySubMagia {
    return Intl.message(
      'Magia',
      name: 'libraryTaxonomySubMagia',
      desc: '',
      args: [],
    );
  }

  /// `Miniserie`
  String get libraryTaxonomySubMiniserie {
    return Intl.message(
      'Miniserie',
      name: 'libraryTaxonomySubMiniserie',
      desc: '',
      args: [],
    );
  }

  /// `Misterio`
  String get libraryTaxonomySubMisterio {
    return Intl.message(
      'Misterio',
      name: 'libraryTaxonomySubMisterio',
      desc: '',
      args: [],
    );
  }

  /// `Mitología`
  String get libraryTaxonomySubMitologia {
    return Intl.message(
      'Mitología',
      name: 'libraryTaxonomySubMitologia',
      desc: '',
      args: [],
    );
  }

  /// `Mockbuster`
  String get libraryTaxonomySubMockbuster {
    return Intl.message(
      'Mockbuster',
      name: 'libraryTaxonomySubMockbuster',
      desc: '',
      args: [],
    );
  }

  /// `Mockumentary`
  String get libraryTaxonomySubMockumentary {
    return Intl.message(
      'Mockumentary',
      name: 'libraryTaxonomySubMockumentary',
      desc: '',
      args: [],
    );
  }

  /// `Momias`
  String get libraryTaxonomySubMomias {
    return Intl.message(
      'Momias',
      name: 'libraryTaxonomySubMomias',
      desc: '',
      args: [],
    );
  }

  /// `Monstruos`
  String get libraryTaxonomySubMonstruos {
    return Intl.message(
      'Monstruos',
      name: 'libraryTaxonomySubMonstruos',
      desc: '',
      args: [],
    );
  }

  /// `Muñecos`
  String get libraryTaxonomySubMunecos {
    return Intl.message(
      'Muñecos',
      name: 'libraryTaxonomySubMunecos',
      desc: '',
      args: [],
    );
  }

  /// `Música / baile`
  String get libraryTaxonomySubMusica {
    return Intl.message(
      'Música / baile',
      name: 'libraryTaxonomySubMusica',
      desc: '',
      args: [],
    );
  }

  /// `Mutaciones`
  String get libraryTaxonomySubMutaciones {
    return Intl.message(
      'Mutaciones',
      name: 'libraryTaxonomySubMutaciones',
      desc: '',
      args: [],
    );
  }

  /// `Naturaleza`
  String get libraryTaxonomySubPlantasVegetacion {
    return Intl.message(
      'Naturaleza',
      name: 'libraryTaxonomySubPlantasVegetacion',
      desc: '',
      args: [],
    );
  }

  /// `Navidad`
  String get libraryTaxonomySubNavidad {
    return Intl.message(
      'Navidad',
      name: 'libraryTaxonomySubNavidad',
      desc: '',
      args: [],
    );
  }

  /// `Nazismo`
  String get libraryTaxonomySubNazismo {
    return Intl.message(
      'Nazismo',
      name: 'libraryTaxonomySubNazismo',
      desc: '',
      args: [],
    );
  }

  /// `Ninjas`
  String get libraryTaxonomySubNinjas {
    return Intl.message(
      'Ninjas',
      name: 'libraryTaxonomySubNinjas',
      desc: '',
      args: [],
    );
  }

  /// `Niños`
  String get libraryTaxonomySubNinos {
    return Intl.message(
      'Niños',
      name: 'libraryTaxonomySubNinos',
      desc: '',
      args: [],
    );
  }

  /// `Obsesión`
  String get libraryTaxonomySubObsesion {
    return Intl.message(
      'Obsesión',
      name: 'libraryTaxonomySubObsesion',
      desc: '',
      args: [],
    );
  }

  /// `Parodia`
  String get libraryTaxonomySubParodia {
    return Intl.message(
      'Parodia',
      name: 'libraryTaxonomySubParodia',
      desc: '',
      args: [],
    );
  }

  /// `Payasos`
  String get libraryTaxonomySubPayasos {
    return Intl.message(
      'Payasos',
      name: 'libraryTaxonomySubPayasos',
      desc: '',
      args: [],
    );
  }

  /// `Peplum`
  String get libraryTaxonomySubPeplum {
    return Intl.message(
      'Peplum',
      name: 'libraryTaxonomySubPeplum',
      desc: '',
      args: [],
    );
  }

  /// `Pesadillas / alucinaciones`
  String get libraryTaxonomySubPesadillas {
    return Intl.message(
      'Pesadillas / alucinaciones',
      name: 'libraryTaxonomySubPesadillas',
      desc: '',
      args: [],
    );
  }

  /// `Piratas`
  String get libraryTaxonomySubPiratas {
    return Intl.message(
      'Piratas',
      name: 'libraryTaxonomySubPiratas',
      desc: '',
      args: [],
    );
  }

  /// `Policiaco`
  String get libraryTaxonomySubPoliciaco {
    return Intl.message(
      'Policiaco',
      name: 'libraryTaxonomySubPoliciaco',
      desc: '',
      args: [],
    );
  }

  /// `Política`
  String get libraryTaxonomySubPolitica {
    return Intl.message(
      'Política',
      name: 'libraryTaxonomySubPolitica',
      desc: '',
      args: [],
    );
  }

  /// `Posesiones / exorcismos`
  String get libraryTaxonomySubPosesionesExorcismos {
    return Intl.message(
      'Posesiones / exorcismos',
      name: 'libraryTaxonomySubPosesionesExorcismos',
      desc: '',
      args: [],
    );
  }

  /// `Posguerra española`
  String get libraryTaxonomySubPosguerraEspanola {
    return Intl.message(
      'Posguerra española',
      name: 'libraryTaxonomySubPosguerraEspanola',
      desc: '',
      args: [],
    );
  }

  /// `Postapocalipsis`
  String get libraryTaxonomySubPostApocalipsis {
    return Intl.message(
      'Postapocalipsis',
      name: 'libraryTaxonomySubPostApocalipsis',
      desc: '',
      args: [],
    );
  }

  /// `Precuela`
  String get libraryTaxonomySubPrecuela {
    return Intl.message(
      'Precuela',
      name: 'libraryTaxonomySubPrecuela',
      desc: '',
      args: [],
    );
  }

  /// `Prehistoria`
  String get libraryTaxonomySubPrehistoria {
    return Intl.message(
      'Prehistoria',
      name: 'libraryTaxonomySubPrehistoria',
      desc: '',
      args: [],
    );
  }

  /// `Prisión / cárcel`
  String get libraryTaxonomySubPrisionCarcel {
    return Intl.message(
      'Prisión / cárcel',
      name: 'libraryTaxonomySubPrisionCarcel',
      desc: '',
      args: [],
    );
  }

  /// `Psicológico`
  String get libraryTaxonomySubThrillerPsicologico {
    return Intl.message(
      'Psicológico',
      name: 'libraryTaxonomySubThrillerPsicologico',
      desc: '',
      args: [],
    );
  }

  /// `Psicopatía`
  String get libraryTaxonomySubPsicopatia {
    return Intl.message(
      'Psicopatía',
      name: 'libraryTaxonomySubPsicopatia',
      desc: '',
      args: [],
    );
  }

  /// `Racismo`
  String get libraryTaxonomySubRacismo {
    return Intl.message(
      'Racismo',
      name: 'libraryTaxonomySubRacismo',
      desc: '',
      args: [],
    );
  }

  /// `Realidad paralela / virtual`
  String get libraryTaxonomySubRealidadParalelaVirtual {
    return Intl.message(
      'Realidad paralela / virtual',
      name: 'libraryTaxonomySubRealidadParalelaVirtual',
      desc: '',
      args: [],
    );
  }

  /// `Realismo mágico`
  String get libraryTaxonomySubRealismoMagico {
    return Intl.message(
      'Realismo mágico',
      name: 'libraryTaxonomySubRealismoMagico',
      desc: '',
      args: [],
    );
  }

  /// `Religión`
  String get libraryTaxonomySubReligion {
    return Intl.message(
      'Religión',
      name: 'libraryTaxonomySubReligion',
      desc: '',
      args: [],
    );
  }

  /// `Remake / reboot`
  String get libraryTaxonomySubRemake {
    return Intl.message(
      'Remake / reboot',
      name: 'libraryTaxonomySubRemake',
      desc: '',
      args: [],
    );
  }

  /// `Revolución francesa`
  String get libraryTaxonomySubRevolucionFrancesa {
    return Intl.message(
      'Revolución francesa',
      name: 'libraryTaxonomySubRevolucionFrancesa',
      desc: '',
      args: [],
    );
  }

  /// `Revolución mexicana`
  String get libraryTaxonomySubRevolucionMexicana {
    return Intl.message(
      'Revolución mexicana',
      name: 'libraryTaxonomySubRevolucionMexicana',
      desc: '',
      args: [],
    );
  }

  /// `Revolución rusa`
  String get libraryTaxonomySubRevolucionRusa {
    return Intl.message(
      'Revolución rusa',
      name: 'libraryTaxonomySubRevolucionRusa',
      desc: '',
      args: [],
    );
  }

  /// `Road movie`
  String get libraryTaxonomySubRoadMovie {
    return Intl.message(
      'Road movie',
      name: 'libraryTaxonomySubRoadMovie',
      desc: '',
      args: [],
    );
  }

  /// `Robos / atracos`
  String get libraryTaxonomySubRobos {
    return Intl.message(
      'Robos / atracos',
      name: 'libraryTaxonomySubRobos',
      desc: '',
      args: [],
    );
  }

  /// `Robots / androides`
  String get libraryTaxonomySubRobotsAndroides {
    return Intl.message(
      'Robots / androides',
      name: 'libraryTaxonomySubRobotsAndroides',
      desc: '',
      args: [],
    );
  }

  /// `Samuráis`
  String get libraryTaxonomySubSamurais {
    return Intl.message(
      'Samuráis',
      name: 'libraryTaxonomySubSamurais',
      desc: '',
      args: [],
    );
  }

  /// `Sátira`
  String get libraryTaxonomySubSatira {
    return Intl.message(
      'Sátira',
      name: 'libraryTaxonomySubSatira',
      desc: '',
      args: [],
    );
  }

  /// `Sectas`
  String get libraryTaxonomySubSectas {
    return Intl.message(
      'Sectas',
      name: 'libraryTaxonomySubSectas',
      desc: '',
      args: [],
    );
  }

  /// `Secuela`
  String get libraryTaxonomySubSecuela {
    return Intl.message(
      'Secuela',
      name: 'libraryTaxonomySubSecuela',
      desc: '',
      args: [],
    );
  }

  /// `Secuela alternativa`
  String get libraryTaxonomySubSecuelaAlternativa {
    return Intl.message(
      'Secuela alternativa',
      name: 'libraryTaxonomySubSecuelaAlternativa',
      desc: '',
      args: [],
    );
  }

  /// `Secuestros / desapariciones`
  String get libraryTaxonomySubSecuestrosDesapariciones {
    return Intl.message(
      'Secuestros / desapariciones',
      name: 'libraryTaxonomySubSecuestrosDesapariciones',
      desc: '',
      args: [],
    );
  }

  /// `Serie B`
  String get libraryTaxonomySubSerieB {
    return Intl.message(
      'Serie B',
      name: 'libraryTaxonomySubSerieB',
      desc: '',
      args: [],
    );
  }

  /// `Serie Z`
  String get libraryTaxonomySubSerieZ {
    return Intl.message(
      'Serie Z',
      name: 'libraryTaxonomySubSerieZ',
      desc: '',
      args: [],
    );
  }

  /// `Sexo`
  String get libraryTaxonomySubSexo {
    return Intl.message(
      'Sexo',
      name: 'libraryTaxonomySubSexo',
      desc: '',
      args: [],
    );
  }

  /// `Sitcom`
  String get libraryTaxonomySubSitcom {
    return Intl.message(
      'Sitcom',
      name: 'libraryTaxonomySubSitcom',
      desc: '',
      args: [],
    );
  }

  /// `Sketches`
  String get libraryTaxonomySubSketches {
    return Intl.message(
      'Sketches',
      name: 'libraryTaxonomySubSketches',
      desc: '',
      args: [],
    );
  }

  /// `Slasher`
  String get libraryTaxonomySubSlasher {
    return Intl.message(
      'Slasher',
      name: 'libraryTaxonomySubSlasher',
      desc: '',
      args: [],
    );
  }

  /// `Snuff`
  String get libraryTaxonomySubSnuff {
    return Intl.message(
      'Snuff',
      name: 'libraryTaxonomySubSnuff',
      desc: '',
      args: [],
    );
  }

  /// `Sobrenatural`
  String get libraryTaxonomySubSobrenatural {
    return Intl.message(
      'Sobrenatural',
      name: 'libraryTaxonomySubSobrenatural',
      desc: '',
      args: [],
    );
  }

  /// `Spin-off`
  String get libraryTaxonomySubSpinOff {
    return Intl.message(
      'Spin-off',
      name: 'libraryTaxonomySubSpinOff',
      desc: '',
      args: [],
    );
  }

  /// `Steampunk`
  String get libraryTaxonomySubSteampunk {
    return Intl.message(
      'Steampunk',
      name: 'libraryTaxonomySubSteampunk',
      desc: '',
      args: [],
    );
  }

  /// `Superhéroes`
  String get libraryTaxonomySubSuperheroes {
    return Intl.message(
      'Superhéroes',
      name: 'libraryTaxonomySubSuperheroes',
      desc: '',
      args: [],
    );
  }

  /// `Surrealismo`
  String get libraryTaxonomySubSurrealismo {
    return Intl.message(
      'Surrealismo',
      name: 'libraryTaxonomySubSurrealismo',
      desc: '',
      args: [],
    );
  }

  /// `Survival / supervivencia`
  String get libraryTaxonomySubSurvivalSupervivencia {
    return Intl.message(
      'Survival / supervivencia',
      name: 'libraryTaxonomySubSurvivalSupervivencia',
      desc: '',
      args: [],
    );
  }

  /// `Tecnología / informática`
  String get libraryTaxonomySubTecnologiaInformatica {
    return Intl.message(
      'Tecnología / informática',
      name: 'libraryTaxonomySubTecnologiaInformatica',
      desc: '',
      args: [],
    );
  }

  /// `Telefilm`
  String get libraryTaxonomySubTelefilm {
    return Intl.message(
      'Telefilm',
      name: 'libraryTaxonomySubTelefilm',
      desc: '',
      args: [],
    );
  }

  /// `Terrorismo`
  String get libraryTaxonomySubTerrorismo {
    return Intl.message(
      'Terrorismo',
      name: 'libraryTaxonomySubTerrorismo',
      desc: '',
      args: [],
    );
  }

  /// `Tiburones asesinos`
  String get libraryTaxonomySubTiburonesAsesinos {
    return Intl.message(
      'Tiburones asesinos',
      name: 'libraryTaxonomySubTiburonesAsesinos',
      desc: '',
      args: [],
    );
  }

  /// `Tokusatsu`
  String get libraryTaxonomySubTokusatsu {
    return Intl.message(
      'Tokusatsu',
      name: 'libraryTaxonomySubTokusatsu',
      desc: '',
      args: [],
    );
  }

  /// `Torturas`
  String get libraryTaxonomySubTorturas {
    return Intl.message(
      'Torturas',
      name: 'libraryTaxonomySubTorturas',
      desc: '',
      args: [],
    );
  }

  /// `Transexualidad / transgénero`
  String get libraryTaxonomySubTransexualidadTransgenero {
    return Intl.message(
      'Transexualidad / transgénero',
      name: 'libraryTaxonomySubTransexualidadTransgenero',
      desc: '',
      args: [],
    );
  }

  /// `Vampirismo`
  String get libraryTaxonomySubVampiros {
    return Intl.message(
      'Vampirismo',
      name: 'libraryTaxonomySubVampiros',
      desc: '',
      args: [],
    );
  }

  /// `Venganza`
  String get libraryTaxonomySubVenganza {
    return Intl.message(
      'Venganza',
      name: 'libraryTaxonomySubVenganza',
      desc: '',
      args: [],
    );
  }

  /// `Viaje temporal`
  String get libraryTaxonomySubViajeTemporal {
    return Intl.message(
      'Viaje temporal',
      name: 'libraryTaxonomySubViajeTemporal',
      desc: '',
      args: [],
    );
  }

  /// `Vikingos`
  String get libraryTaxonomySubVikingos {
    return Intl.message(
      'Vikingos',
      name: 'libraryTaxonomySubVikingos',
      desc: '',
      args: [],
    );
  }

  /// `Visiones`
  String get libraryTaxonomySubVisiones {
    return Intl.message(
      'Visiones',
      name: 'libraryTaxonomySubVisiones',
      desc: '',
      args: [],
    );
  }

  /// `Vudú`
  String get libraryTaxonomySubVudu {
    return Intl.message(
      'Vudú',
      name: 'libraryTaxonomySubVudu',
      desc: '',
      args: [],
    );
  }

  /// `Wuxia`
  String get libraryTaxonomySubWuxia {
    return Intl.message(
      'Wuxia',
      name: 'libraryTaxonomySubWuxia',
      desc: '',
      args: [],
    );
  }

  /// `Zombies / infectados`
  String get libraryTaxonomySubZombiesInfectados {
    return Intl.message(
      'Zombies / infectados',
      name: 'libraryTaxonomySubZombiesInfectados',
      desc: '',
      args: [],
    );
  }

  /// `Año`
  String get libraryFilterYearLabel {
    return Intl.message(
      'Año',
      name: 'libraryFilterYearLabel',
      desc: '',
      args: [],
    );
  }

  /// `Año desde`
  String get libraryFilterYearFromLabel {
    return Intl.message(
      'Año desde',
      name: 'libraryFilterYearFromLabel',
      desc: '',
      args: [],
    );
  }

  /// `Año hasta`
  String get libraryFilterYearToLabel {
    return Intl.message(
      'Año hasta',
      name: 'libraryFilterYearToLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
