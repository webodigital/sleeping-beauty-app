import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sleeping_beauty_app/Screen/Auth/LoginScreen.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/TabbarScreen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sleeping_beauty_app/Screen/Auth/LoginScreen.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/TabbarScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      checkIsUserLogin();
    });
  }

  void checkIsUserLogin() async {
    final isUserLogin = await getIsUserLogin();
    if (!mounted) return;

    if (isUserLogin == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TabBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => IntoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class IntoScreen extends StatefulWidget {
  @override
  _IntoScreenState createState() => _IntoScreenState();
}

class _IntoScreenState extends State<IntoScreen> {

  bool isIPad = false;

  @override
  void initState() {
    super.initState();
    _checkDevice();
    print("splash init");
  }

  Future<void> _checkDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;

    if (iosInfo.name?.toLowerCase().contains("ipad") ?? false) {
      setState(() {
        isIPad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget imageWidget;

    if (isIPad) {
      imageWidget = SafeArea(
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset("assets/intro.png"),
          ),
        ),
      );
    } else {
      imageWidget = Center(
        child: Image.asset(
          'assets/intro.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          print("Intro Click");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        },
        child: imageWidget,
      ),
    );
  }
}
