// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';
import 'screens/phone_login_screen.dart';
import 'screens/signup_screen.dart';
void main() {
  runApp(const JeetMintApp());
}

class JeetMintApp extends StatelessWidget {
  const JeetMintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/intro', page: () => const IntroScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/phone', page: () => const PhoneLoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
      ],
    );
  }
}
