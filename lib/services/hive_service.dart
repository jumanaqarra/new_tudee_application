import 'package:hive_flutter/hive_flutter.dart';

import '../model/task_model.dart';

class HiveService {
  // صندوق المهام وصندوق الإعدادات (فيه الاسم)
  static late Box tasksBox;
  static late Box settingsBox;

  // بنستدعيها مرة وحدة بأول التطبيق
  static Future<void> init() async {
    await Hive.initFlutter();
    tasksBox = await Hive.openBox('tasks');
    settingsBox = await Hive.openBox('settings');
  }

  // ---------- الاسم ----------

  static String? getName() {
    return settingsBox.get('name');
  }

  static Future<void> saveName(String name) async {
    await settingsBox.put('name', name);
  }

  // ---------- المهام ----------

  static Future<void> addTask(String title) async {
    // add بتعطي المهمة رقم (key) لحالها
    await tasksBox.add({'title': title, 'isDone': false});
  }

  static Future<void> updateTask(int id, String title, bool isDone) async {
    await tasksBox.put(id, {'title': title, 'isDone': isDone});
  }

  static Future<void> deleteTask(int id) async {
    await tasksBox.delete(id);
  }

  // بترجع كل المهام كلستة من TaskModel
  static List<TaskModel> getTasks() {
    List<TaskModel> tasks = [];
    for (var key in tasksBox.keys) {
      final data = tasksBox.get(key);
      tasks.add(TaskModel.fromMap(key, data));
    }
    return tasks;
  }
}
