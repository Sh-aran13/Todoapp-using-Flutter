import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import './edit_task_dialog.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  // Dialog to CONFIRM DELETION
  Future<void> _showDeleteConfirmDialog(
      BuildContext context, Task task, TaskProvider provider) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withAlpha(230),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.redAccent, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 60),
                const SizedBox(height: 15),
                const Text('Confirm Deletion', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Are you sure you want to delete this task?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70, fontSize: 16)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Delete', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        provider.deleteTask(task.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: tasks.length,
      itemBuilder: (ctx, i) => Card(
        key: ValueKey(tasks[i].id), // Unique key for each task item
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            tasks[i].title,
            style: TextStyle(
              decoration: tasks[i].isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tasks[i].description != null && tasks[i].description!.isNotEmpty)
                Text(tasks[i].description!),
              if (tasks[i].reminder != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Reminder: ${DateFormat.yMd().add_jm().format(tasks[i].reminder!)}',
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
            ],
          ),
          leading: Checkbox(
            value: tasks[i].isCompleted,
            onChanged: (value) {
              taskProvider.toggleTaskStatus(tasks[i].id);
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => EditTaskDialog(task: tasks[i]));
                },
                tooltip: 'Edit Task',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red.shade700,
                onPressed: () =>
                    _showDeleteConfirmDialog(context, tasks[i], taskProvider),
                tooltip: 'Delete Task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
