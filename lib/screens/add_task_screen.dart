import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../services/hive_service.dart';
import '../theme/app_theme.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> addTask() async {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      Get.snackbar('Oops', 'Task title cannot be empty');
      return;
    }

    await HiveService.addTask(title);
    Get.back();
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
            const Gap(16),
            const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const Gap(24),
            TudeeTextField(
              controller: titleController,
              hint: 'What needs to be done?',
              minLines: 3,
              maxLines: 5,
            ),
            const Gap(16),
            PrimaryButton(label: 'Add task', onPressed: addTask),
          ],
        ),
      ),
    );
  }
}
