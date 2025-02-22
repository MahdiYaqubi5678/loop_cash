import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  IntroPage1({super.key});

  final List<Map<String, dynamic>> languages = [
    {"name": "English", "locale": const Locale('en')},
    {"name": "العربية", "locale": const Locale('ar')},
    {"name": "Français", "locale": const Locale('fr')},
    {"name": "فارسی", "locale": const Locale('fa')},
    {"name": "Português", "locale": const Locale('pt')},
    {"name": "اردو", "locale": const Locale('ur')},
    {"name": "हिन्दी", "locale": const Locale('hi')},
    {"name": "中文", "locale": const Locale('zh')},
    {"name": "Español", "locale": const Locale('es')},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          
          // text
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'choose_language'.tr(),
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 20,
              ),
            ),
          ),
          
          // language
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(top: 15, right: 25, left: 25),
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    title: Text(languages[index]["name"]),
                    trailing: const Icon(Icons.language),
                    onTap: () {
                      context.setLocale(languages[index]["locale"]);
                    },
                  ),
                );
              },
            ),
          ),

          // sized box
          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}