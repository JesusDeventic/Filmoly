// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart

// ignore_for_file: implementation_imports, file_names, unnecessary_new
// ignore_for_file: unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file: argument_type_not_assignable, invalid_assignment
// ignore_for_file: prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file: comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' as messages_ar;
import 'messages_ca.dart' as messages_ca;
import 'messages_de.dart' as messages_de;
import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;
import 'messages_fr.dart' as messages_fr;
import 'messages_hi.dart' as messages_hi;
import 'messages_it.dart' as messages_it;
import 'messages_ja.dart' as messages_ja;
import 'messages_ko.dart' as messages_ko;
import 'messages_nl.dart' as messages_nl;
import 'messages_pl.dart' as messages_pl;
import 'messages_pt.dart' as messages_pt;
import 'messages_ro.dart' as messages_ro;
import 'messages_ru.dart' as messages_ru;
import 'messages_sv.dart' as messages_sv;
import 'messages_tr.dart' as messages_tr;
import 'messages_uk.dart' as messages_uk;
import 'messages_zh.dart' as messages_zh;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => SynchronousFuture(null),
  'ca': () => SynchronousFuture(null),
  'de': () => SynchronousFuture(null),
  'en': () => SynchronousFuture(null),
  'es': () => SynchronousFuture(null),
  'fr': () => SynchronousFuture(null),
  'hi': () => SynchronousFuture(null),
  'it': () => SynchronousFuture(null),
  'ja': () => SynchronousFuture(null),
  'ko': () => SynchronousFuture(null),
  'nl': () => SynchronousFuture(null),
  'pl': () => SynchronousFuture(null),
  'pt': () => SynchronousFuture(null),
  'ro': () => SynchronousFuture(null),
  'ru': () => SynchronousFuture(null),
  'sv': () => SynchronousFuture(null),
  'tr': () => SynchronousFuture(null),
  'uk': () => SynchronousFuture(null),
  'zh': () => SynchronousFuture(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'ca':
      return messages_ca.messages;
    case 'de':
      return messages_de.messages;
    case 'en':
      return messages_en.messages;
    case 'es':
      return messages_es.messages;
    case 'fr':
      return messages_fr.messages;
    case 'hi':
      return messages_hi.messages;
    case 'it':
      return messages_it.messages;
    case 'ja':
      return messages_ja.messages;
    case 'ko':
      return messages_ko.messages;
    case 'nl':
      return messages_nl.messages;
    case 'pl':
      return messages_pl.messages;
    case 'pt':
      return messages_pt.messages;
    case 'ro':
      return messages_ro.messages;
    case 'ru':
      return messages_ru.messages;
    case 'sv':
      return messages_sv.messages;
    case 'tr':
      return messages_tr.messages;
    case 'uk':
      return messages_uk.messages;
    case 'zh':
      return messages_zh.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null,
  );
  if (availableLocale == null) {
    return SynchronousFuture(false);
  }
  var lib = _deferredLibraries[availableLocale];
  lib == null ? SynchronousFuture(false) : lib();
  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return SynchronousFuture(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale = Intl.verifiedLocale(
    locale,
    _messagesExistFor,
    onFailure: (_) => null,
  );
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
