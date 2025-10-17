import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = []; // Start with an empty list

  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(String title, String? description, DateTime? reminder) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      reminder: reminder,
      isCompleted: false,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void editTask(String id, String newTitle, String? newDescription, DateTime? newReminder) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex].title = newTitle;
      _tasks[taskIndex].description = newDescription;
      _tasks[taskIndex].reminder = newReminder;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}