import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  String getTranslation(String key) {
    final translations = _localizedStrings[_locale.languageCode] ?? {};
    return translations[key] ?? key;
  }

  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': "Let's Get started",
      'subtitle': "Never a better time than now to start.",
      'button_text': "Get Started",
    },
    'fr': {
      'title': "Commençons",
      'subtitle':
          "Il n'y a jamais eu de meilleur moment que maintenant pour commencer.",
      'button_text': "Commencer",
    },
    'ar': {
      'title': "هيا بنا نبدأ",
      'subtitle': "لا يوجد وقت أفضل من الآن للبدء.",
      'button_text': "ابدأ",
    },
  };
}
