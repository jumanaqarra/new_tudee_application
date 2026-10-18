import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/hive_service.dart';
import 'theme/app_theme.dart';

void main() async {
  // أولاً: بجهز الفلاتر
  WidgetsFlutterBinding.ensureInitialized();

  // ثانياً: بفتح الـ Hive وبنستنى لحد ما يخلص
  await HiveService.init();

  runApp(const TudeeApp());
}

class TudeeApp extends StatelessWidget {
  const TudeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // بجيب الاسم المحفوظ (لو مش موجود بيرجع null)
    final name = HiveService.getName();

    return GetMaterialApp(
      title: 'Tudee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      // لو ما في اسم بنروح عالترحيب، وإلا عالصفحة الرئيسية
      home: (name == null || name.trim().isEmpty)
          ? const WelcomeScreen()
          : HomeScreen(name: name),
    );
  }
}
