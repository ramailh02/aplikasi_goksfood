import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const GoksFoodApp());
}

class GoksFoodApp extends StatelessWidget {
  const GoksFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goks Food',
      theme: ThemeData(
        primaryColor: AppColors.primaryPink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(), // Memulai aplikasi dari Splash Screen
    );
  }
}