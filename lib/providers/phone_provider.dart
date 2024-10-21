import 'package:flutter/material.dart';

class PhoneProvider extends ChangeNotifier {
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
      'title': "Register",
      'subtitle': "Add your phone number. We'll send you a verification code.",
      'button_text': "Send !",
      'phoneNumberInput': "Enter your phone number",
    },
    'fr': {
      'title': "S'inscrire",
      'subtitle':
          "Ajoutez votre numéro de téléphone. Nous vous enverrons un code de vérification.",
      'button_text': "Envoyer !",
      'phoneNumberInput': "Entée votre numero de Téléphone",
    },
    'ar': {
      'title': "تسجيل",
      'subtitle': "أضف رقم هاتفك. سنرسل لك رمز التحقق.",
      'button_text': "إرسال!",
      'phoneNumberInput': "أدخل رقم هاتفك",
    },
  };
}
