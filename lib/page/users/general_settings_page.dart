import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:filmoly/providers/theme_provider.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/core/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/// Ajustes generales de Filmoly (idioma, tema, inicio de semana, formato fecha).
class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  String _weekStart = 'monday';
  String _dateFormat = 'dd/MM/yyyy';
  bool _isEditing = false;

  late bool _initialIsDarkMode;
  late String _initialLanguage;
  late String _initialWeekStart;
  late String _initialDateFormat;

  final _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    _loadInitialValues();
  }

  Future<Map<String, bool>> _confirmChangesDialog() async {
    final result = await showDialog<Map<String, bool>>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.dialogWarningTitle),
          content: Text(
            S.current.dialogConfirmSave,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop({"saved": false, "success": false});
                    },
                    child: Text(
                      S.current.actionNo,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final ok = await _saveSettings();
                      Navigator.of(context)
                          .pop({"saved": true, "success": ok});
                    },
                    child: Text(
                      S.current.actionYes,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    return result ?? {"saved": false, "success": false};
  }

  Future<void> _loadInitialValues() async {
    // Tema e idioma iniciales
    _initialIsDarkMode = context.read<ThemeProvider>().isDarkMode;
    _initialLanguage = context.read<LanguageProvider>().currentLanguage;

    // Semana y formato fecha desde prefs (si existen)
    final savedWeekStart = await _prefs.getWeekStart();
    final savedDateFormat = await _prefs.getDateFormat();

    setState(() {
      if (savedWeekStart == 'sunday' || savedWeekStart == 'monday') {
        _weekStart = savedWeekStart!;
      }
      if (savedDateFormat != null && savedDateFormat.isNotEmpty) {
        _dateFormat = savedDateFormat;
      }
      _initialWeekStart = _weekStart;
      _initialDateFormat = _dateFormat;
    });
  }

  Future<bool> _saveSettings() async {
    try {
      await _prefs.setWeekStart(_weekStart);
      await _prefs.setDateFormat(_dateFormat);
      // De momento solo persistimos en local; más adelante se llamará al endpoint WP.
      showCustomSnackBar(S.current.success, type: 1);
      setState(() {
        _initialWeekStart = _weekStart;
        _initialDateFormat = _dateFormat;
        _initialIsDarkMode = context.read<ThemeProvider>().isDarkMode;
        _initialLanguage = context.read<LanguageProvider>().currentLanguage;
        _isEditing = false;
      });
      return true;
    } catch (_) {
      showCustomSnackBar(S.current.error, type: -1);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.current;
    final now = DateTime.now();
    final dateFormatsList = [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'MM/dd/yyyy',
      'MM-dd-yyyy',
      'yyyy/MM/dd',
      'yyyy-MM-dd',
    ];

    String formatExample(String pattern) {
      return DateFormat(pattern).format(now);
    }

    return PopScope(
      canPop: !_isEditing,
      onPopInvoked: (didPop) async {
        if (_isEditing && !didPop) {
          final result = await _confirmChangesDialog();
          if (result["success"] == true || !_isEditing) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.generalSettings),
          actions: [
            // Botón editar
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
              ),
            // Botones cancelar / guardar cuando se edita
            if (_isEditing)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () async {
                      final result = await _confirmChangesDialog();
                      if (result["saved"] == false) {
                        // restaurar valores iniciales
                        final themeProvider = context.read<ThemeProvider>();
                        final langProvider = context.read<LanguageProvider>();

                        if (themeProvider.isDarkMode != _initialIsDarkMode) {
                          await themeProvider.toggleTheme();
                        }
                        if (langProvider.currentLanguage != _initialLanguage) {
                          await langProvider.changeLanguage(_initialLanguage);
                        }
                        setState(() {
                          _weekStart = _initialWeekStart;
                          _dateFormat = _initialDateFormat;
                          _isEditing = false;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: () {
                      _saveSettings();
                    },
                  ),
                ],
              ),
            const SizedBox(width: 8),
          ],
        ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Idioma (fila como en Fitcron)
              Row(
                children: [
                  const Icon(Icons.language_rounded),
                  const SizedBox(width: 8),
                  Text(
                    l10n.language,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _LanguageSelectorSettings(isEditing: _isEditing),
              const SizedBox(height: 16),

              // Tema (toggle grande como Fitcron)
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return customToggleButtons(
                    context: context,
                    isEditing: _isEditing,
                    options: [l10n.themeLight, l10n.themeDark],
                    isSelected: [
                      !themeProvider.isDarkMode,
                      themeProvider.isDarkMode,
                    ],
                    onPressed: _isEditing
                        ? (_) => themeProvider.toggleTheme()
                        : (_) {},
                    title: l10n.theme,
                    icon: Icons.settings_display_rounded,
                    customChildren: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.wb_sunny_rounded, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              l10n.themeLight,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.nightlight_round, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              l10n.themeDark,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              // Día de inicio de la semana (toggle como Fitcron)
              customToggleButtons(
                context: context,
                isEditing: _isEditing,
                options: [l10n.weekStartSunday, l10n.weekStartMonday],
                isSelected: [
                  _weekStart == 'sunday',
                  _weekStart == 'monday',
                ],
                onPressed: (index) {
                  if (!_isEditing) return;
                  setState(() {
                    _weekStart = index == 0 ? 'sunday' : 'monday';
                  });
                },
                title: l10n.weekStart,
                icon: Icons.filter_1_rounded,
              ),

              const SizedBox(height: 16),

              // Formato de fecha (etiqueta + ejemplo + desplegable sencillo)
              Row(
                children: [
                  const Icon(Icons.date_range_rounded),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${l10n.dateFormat} (${formatExample(_dateFormat)})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _dateFormat,
                isExpanded: true,
                onChanged: _isEditing
                    ? (v) {
                        if (v == null) return;
                        setState(() => _dateFormat = v);
                      }
                    : null,
                items: dateFormatsList.map((pattern) {
                  return DropdownMenuItem<String>(
                    value: pattern,
                    child: Text('$pattern   (${formatExample(pattern)})'),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class _LanguageSelectorSettings extends StatelessWidget {
  const _LanguageSelectorSettings({required this.isEditing});

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return SizedBox(
      width: double.infinity,
      child: PopupMenuButton<String>(
        enabled: isEditing,
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
                style: const TextStyle(fontSize: 20),
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
    );
  }
}

