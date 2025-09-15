import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manse_app/constants/assets.dart';
import 'package:manse_app/navigation_menu.dart';
import 'package:manse_app/services/theme.dart';
import 'package:manse_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MNS App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(
        nextScreen: NavigationMenu(),
        logoPath: Assets.assetsImagesLogo,
      ),
    );
  }
}
