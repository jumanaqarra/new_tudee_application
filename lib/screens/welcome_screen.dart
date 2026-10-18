import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../services/hive_service.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> start() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar('Oops', 'Please write your name');
      return;
    }

    // بنخزن الاسم بالـ Hive وبعدين بنروح عالصفحة الرئيسية
    await HiveService.saveName(name);
    Get.off(() => HomeScreen(name: name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tudeeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(32),
            const Text(
              'Welcome to Tudee',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const Gap(8),
            const Text(
              'What should we call you?',
              style: TextStyle(color: AppColors.textMuted),
            ),
            const Gap(24),
            TudeeTextField(controller: nameController, hint: 'Your name'),
            const Gap(16),
            PrimaryButton(label: "Let's start", onPressed: start),
          ],
        ),
      ),
    );
  }
}
