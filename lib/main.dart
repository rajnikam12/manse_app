import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:manse_app/constants/assets.dart';
import 'package:manse_app/navigation_menu.dart';
import 'package:manse_app/services/theme.dart';
import 'package:manse_app/splash_screen.dart';
import 'package:manse_app/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseService.initialize();
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
