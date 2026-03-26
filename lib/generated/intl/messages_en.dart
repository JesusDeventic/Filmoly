// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m3(count) => "${count} resultados";

  static String m0(seconds) =>
      "Incorrect username or password.\nPlease wait ${seconds} seconds before trying again.";

  static String m1(username) => "Profile of @${username} on Filmaniak";

  static String m2(username) => "QR for @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Account settings"),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Yes"),
    "allLabel": MessageLookupByLibrary.simpleMessage("Todos"),
    "andLabel": MessageLookupByLibrary.simpleMessage("and"),
    "appName": MessageLookupByLibrary.simpleMessage("Filmaniak"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Initial release of Filmaniak.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Changelog",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change password",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Close"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete account",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("Remove avatar"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("Reload"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "The code must be 6 digits",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "If the account exists, a code has been sent to your email.",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Collapse"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookie policy"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Link copied",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Current version",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current password"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Available version",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Date format"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Delete all notifications",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to exit the app?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("Exit the app"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Save your changes?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Password",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "A new version of Filmaniak is available.\nUpdate the app to continue.",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Could not connect to the Filmaniak server.",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "The app is currently under maintenance. Please try again later.",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Attention"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Display name (optional)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "errorApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "Los datos enviados no son válidos",
    ),
    "errorApiEndpointUnavailable": MessageLookupByLibrary.simpleMessage(
      "No se ha podido completar la operación. Inténtalo más tarde.",
    ),
    "errorApiForbidden": MessageLookupByLibrary.simpleMessage(
      "No tienes permiso para hacer esto",
    ),
    "errorApiGeneric": MessageLookupByLibrary.simpleMessage(
      "No se ha podido completar la operación. Inténtalo más tarde.",
    ),
    "errorApiNetwork": MessageLookupByLibrary.simpleMessage(
      "No se ha podido conectar con el servidor. Revisa tu conexión o inténtalo más tarde.",
    ),
    "errorApiNotFound": MessageLookupByLibrary.simpleMessage(
      "No hemos encontrado lo que buscas",
    ),
    "errorApiServer": MessageLookupByLibrary.simpleMessage(
      "Ha ocurrido un error en el servidor. Inténtalo más tarde.",
    ),
    "errorApiSession": MessageLookupByLibrary.simpleMessage(
      "Sesión no válida. Inicia sesión de nuevo.",
    ),
    "errorApiUnauthorized": MessageLookupByLibrary.simpleMessage(
      "Sesión no válida. Vuelve a iniciar sesión.",
    ),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Could not delete the account. Please try again.",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "That email is already registered.",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "The code has expired.",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "The code is not valid.",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect username or password.",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "The email is not valid.",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters.",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Required fields are missing.",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "You must enter a username or email.",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Registration could not be completed. Please try again.",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Could not create a session. Please try again later.",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "You have exceeded the maximum number of attempts.",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "That username is already taken.",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect password.",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Could not process the image.",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expand"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "It is an app with a database of films, series and other audiovisual content, with tools that let users interact with other members, create lists, add ratings and reviews, and more.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("What is Filmaniak?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, Filmaniak is not a streaming app; it only works as a database with various features around that content.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Can I watch films and series?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "How do I delete my account?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filterApplyLabel": MessageLookupByLibrary.simpleMessage("Aplicar"),
    "filterResetLabel": MessageLookupByLibrary.simpleMessage("Restablecer"),
    "filtersTitle": MessageLookupByLibrary.simpleMessage("Filtros"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot your password?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage("General settings"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("Could not open system settings."),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Could not save settings. Check your connection and try again.",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Settings cannot be saved. Please sign in again.",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Settings saved successfully.",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Go to home"),
    "homeProfileShortcutsTitle": MessageLookupByLibrary.simpleMessage(
      "Tu cuenta",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Keep me signed in"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Catalan"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinese"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Dutch"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("French"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("German"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesian"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italian"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japanese"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Korean"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polish"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portuguese"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Romanian"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Russian"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spanish"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Swedish"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turkish"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukrainian"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage("Last seen"),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Legal notice"),
    "libraryEmpty": MessageLookupByLibrary.simpleMessage(
      "No hay resultados con estos filtros",
    ),
    "libraryEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Prueba a cambiar filtros o la búsqueda",
    ),
    "libraryErrorLoad": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar la biblioteca",
    ),
    "libraryFilterCategoryLabel": MessageLookupByLibrary.simpleMessage(
      "Categoría",
    ),
    "libraryFilterGenreLabel": MessageLookupByLibrary.simpleMessage("Género"),
    "libraryFilterStyleLabel": MessageLookupByLibrary.simpleMessage("Estilo"),
    "libraryFilterSubgenreLabel": MessageLookupByLibrary.simpleMessage(
      "Subgénero",
    ),
    "libraryFilterYearFromLabel": MessageLookupByLibrary.simpleMessage(
      "Año desde",
    ),
    "libraryFilterYearLabel": MessageLookupByLibrary.simpleMessage("Año"),
    "libraryFilterYearToLabel": MessageLookupByLibrary.simpleMessage(
      "Año hasta",
    ),
    "libraryLayoutComfortable": MessageLookupByLibrary.simpleMessage(
      "Cuadrícula amplia",
    ),
    "libraryLayoutCompact": MessageLookupByLibrary.simpleMessage(
      "Cuadrícula compacta",
    ),
    "libraryLayoutList": MessageLookupByLibrary.simpleMessage("Listado"),
    "libraryOrderDate": MessageLookupByLibrary.simpleMessage(
      "Publicación (más reciente)",
    ),
    "libraryOrderDateAsc": MessageLookupByLibrary.simpleMessage(
      "Publicación (más antigua)",
    ),
    "libraryOrderModified": MessageLookupByLibrary.simpleMessage(
      "Modificación (más reciente)",
    ),
    "libraryOrderModifiedAsc": MessageLookupByLibrary.simpleMessage(
      "Modificación (más antigua)",
    ),
    "libraryOrderRatingAsc": MessageLookupByLibrary.simpleMessage(
      "Peor valoradas",
    ),
    "libraryOrderRatingCount": MessageLookupByLibrary.simpleMessage(
      "Más valoraciones",
    ),
    "libraryOrderRatingDesc": MessageLookupByLibrary.simpleMessage(
      "Mejor valoradas",
    ),
    "libraryOrderTitle": MessageLookupByLibrary.simpleMessage("Título (A-Z)"),
    "libraryOrderTitleDesc": MessageLookupByLibrary.simpleMessage(
      "Título (Z-A)",
    ),
    "libraryOrderYearAsc": MessageLookupByLibrary.simpleMessage(
      "Año (ascendente)",
    ),
    "libraryOrderYearDesc": MessageLookupByLibrary.simpleMessage(
      "Año (descendente)",
    ),
    "libraryResultsTotal": m3,
    "librarySearchCast": MessageLookupByLibrary.simpleMessage("Reparto"),
    "librarySearchCrew": MessageLookupByLibrary.simpleMessage(
      "Guión / Música / Fotografía",
    ),
    "librarySearchDirector": MessageLookupByLibrary.simpleMessage("Dirección"),
    "librarySearchFieldLabel": MessageLookupByLibrary.simpleMessage(
      "Buscar en",
    ),
    "librarySearchImdb": MessageLookupByLibrary.simpleMessage("IMDB ID"),
    "librarySearchPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Buscar por título...",
    ),
    "librarySearchStudio": MessageLookupByLibrary.simpleMessage("Productora"),
    "librarySearchTitle": MessageLookupByLibrary.simpleMessage("Título"),
    "librarySearchTmdb": MessageLookupByLibrary.simpleMessage("TMDB ID"),
    "libraryTaxonomyCatCortometraje": MessageLookupByLibrary.simpleMessage(
      "Cortometraje",
    ),
    "libraryTaxonomyCatDocumental": MessageLookupByLibrary.simpleMessage(
      "Documental",
    ),
    "libraryTaxonomyCatPelicula": MessageLookupByLibrary.simpleMessage(
      "Película",
    ),
    "libraryTaxonomyCatProgramatv": MessageLookupByLibrary.simpleMessage(
      "Programa TV",
    ),
    "libraryTaxonomyCatSerie": MessageLookupByLibrary.simpleMessage("Serie"),
    "libraryTaxonomyGenreAccion": MessageLookupByLibrary.simpleMessage(
      "Acción",
    ),
    "libraryTaxonomyGenreAventuras": MessageLookupByLibrary.simpleMessage(
      "Aventuras",
    ),
    "libraryTaxonomyGenreBelico": MessageLookupByLibrary.simpleMessage(
      "Bélico",
    ),
    "libraryTaxonomyGenreCienciaFiccion": MessageLookupByLibrary.simpleMessage(
      "Ciencia ficción",
    ),
    "libraryTaxonomyGenreCineNegro": MessageLookupByLibrary.simpleMessage(
      "Cine negro",
    ),
    "libraryTaxonomyGenreCineQuinqui": MessageLookupByLibrary.simpleMessage(
      "Cine quinqui",
    ),
    "libraryTaxonomyGenreComedia": MessageLookupByLibrary.simpleMessage(
      "Comedia",
    ),
    "libraryTaxonomyGenreDocumental": MessageLookupByLibrary.simpleMessage(
      "Documental",
    ),
    "libraryTaxonomyGenreDrama": MessageLookupByLibrary.simpleMessage("Drama"),
    "libraryTaxonomyGenreFantasia": MessageLookupByLibrary.simpleMessage(
      "Fantasía",
    ),
    "libraryTaxonomyGenreMusical": MessageLookupByLibrary.simpleMessage(
      "Musical",
    ),
    "libraryTaxonomyGenreRomance": MessageLookupByLibrary.simpleMessage(
      "Romance",
    ),
    "libraryTaxonomyGenreSuspense": MessageLookupByLibrary.simpleMessage(
      "Suspense / intriga",
    ),
    "libraryTaxonomyGenreTerror": MessageLookupByLibrary.simpleMessage(
      "Terror",
    ),
    "libraryTaxonomyGenreThriller": MessageLookupByLibrary.simpleMessage(
      "Thriller",
    ),
    "libraryTaxonomyGenreWestern": MessageLookupByLibrary.simpleMessage(
      "Western",
    ),
    "libraryTaxonomyStyleAnimacion": MessageLookupByLibrary.simpleMessage(
      "Animación",
    ),
    "libraryTaxonomyStyleAnime": MessageLookupByLibrary.simpleMessage("Anime"),
    "libraryTaxonomyStyleLiveaction": MessageLookupByLibrary.simpleMessage(
      "Live Action",
    ),
    "libraryTaxonomySub1aGuerraMundial": MessageLookupByLibrary.simpleMessage(
      "1.ª Guerra Mundial",
    ),
    "libraryTaxonomySub2aGuerraMundial": MessageLookupByLibrary.simpleMessage(
      "2.ª Guerra Mundial",
    ),
    "libraryTaxonomySub3d": MessageLookupByLibrary.simpleMessage("3D"),
    "libraryTaxonomySubAbusosSexuales": MessageLookupByLibrary.simpleMessage(
      "Abusos sexuales",
    ),
    "libraryTaxonomySubAdaptacionComic": MessageLookupByLibrary.simpleMessage(
      "Adaptación cómic",
    ),
    "libraryTaxonomySubAdaptacionLibro": MessageLookupByLibrary.simpleMessage(
      "Adaptación libro",
    ),
    "libraryTaxonomySubAdaptacionRelato": MessageLookupByLibrary.simpleMessage(
      "Adaptación relato",
    ),
    "libraryTaxonomySubAdaptacionVideojuego":
        MessageLookupByLibrary.simpleMessage("Adaptación videojuego"),
    "libraryTaxonomySubAdolescencia": MessageLookupByLibrary.simpleMessage(
      "Adolescencia",
    ),
    "libraryTaxonomySubAmericanGothic": MessageLookupByLibrary.simpleMessage(
      "American Gothic",
    ),
    "libraryTaxonomySubAnimales": MessageLookupByLibrary.simpleMessage(
      "Animales",
    ),
    "libraryTaxonomySubAntiguaGrecia": MessageLookupByLibrary.simpleMessage(
      "Antigua Grecia",
    ),
    "libraryTaxonomySubAntiguaRoma": MessageLookupByLibrary.simpleMessage(
      "Antigua Roma",
    ),
    "libraryTaxonomySubAntiguoEgipto": MessageLookupByLibrary.simpleMessage(
      "Antiguo Egipto",
    ),
    "libraryTaxonomySubAntologia": MessageLookupByLibrary.simpleMessage(
      "Historias cortas / antología",
    ),
    "libraryTaxonomySubArqueologia": MessageLookupByLibrary.simpleMessage(
      "Arqueología",
    ),
    "libraryTaxonomySubArtesMarciales": MessageLookupByLibrary.simpleMessage(
      "Artes marciales",
    ),
    "libraryTaxonomySubAsesinosEnSerie": MessageLookupByLibrary.simpleMessage(
      "Asesinos en serie",
    ),
    "libraryTaxonomySubAventurasAereas": MessageLookupByLibrary.simpleMessage(
      "Aventuras aéreas",
    ),
    "libraryTaxonomySubAventurasMarinas": MessageLookupByLibrary.simpleMessage(
      "Aventuras marinas",
    ),
    "libraryTaxonomySubBandasPandillasCallejeras":
        MessageLookupByLibrary.simpleMessage("Bandas / pandillas callejeras"),
    "libraryTaxonomySubBiblia": MessageLookupByLibrary.simpleMessage("Biblia"),
    "libraryTaxonomySubBiografico": MessageLookupByLibrary.simpleMessage(
      "Biográfico",
    ),
    "libraryTaxonomySubBizarro": MessageLookupByLibrary.simpleMessage(
      "Bizarro",
    ),
    "libraryTaxonomySubBodyHorror": MessageLookupByLibrary.simpleMessage(
      "Body horror",
    ),
    "libraryTaxonomySubBrujeria": MessageLookupByLibrary.simpleMessage(
      "Brujería / satanismo",
    ),
    "libraryTaxonomySubCanibalismo": MessageLookupByLibrary.simpleMessage(
      "Canibalismo",
    ),
    "libraryTaxonomySubCapaYEspada": MessageLookupByLibrary.simpleMessage(
      "Capa y espada",
    ),
    "libraryTaxonomySubCasasEncantadas": MessageLookupByLibrary.simpleMessage(
      "Casas encantadas",
    ),
    "libraryTaxonomySubCatastrofes": MessageLookupByLibrary.simpleMessage(
      "Catástrofes",
    ),
    "libraryTaxonomySubCineDentroDeCine": MessageLookupByLibrary.simpleMessage(
      "Cine dentro de cine",
    ),
    "libraryTaxonomySubCineEpico": MessageLookupByLibrary.simpleMessage(
      "Cine épico",
    ),
    "libraryTaxonomySubCineExperimental": MessageLookupByLibrary.simpleMessage(
      "Cine experimental",
    ),
    "libraryTaxonomySubCineFamiliar": MessageLookupByLibrary.simpleMessage(
      "Cine familiar",
    ),
    "libraryTaxonomySubClaustrofobia": MessageLookupByLibrary.simpleMessage(
      "Claustrofobia",
    ),
    "libraryTaxonomySubCochesAutomoviles": MessageLookupByLibrary.simpleMessage(
      "Coches / automóviles",
    ),
    "libraryTaxonomySubColegiosUniversidades":
        MessageLookupByLibrary.simpleMessage("Colegios / universidades"),
    "libraryTaxonomySubComediaDeTerror": MessageLookupByLibrary.simpleMessage(
      "Comedia de terror",
    ),
    "libraryTaxonomySubComediaRomantica": MessageLookupByLibrary.simpleMessage(
      "Comedia romántica",
    ),
    "libraryTaxonomySubCrimen": MessageLookupByLibrary.simpleMessage("Crimen"),
    "libraryTaxonomySubCrossover": MessageLookupByLibrary.simpleMessage(
      "Crossover",
    ),
    "libraryTaxonomySubCuentos": MessageLookupByLibrary.simpleMessage(
      "Cuentos",
    ),
    "libraryTaxonomySubCulto": MessageLookupByLibrary.simpleMessage("Culto"),
    "libraryTaxonomySubCyberpunk": MessageLookupByLibrary.simpleMessage(
      "Cyberpunk",
    ),
    "libraryTaxonomySubDemonios": MessageLookupByLibrary.simpleMessage(
      "Demonios",
    ),
    "libraryTaxonomySubDeportes": MessageLookupByLibrary.simpleMessage(
      "Deportes",
    ),
    "libraryTaxonomySubDictaduraArgentina":
        MessageLookupByLibrary.simpleMessage("Dictadura argentina"),
    "libraryTaxonomySubDictaduraChilena": MessageLookupByLibrary.simpleMessage(
      "Dictadura chilena",
    ),
    "libraryTaxonomySubDinosaurios": MessageLookupByLibrary.simpleMessage(
      "Dinosaurios",
    ),
    "libraryTaxonomySubDistopia": MessageLookupByLibrary.simpleMessage(
      "Distopía",
    ),
    "libraryTaxonomySubDivulgativoEducativo":
        MessageLookupByLibrary.simpleMessage("Divulgativo / educativo"),
    "libraryTaxonomySubDragones": MessageLookupByLibrary.simpleMessage(
      "Dragones",
    ),
    "libraryTaxonomySubDramaSocial": MessageLookupByLibrary.simpleMessage(
      "Drama social",
    ),
    "libraryTaxonomySubDrogas": MessageLookupByLibrary.simpleMessage("Drogas"),
    "libraryTaxonomySubDuendes": MessageLookupByLibrary.simpleMessage(
      "Duendes",
    ),
    "libraryTaxonomySubEdadMedia": MessageLookupByLibrary.simpleMessage(
      "Edad Media",
    ),
    "libraryTaxonomySubErotismo": MessageLookupByLibrary.simpleMessage(
      "Erotismo",
    ),
    "libraryTaxonomySubEsclavitud": MessageLookupByLibrary.simpleMessage(
      "Esclavitud",
    ),
    "libraryTaxonomySubEspacial": MessageLookupByLibrary.simpleMessage(
      "Espacio / espacial",
    ),
    "libraryTaxonomySubEspadaYBrujeria": MessageLookupByLibrary.simpleMessage(
      "Espada y brujería",
    ),
    "libraryTaxonomySubEspionaje": MessageLookupByLibrary.simpleMessage(
      "Espionaje",
    ),
    "libraryTaxonomySubExperimentos": MessageLookupByLibrary.simpleMessage(
      "Experimentos",
    ),
    "libraryTaxonomySubExplotation": MessageLookupByLibrary.simpleMessage(
      "Exploitation",
    ),
    "libraryTaxonomySubExpresionismoAleman":
        MessageLookupByLibrary.simpleMessage("Expresionismo alemán"),
    "libraryTaxonomySubExtraterrestres": MessageLookupByLibrary.simpleMessage(
      "Extraterrestres",
    ),
    "libraryTaxonomySubFamilia": MessageLookupByLibrary.simpleMessage(
      "Familia",
    ),
    "libraryTaxonomySubFantasmas": MessageLookupByLibrary.simpleMessage(
      "Fantasmas",
    ),
    "libraryTaxonomySubFolk": MessageLookupByLibrary.simpleMessage("Folk"),
    "libraryTaxonomySubFuturismo": MessageLookupByLibrary.simpleMessage(
      "Futurismo",
    ),
    "libraryTaxonomySubGiallo": MessageLookupByLibrary.simpleMessage("Giallo"),
    "libraryTaxonomySubGore": MessageLookupByLibrary.simpleMessage("Gore"),
    "libraryTaxonomySubGotico": MessageLookupByLibrary.simpleMessage("Gótico"),
    "libraryTaxonomySubGuerraCivilEspanola":
        MessageLookupByLibrary.simpleMessage("Guerra civil española"),
    "libraryTaxonomySubGuerraDeCorea": MessageLookupByLibrary.simpleMessage(
      "Guerra de Corea",
    ),
    "libraryTaxonomySubGuerraDeIndependenciaAmericana":
        MessageLookupByLibrary.simpleMessage(
          "Guerra de independencia americana",
        ),
    "libraryTaxonomySubGuerraDeIrak": MessageLookupByLibrary.simpleMessage(
      "Guerra de Irak",
    ),
    "libraryTaxonomySubGuerraDeLasMalvinas":
        MessageLookupByLibrary.simpleMessage("Guerra de las Malvinas"),
    "libraryTaxonomySubGuerraDeSecesion": MessageLookupByLibrary.simpleMessage(
      "Guerra de Secesión",
    ),
    "libraryTaxonomySubGuerraDeVietnam": MessageLookupByLibrary.simpleMessage(
      "Guerra de Vietnam",
    ),
    "libraryTaxonomySubGuerraFria": MessageLookupByLibrary.simpleMessage(
      "Guerra fría",
    ),
    "libraryTaxonomySubGuerrasNapoleonicas":
        MessageLookupByLibrary.simpleMessage("Guerras napoleónicas"),
    "libraryTaxonomySubHalloween": MessageLookupByLibrary.simpleMessage(
      "Halloween",
    ),
    "libraryTaxonomySubHechosReales": MessageLookupByLibrary.simpleMessage(
      "Hechos reales",
    ),
    "libraryTaxonomySubHistorico": MessageLookupByLibrary.simpleMessage(
      "Histórico",
    ),
    "libraryTaxonomySubHombresLobo": MessageLookupByLibrary.simpleMessage(
      "Hombres lobo",
    ),
    "libraryTaxonomySubHomeInvasion": MessageLookupByLibrary.simpleMessage(
      "Home invasion",
    ),
    "libraryTaxonomySubHomosexual": MessageLookupByLibrary.simpleMessage(
      "Homosexual",
    ),
    "libraryTaxonomySubHumorNegro": MessageLookupByLibrary.simpleMessage(
      "Humor negro",
    ),
    "libraryTaxonomySubIndependiente": MessageLookupByLibrary.simpleMessage(
      "Independiente",
    ),
    "libraryTaxonomySubInfantil": MessageLookupByLibrary.simpleMessage(
      "Infantil",
    ),
    "libraryTaxonomySubJaponFeudal": MessageLookupByLibrary.simpleMessage(
      "Japón feudal",
    ),
    "libraryTaxonomySubJuego": MessageLookupByLibrary.simpleMessage("Juego"),
    "libraryTaxonomySubJuicios": MessageLookupByLibrary.simpleMessage(
      "Juicios",
    ),
    "libraryTaxonomySubKaijuEiga": MessageLookupByLibrary.simpleMessage(
      "Kaiju eiga",
    ),
    "libraryTaxonomySubKrimi": MessageLookupByLibrary.simpleMessage("Krimi"),
    "libraryTaxonomySubLocura": MessageLookupByLibrary.simpleMessage("Locura"),
    "libraryTaxonomySubMadDoctor": MessageLookupByLibrary.simpleMessage(
      "Mad doctor",
    ),
    "libraryTaxonomySubMafia": MessageLookupByLibrary.simpleMessage("Mafia"),
    "libraryTaxonomySubMagia": MessageLookupByLibrary.simpleMessage("Magia"),
    "libraryTaxonomySubMiniserie": MessageLookupByLibrary.simpleMessage(
      "Miniserie",
    ),
    "libraryTaxonomySubMisterio": MessageLookupByLibrary.simpleMessage(
      "Misterio",
    ),
    "libraryTaxonomySubMitologia": MessageLookupByLibrary.simpleMessage(
      "Mitología",
    ),
    "libraryTaxonomySubMockbuster": MessageLookupByLibrary.simpleMessage(
      "Mockbuster",
    ),
    "libraryTaxonomySubMockumentary": MessageLookupByLibrary.simpleMessage(
      "Mockumentary",
    ),
    "libraryTaxonomySubMomias": MessageLookupByLibrary.simpleMessage("Momias"),
    "libraryTaxonomySubMonstruos": MessageLookupByLibrary.simpleMessage(
      "Monstruos",
    ),
    "libraryTaxonomySubMudo": MessageLookupByLibrary.simpleMessage("Cine mudo"),
    "libraryTaxonomySubMunecos": MessageLookupByLibrary.simpleMessage(
      "Muñecos",
    ),
    "libraryTaxonomySubMusica": MessageLookupByLibrary.simpleMessage(
      "Música / baile",
    ),
    "libraryTaxonomySubMutaciones": MessageLookupByLibrary.simpleMessage(
      "Mutaciones",
    ),
    "libraryTaxonomySubNavidad": MessageLookupByLibrary.simpleMessage(
      "Navidad",
    ),
    "libraryTaxonomySubNazismo": MessageLookupByLibrary.simpleMessage(
      "Nazismo",
    ),
    "libraryTaxonomySubNinjas": MessageLookupByLibrary.simpleMessage("Ninjas"),
    "libraryTaxonomySubNinos": MessageLookupByLibrary.simpleMessage("Niños"),
    "libraryTaxonomySubObsesion": MessageLookupByLibrary.simpleMessage(
      "Obsesión",
    ),
    "libraryTaxonomySubParodia": MessageLookupByLibrary.simpleMessage(
      "Parodia",
    ),
    "libraryTaxonomySubPayasos": MessageLookupByLibrary.simpleMessage(
      "Payasos",
    ),
    "libraryTaxonomySubPeplum": MessageLookupByLibrary.simpleMessage("Peplum"),
    "libraryTaxonomySubPesadillas": MessageLookupByLibrary.simpleMessage(
      "Pesadillas / alucinaciones",
    ),
    "libraryTaxonomySubPiratas": MessageLookupByLibrary.simpleMessage(
      "Piratas",
    ),
    "libraryTaxonomySubPlantasVegetacion": MessageLookupByLibrary.simpleMessage(
      "Naturaleza",
    ),
    "libraryTaxonomySubPoliciaco": MessageLookupByLibrary.simpleMessage(
      "Policiaco",
    ),
    "libraryTaxonomySubPolitica": MessageLookupByLibrary.simpleMessage(
      "Política",
    ),
    "libraryTaxonomySubPosesionesExorcismos":
        MessageLookupByLibrary.simpleMessage("Posesiones / exorcismos"),
    "libraryTaxonomySubPosguerraEspanola": MessageLookupByLibrary.simpleMessage(
      "Posguerra española",
    ),
    "libraryTaxonomySubPostApocalipsis": MessageLookupByLibrary.simpleMessage(
      "Postapocalipsis",
    ),
    "libraryTaxonomySubPrecuela": MessageLookupByLibrary.simpleMessage(
      "Precuela",
    ),
    "libraryTaxonomySubPrehistoria": MessageLookupByLibrary.simpleMessage(
      "Prehistoria",
    ),
    "libraryTaxonomySubPrisionCarcel": MessageLookupByLibrary.simpleMessage(
      "Prisión / cárcel",
    ),
    "libraryTaxonomySubPsicopatia": MessageLookupByLibrary.simpleMessage(
      "Psicopatía",
    ),
    "libraryTaxonomySubRacismo": MessageLookupByLibrary.simpleMessage(
      "Racismo",
    ),
    "libraryTaxonomySubRealidadParalelaVirtual":
        MessageLookupByLibrary.simpleMessage("Realidad paralela / virtual"),
    "libraryTaxonomySubRealismoMagico": MessageLookupByLibrary.simpleMessage(
      "Realismo mágico",
    ),
    "libraryTaxonomySubReligion": MessageLookupByLibrary.simpleMessage(
      "Religión",
    ),
    "libraryTaxonomySubRemake": MessageLookupByLibrary.simpleMessage(
      "Remake / reboot",
    ),
    "libraryTaxonomySubRevolucionFrancesa":
        MessageLookupByLibrary.simpleMessage("Revolución francesa"),
    "libraryTaxonomySubRevolucionMexicana":
        MessageLookupByLibrary.simpleMessage("Revolución mexicana"),
    "libraryTaxonomySubRevolucionRusa": MessageLookupByLibrary.simpleMessage(
      "Revolución rusa",
    ),
    "libraryTaxonomySubRoadMovie": MessageLookupByLibrary.simpleMessage(
      "Road movie",
    ),
    "libraryTaxonomySubRobos": MessageLookupByLibrary.simpleMessage(
      "Robos / atracos",
    ),
    "libraryTaxonomySubRobotsAndroides": MessageLookupByLibrary.simpleMessage(
      "Robots / androides",
    ),
    "libraryTaxonomySubSamurais": MessageLookupByLibrary.simpleMessage(
      "Samuráis",
    ),
    "libraryTaxonomySubSatira": MessageLookupByLibrary.simpleMessage("Sátira"),
    "libraryTaxonomySubSectas": MessageLookupByLibrary.simpleMessage("Sectas"),
    "libraryTaxonomySubSecuela": MessageLookupByLibrary.simpleMessage(
      "Secuela",
    ),
    "libraryTaxonomySubSecuelaAlternativa":
        MessageLookupByLibrary.simpleMessage("Secuela alternativa"),
    "libraryTaxonomySubSecuestrosDesapariciones":
        MessageLookupByLibrary.simpleMessage("Secuestros / desapariciones"),
    "libraryTaxonomySubSerieB": MessageLookupByLibrary.simpleMessage("Serie B"),
    "libraryTaxonomySubSerieZ": MessageLookupByLibrary.simpleMessage("Serie Z"),
    "libraryTaxonomySubSexo": MessageLookupByLibrary.simpleMessage("Sexo"),
    "libraryTaxonomySubSitcom": MessageLookupByLibrary.simpleMessage("Sitcom"),
    "libraryTaxonomySubSketches": MessageLookupByLibrary.simpleMessage(
      "Sketches",
    ),
    "libraryTaxonomySubSlasher": MessageLookupByLibrary.simpleMessage(
      "Slasher",
    ),
    "libraryTaxonomySubSnuff": MessageLookupByLibrary.simpleMessage("Snuff"),
    "libraryTaxonomySubSobrenatural": MessageLookupByLibrary.simpleMessage(
      "Sobrenatural",
    ),
    "libraryTaxonomySubSpinOff": MessageLookupByLibrary.simpleMessage(
      "Spin-off",
    ),
    "libraryTaxonomySubSteampunk": MessageLookupByLibrary.simpleMessage(
      "Steampunk",
    ),
    "libraryTaxonomySubSuperheroes": MessageLookupByLibrary.simpleMessage(
      "Superhéroes",
    ),
    "libraryTaxonomySubSurrealismo": MessageLookupByLibrary.simpleMessage(
      "Surrealismo",
    ),
    "libraryTaxonomySubSurvivalSupervivencia":
        MessageLookupByLibrary.simpleMessage("Survival / supervivencia"),
    "libraryTaxonomySubTecnologiaInformatica":
        MessageLookupByLibrary.simpleMessage("Tecnología / informática"),
    "libraryTaxonomySubTelefilm": MessageLookupByLibrary.simpleMessage(
      "Telefilm",
    ),
    "libraryTaxonomySubTerrorismo": MessageLookupByLibrary.simpleMessage(
      "Terrorismo",
    ),
    "libraryTaxonomySubThrillerPsicologico":
        MessageLookupByLibrary.simpleMessage("Psicológico"),
    "libraryTaxonomySubTiburonesAsesinos": MessageLookupByLibrary.simpleMessage(
      "Tiburones asesinos",
    ),
    "libraryTaxonomySubTokusatsu": MessageLookupByLibrary.simpleMessage(
      "Tokusatsu",
    ),
    "libraryTaxonomySubTorturas": MessageLookupByLibrary.simpleMessage(
      "Torturas",
    ),
    "libraryTaxonomySubTransexualidadTransgenero":
        MessageLookupByLibrary.simpleMessage("Transexualidad / transgénero"),
    "libraryTaxonomySubVampiros": MessageLookupByLibrary.simpleMessage(
      "Vampirismo",
    ),
    "libraryTaxonomySubVenganza": MessageLookupByLibrary.simpleMessage(
      "Venganza",
    ),
    "libraryTaxonomySubViajeTemporal": MessageLookupByLibrary.simpleMessage(
      "Viaje temporal",
    ),
    "libraryTaxonomySubVikingos": MessageLookupByLibrary.simpleMessage(
      "Vikingos",
    ),
    "libraryTaxonomySubVisiones": MessageLookupByLibrary.simpleMessage(
      "Visiones",
    ),
    "libraryTaxonomySubVudu": MessageLookupByLibrary.simpleMessage("Vudú"),
    "libraryTaxonomySubWuxia": MessageLookupByLibrary.simpleMessage("Wuxia"),
    "libraryTaxonomySubZombiesInfectados": MessageLookupByLibrary.simpleMessage(
      "Zombies / infectados",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
    "membersEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Prueba con otra búsqueda o filtros",
    ),
    "membersEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No hay miembros",
    ),
    "membersErrorLoadTitle": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el directorio",
    ),
    "membersHomeCardSubtitle": MessageLookupByLibrary.simpleMessage(
      "Conecta con otros usuarios",
    ),
    "membersLabel": MessageLookupByLibrary.simpleMessage("Miembros"),
    "membersSearchApplyTooltip": MessageLookupByLibrary.simpleMessage(
      "Aplicar búsqueda",
    ),
    "membersSearchHint": MessageLookupByLibrary.simpleMessage(
      "Buscar miembro...",
    ),
    "membersSortAgeAsc": MessageLookupByLibrary.simpleMessage(
      "Edad (Ascendente)",
    ),
    "membersSortAgeDesc": MessageLookupByLibrary.simpleMessage(
      "Edad (Descendente)",
    ),
    "membersSortNameAsc": MessageLookupByLibrary.simpleMessage("Nombre (A-Z)"),
    "membersSortNameDesc": MessageLookupByLibrary.simpleMessage("Nombre (Z-A)"),
    "membersSortRegisteredAsc": MessageLookupByLibrary.simpleMessage(
      "Registro (más antiguo primero)",
    ),
    "membersSortRegisteredDesc": MessageLookupByLibrary.simpleMessage(
      "Registro (más reciente primero)",
    ),
    "menuActivity": MessageLookupByLibrary.simpleMessage("Actividad"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Social media",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Home"),
    "menuLibrary": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully.",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Could not delete account.",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Account deleted successfully.",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong.",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Could not update profile.",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully.",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Delete this message?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("Message deleted"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("edited"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "You have no conversations yet.",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Could not delete the message.",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Could not edit the message.",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Could not send the message.",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "No messages yet. Say something!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Read"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Send"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Sent"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Write a message...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "nextLabel": MessageLookupByLibrary.simpleMessage("Siguiente"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("No more items."),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Delete all notifications?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Mark all notifications as read?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Could not mark the notification as read.",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notification marked as read.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "All notifications marked as read.",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Could not delete notifications.",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notifications deleted.",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "You have no notifications.",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Device notification permissions",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Open settings",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("OFF"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ON"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications in the browser",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Password reset successfully.",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "At least 6 characters",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "previousLabel": MessageLookupByLibrary.simpleMessage("Anterior"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Privacy policy",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Private messages"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "User profile",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Push notifications",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Could not verify the captcha. Please try again.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Registration error"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "I agree to receive promotions and marketing communications",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "I have read and accept the",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "You must accept the terms and conditions and privacy policy",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Remove date",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Remove country",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviewsLabel": MessageLookupByLibrary.simpleMessage("Reseñas"),
    "searchPlaceholder": MessageLookupByLibrary.simpleMessage("Texto a buscar"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send code"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("Send message"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Share"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Share"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("View my profile"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Show QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Create account"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Follow us on social media.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Could not open the link.",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Could not open WhatsApp.",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "sortByLabel": MessageLookupByLibrary.simpleMessage("Ordenar por"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Filmaniak contact"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Terms and conditions",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Need help? Reach us through any of our channels and we will get back to you as soon as possible.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Display name",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Date of birth",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage(
      "Country",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light mode"),
    "titleDisplayModeLabel": MessageLookupByLibrary.simpleMessage(
      "Mostrar títulos",
    ),
    "titleDisplayModeLocalized": MessageLookupByLibrary.simpleMessage(
      "En mi idioma",
    ),
    "titleDisplayModeOriginal": MessageLookupByLibrary.simpleMessage(
      "Título original",
    ),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Bio"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "We could not find this user.",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("Username or email"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contact"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQs"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Log out"),
    "userYears": MessageLookupByLibrary.simpleMessage("years old"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "At least 4 characters",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Verification code (6 digits)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "viewGridLabel": MessageLookupByLibrary.simpleMessage("Cuadrícula"),
    "viewListLabel": MessageLookupByLibrary.simpleMessage("Lista"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://yoursite.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Website / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Start of week"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect credentials",
    ),
  };
}
