import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sleeping_beauty_app/Screen/Auth/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("spash init");
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => IntoScreen()),
      );
    });
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
  @override
  void initState() {
    super.initState();
    print("spash init");
    Timer(const Duration(seconds: 2), () {
      print("Intro Click");
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Image.asset(
            'assets/intro.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}