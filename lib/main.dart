import 'dart:io';
import 'package:filmoly/api/filmoly_messaging_service.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:filmoly/providers/theme_provider.dart';
import 'package:filmoly/routes/app_router.dart';
import 'package:filmoly/styles/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Cargar versión de la app SIEMPRE al arrancar (como en Fitcron),
  // para que esté disponible incluso tras reload en Web.
  await loadAppVersion();
  // Inicializar notificaciones push solo en Android / iOS / Web
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    try {
      final messaging = FilmolyMessagingService();
      await messaging.initialize();
    } catch (e) {
      debugPrint('Error inicializando notificaciones de Firebase: $e');
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const FilmolyApp(),
    ),
  );
}

class FilmolyApp extends StatefulWidget {
  const FilmolyApp({super.key});

  @override
  State<FilmolyApp> createState() => _FilmolyAppState();
}

class _FilmolyAppState extends State<FilmolyApp> {
  late final GoRouter _router = createAppRouter(navigatorKey);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, _) {
        return MaterialApp.router(
          routerConfig: _router,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => S.current.appName,
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
          locale: Locale(languageProvider.currentLanguage),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
