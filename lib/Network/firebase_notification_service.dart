import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔥 Background: ${message.messageId}");
}

class FirebaseNotificationService {
  static Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    print("🔔 Permission: ${settings.authorizationStatus}");

    String? token = await messaging.getToken();
    print("🔑 FCM Token: $token");

    FirebaseMessaging.onMessage.listen((message) {
      print("📩 Foreground Notification: ${message.notification?.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("🚀 App opened from notification");
      print(message.data);
    });
  }
}
