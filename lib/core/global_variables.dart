import 'package:filmoly/model/user_model.dart';

/// Token en memoria (se persiste en secure storage).
String globalUserToken = '';

/// Usuario actual (se rellena al validar token o al hacer login/registro).
FilmolyUser globalCurrentUser = FilmolyUser();

/// Versión de la app (se carga en el splash).
String globalCurrentVersionApp = '';

/// Idiomas soportados (claves para el selector), orden alfabético por clave como en Fitcron.
const List<String> languageKeys = [
  'ar', 'ca', 'de', 'en', 'es', 'fr', 'hi', 'it', 'ja', 'ko',
  'nl', 'pl', 'pt', 'ro', 'ru', 'sv', 'tr', 'uk', 'zh',
];
