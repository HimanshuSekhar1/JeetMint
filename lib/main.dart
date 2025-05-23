// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';
import 'screens/phone_login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
void main() {  
  runApp(const KarodsApp());
}

class KarodsApp extends StatelessWidget {
  const KarodsApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'JeetMint',
          theme: ThemeData(
            fontFamily: 'Inter',
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: const Color(0xFF8C8AFA),
            textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          getPages: [
            GetPage(name: '/splash', page: () => const SplashScreen()),
            GetPage(name: '/intro', page: () => const IntroScreen()),
            GetPage(name: '/login', page: () => const LoginScreen()),
            GetPage(name: '/phone', page: () => const PhoneLoginScreen()),
            GetPage(name: '/signup', page: () => const SignUpScreen()),
            GetPage(name: '/home', page: () => const HomeScreen()),
          ],
    );
  }
}
