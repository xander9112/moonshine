import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _storageKey = "CrmNeolfex_";
const List<List<String>> _supportedLanguages = [
  ['en', 'US'],
  ['ru', 'RU']
];
FlutterSecureStorage _prefs = new FlutterSecureStorage();

class TranslationService {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  VoidCallback _onLocaleChangedCallback;

  ///
  /// Returns the list of supported Locales
  ///
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => new Locale(lang[0], lang[1]));

  ///
  /// Returns the list of available Locales
  ///
  Iterable<dynamic> availableLocales() => [
        {
          "name": "en",
          'value': 'English (US)',
        },
        {
          "name": "ru",
          'value': 'Русский - Russian',
        },
      ];

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String text(String key, {Map<String, dynamic> options}) {
    String translate = getTranslation(key, _localizedValues);

    if (options != null) {
      options.keys.forEach((item) {
        translate = translate.replaceAll('_$item', options[item]);
      });
    }

    return translate;
  }

  getTranslation(String key, Map<String, dynamic> values) {
    List<String> keys = key.split('.');
    String firstKey = keys[0];

    if (values[firstKey].runtimeType == Null) {
      return key;
    }

    if (values[firstKey].runtimeType == String) {
      return values[firstKey];
    }

    keys.removeAt(0);
    return getTranslation(keys.join('.'), values[firstKey]);
  }

  ///
  /// Returns the current language code
  ///
  get currentLanguage => _locale == null ? '' : _locale.languageCode;

  ///
  /// Returns the current Locale
  ///
  get locale => _locale;

  ///
  /// One-time initialization
  ///
  Future<Null> init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  ///
  /// Routine to change the language
  ///
  Future<Null> setNewLanguage(
      [String newLanguage, bool saveInPrefs = false]) async {
    String language = newLanguage;
    if (language == null) {
      language = await getPreferredLanguage();
    }

    // Set the locale
    if (language == "") {
      language = "en";
    }
    _locale = Locale(language, "");

    // Load the language strings
    String jsonContent =
        await rootBundle.loadString("locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    // If we are asked to save the new language in the application preferences
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    // If there is a callback to invoke to notify that a language has changed
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback();
    }

    return null;
  }

  ///
  /// Callback to be invoked when the user changes the language
  ///
  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  ///
  /// Application Preferences related
  ///
  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  Future<String> _getApplicationSavedInformation(String name) async {
    return (await _prefs.read(key: _storageKey + name)) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    try {
      await _prefs.write(key: _storageKey + name, value: value);

      return true;
    } catch (_) {
      return false;
    }
  }

  ///
  /// Singleton Factory
  ///
  static final TranslationService _translationService =
      new TranslationService._internal();
  factory TranslationService() {
    return _translationService;
  }
  TranslationService._internal();
}
