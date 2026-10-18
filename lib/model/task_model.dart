class TaskModel {
  final int id;
  final String title;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  // بتحول الماب المخزنة بالـ Hive إلى TaskModel
  factory TaskModel.fromMap(int id, Map data) {
    return TaskModel(
      id: id,
      title: data['title'] as String? ?? '',
      isDone: data['isDone'] as bool? ?? false,
    );
  }
}
