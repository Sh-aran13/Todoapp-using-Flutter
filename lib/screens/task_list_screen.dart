import 'package:flutter/material.dart';
import 'package:myapp/widgets/task_list.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: const TaskList(),
    );
  }
}
