import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import '../widgets/custom_button.dart';
import '../providers/language_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<Locale>(
                  value: languageProvider.locale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      languageProvider.setLocale(newLocale);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/english.png',
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text('English'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: const Locale('fr'),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/french.png',
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text('Français'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: const Locale('ar'),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/arabic.png',
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text('العربية'),
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/image1.png",
                  height: 300,
                ),
                const SizedBox(height: 20),
                Text(
                  languageProvider.getTranslation('title'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  languageProvider.getTranslation('subtitle'),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    text: languageProvider.getTranslation('button_text'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
