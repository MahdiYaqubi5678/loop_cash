import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lp_loopcash/database/expense_database.dart';
import 'package:lp_loopcash/database/income_database.dart';
import 'package:provider/provider.dart';
import 'onboarding/onboarding.dart';
import 'theme/theme_provider.dart';
import 'shop/model/shop.dart';
import 'dart:html' as html;

Future<void> requestPersistentStorage() async {
  var navigator = html.window.navigator;
  if (navigator.storage != null) {
    bool granted = await navigator.storage!.persist();
    print("🔹 Storage persistence granted: $granted");
  } else {
    print("⚠️ Persistent storage API not supported.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // easy localization
  await EasyLocalization.ensureInitialized();

  // hive
  await Hive.initFlutter();
  await requestPersistentStorage(); 
  var box = await Hive.openBox('shopbox');
  print("🔹 Hive box opened successfully: ${box.isOpen}");

  // initialize the db
  await IncomeDatabase.initialize();
  await ExpenseDatabase.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'), Locale('ar'), Locale('fr'),
        Locale('fa'), Locale('zh'), Locale('ur'),
        Locale('hi'), Locale('pt'), Locale('es'),
      ],
      path: 'lib/assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Shop()),
        ChangeNotifierProvider(create: (context) => ExpenseDatabase()),
        ChangeNotifierProvider(create: (context) => IncomeDatabase()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const Onboarding(),
            theme: themeProvider.themeData,
          );
        },
      ),
    );
  }
}