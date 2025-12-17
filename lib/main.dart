import 'package:flutter/material.dart';
import 'dart:async';
import 'Screen/Auth/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/Gloabal.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sleeping_beauty_app/Network/firebase_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sleeping_beauty_app/Screen/Auth/LoginScreen.dart';
import 'dart:io';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background Message Received: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();


  await Firebase.initializeApp();

  final translationManager = TranslationManager();
  await translationManager.init();

  // Background Notification Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Firebase Notification safelya
  try {
    await FirebaseNotificationService.init();
  } catch (e) {
    print("🔥 FirebaseNotificationService init error: $e");
  }

  bool isUserFirstTime = await LocalStorageHelper.getFlag();

  if (isUserFirstTime == false) {
    LocalStorageHelper.saveFlag(true);
    await translationManager.setLanguage('GR');
  }

  // Safe getToken
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  } catch (e) {
    print("🔥 getToken error: $e");
  }

  runApp(
    ChangeNotifierProvider<TranslationManager>.value(
      value: translationManager,
      child: const MyApp(),
    ),
  );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Firebase
//   await Firebase.initializeApp();
//
//   // Initialize translation manager
//   final translationManager = TranslationManager();
//   await translationManager.init();
//
//   // Initialize FireBase Notification
//   await FirebaseNotificationService.init();
//
//   // Background Notification Handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   bool isUserFirstTime = await LocalStorageHelper.getFlag();
//
//   if (isUserFirstTime == false) {
//     LocalStorageHelper.saveFlag(true);
//     await translationManager.setLanguage('GR');
//   }
//
//   FirebaseMessaging.instance.getToken().then((token) {
//     print("FCM Token: $token");
//   });
//
//   runApp(
//     ChangeNotifierProvider<TranslationManager>.value(
//       value: translationManager,
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, // Add this for global navigation
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
      initialRoute: '/', // Optional: initial route
      routes: {
        '/': (context) => SplashScreen(),  // your initial screen
        '/login': (context) => LoginScreen(), // your login screen
        // Add other screens here if needed
      },
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
