import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Colores de Filmoly según el logo: verde lima y gris antracita.
class AppColors {
  /// Verde lima vibrante (elementos principales, botones, acentos)
  static const Color primary = Color(0xFFB8D936);
  static const Color primaryLow = Color(0xFF9ACD32);
  static const Color primaryAccent = Color(0xFFC8E65C);
  /// Gris antracita (fondos oscuros, texto, contraste)
  static const Color anthracite = Color(0xFF2C2C2E);
  static const Color anthraciteDark = Color(0xFF121212);
  /// Secundario / apoyo
  static const Color secondary = Color(0xFFE5A84B);
  static const Color secondaryLow = Color(0xFFFFB84B);
  static const Color red = Color(0xFFD50032);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color surfaceLight = Color(0xFFFAFAFA);
  /// Superficie oscura (igual que Fitcron)
  static const Color surfaceDark = Color(0xFF121212);
}

ColorScheme get lightColorScheme {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.anthraciteDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.black,
    tertiary: AppColors.primaryAccent,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.black,
  );
}

ColorScheme get darkColorScheme {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.anthraciteDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.black,
    tertiary: AppColors.primaryAccent,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.white,
  );
}

ThemeData themeFromColorScheme(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness:
            colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.brightness == Brightness.dark
          ? colorScheme.onSurface.withValues(alpha: 0.05)
          : colorScheme.surface,
      surfaceTintColor: colorScheme.tertiary,
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: colorScheme.inverseSurface.withValues(alpha: 0.2),
        ),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: colorScheme.secondary,
      collapsedIconColor: colorScheme.onSurface,
      shape: const Border(),
    ),
    listTileTheme: ListTileThemeData(
      mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
        backgroundColor: WidgetStateProperty.all<Color>(colorScheme.primary),
        foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onPrimary),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
        foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onSurface),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: colorScheme.primary),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

ThemeData get lightTheme => themeFromColorScheme(lightColorScheme);
ThemeData get darkTheme => themeFromColorScheme(darkColorScheme);
