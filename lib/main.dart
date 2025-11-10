import 'package:flutter/material.dart';
import 'dart:async';
import 'Screen/Auth/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final translationManager = TranslationManager();
  await translationManager.init();



  bool isUserFirstTime = await LocalStorageHelper.getFlag();

  if (isUserFirstTime == false){
    LocalStorageHelper.saveFlag(true);
    await translationManager.setLanguage('GR');
  }

  runApp(
    ChangeNotifierProvider<TranslationManager>.value(
      value: translationManager,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
        builder: EasyLoading.init(),
      home: SplashScreen(),
    );
  }
}

class LocalStorageHelper {
  static const String _keyFlag = "MyFlag";

  /// Save true or false
  static Future<void> saveFlag(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFlag, value);
  }

  /// Get saved value (default false if not set)
  static Future<bool> getFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFlag) ?? false;
  }
}
