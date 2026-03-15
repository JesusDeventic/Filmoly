import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/main.dart';
import 'package:filmoly/page/users/version_changelog_page.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:filmoly/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomSnackBar(String message, {int? type}) {
  Color? backgroundColor;
  if (type == -1) {
    backgroundColor = Colors.red[900];
  } else if (type == 1) {
    backgroundColor = Colors.green[700];
  }
  final snack = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
  final messenger = scaffoldMessengerKey.currentState;
  if (messenger != null) {
    messenger.showSnackBar(snack);
  } else {
    final ctx = navigatorKey.currentContext;
    if (ctx != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(snack);
    }
  }
}

Widget rowSettingsAppAndVersion(BuildContext context) {
  final lang = context.read<LanguageProvider>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: PopupMenuButton<String>(
          tooltip: S.current.language,
          onOpened: () => unFocusGlobal(),
          onSelected: (value) => lang.changeLanguage(value),
          itemBuilder: (ctx) => languageKeys.map((code) {
            final isSelected = code == lang.currentLanguage;
            return PopupMenuItem<String>(
              value: code,
              child: Row(
                children: [
                  if (isSelected)
                    Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: Theme.of(ctx).colorScheme.secondary,
                    ),
                  if (isSelected) const SizedBox(width: 8),
                  Text(
                    getLanguageFlag(code),
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected
                          ? Theme.of(ctx).colorScheme.secondary
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      getLanguageName(code),
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected
                            ? Theme.of(ctx).colorScheme.secondary
                            : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getLanguageFlag(lang.currentLanguage),
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    getNativeLanguageName(lang.currentLanguage),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Flexible(
        flex: 0,
        child: Tooltip(
          message: S.current.theme,
          child: ElevatedButton(
            onPressed: () {
              unFocusGlobal();
              context.read<ThemeProvider>().toggleTheme();
            },
            child: Consumer<ThemeProvider>(
              builder: (_, themeProvider, __) => Icon(
                themeProvider.isDarkMode
                    ? Icons.nightlight_round
                    : Icons.wb_sunny_rounded,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Tooltip(
          message: S.current.currentAppVersionText,
          child: TextButton(
            onPressed: () {
              unFocusGlobal();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VersionChangeLogPage(),
                ),
              );
            },
            child: Text(
              'v$globalCurrentVersionApp',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    ],
  );
}
