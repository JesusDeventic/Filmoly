// ignore_for_file: implementation_imports

import 'dart:math' show max;

import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';

/// Selector de país con la misma hoja que el resto de la app (cabecera primary + cerrar).
///
/// Usa [CountryListView] del paquete `country_picker` (no exportado públicamente).
Future<void> showFilmaniakCountryPicker({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  CustomFlagBuilder? customFlagBuilder,
  CountryListThemeData? countryListTheme,
  bool searchAutofocus = false,
  bool showWorldWide = false,
  bool showSearch = true,
  String? title,
  double titleFontSize = 18,
}) {
  assert(
    exclude == null || countryFilter == null,
    'Cannot provide both exclude and countryFilter',
  );

  return showDraggableAppSheet(
    context,
    title: title ?? S.current.textfieldUserCountryLabel,
    titleFontSize: titleFontSize,
    intrinsicHeight: true,
    intrinsicContentPadding: EdgeInsets.zero,
    maxIntrinsicFraction: 0.92,
    bodyBuilder: (_) => Builder(
      builder: (ctx) {
        final media = MediaQuery.of(ctx);
        final maxScrollHeight = max(
          200.0,
          media.size.height * 0.92 - 110,
        );
        return SizedBox(
          height: maxScrollHeight,
          child: CountryListView(
            onSelect: onSelect,
            exclude: exclude,
            favorite: favorite,
            countryFilter: countryFilter,
            showPhoneCode: showPhoneCode,
            customFlagBuilder: customFlagBuilder,
            countryListTheme: countryListTheme,
            searchAutofocus: searchAutofocus,
            showWorldWide: showWorldWide,
            showSearch: showSearch,
          ),
        );
      },
    ),
  ).whenComplete(() {
    if (onClosed != null) onClosed();
  });
}
