class Task {
  String id;
  String title;
  String? description;
  DateTime? reminder;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.reminder,
    required this.isCompleted,
  });
}
