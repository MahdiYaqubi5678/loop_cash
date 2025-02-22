import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePage extends StatelessWidget {
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

  LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title'.tr())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'choose_language'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
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
        ],
      ),
    );
  }
}
