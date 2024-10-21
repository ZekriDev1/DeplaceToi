import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'providers/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/OTP_screen.dart'; // Import your OTPScreen
import 'screens/app_screen.dart'; // Import your AppScreen
import 'screens/name_entry_screen.dart'; // Import your NameEntryScreen

// Function to check sign-in status
Future<bool> _checkSignInStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('signed_in') ?? false;
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: FutureBuilder<bool>(
            future: _checkSignInStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data == true) {
                  return HomeScreen();
                } else {
                  return const WelcomeScreen();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          title: "Déplace Toi",
        );
      },
    );
  }
}
