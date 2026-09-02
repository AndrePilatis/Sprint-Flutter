import 'package:flutter/material.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const LactareApp());
}

class LactareApp extends StatelessWidget {
  const LactareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lactare · Painel BLH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D4AAE)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(filled: true),
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
