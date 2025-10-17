import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty) {
      return;
    }
    Provider.of<TaskProvider>(context, listen: false).addTask(
      _titleController.text,
      _descriptionController.text,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  Future<void> _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.tealAccent,
              onPrimary: Colors.black,
              surface: Color(0xFF212121),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF303030),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.tealAccent,
              ),
            ),
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: Color(0xFF212121),
              headerForegroundColor: Colors.tealAccent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate == null) {
      return;
    }

    if (!mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.tealAccent,
              onPrimary: Colors.black,
              surface: Color(0xFF212121),
              onSurface: Colors.white,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color(0xFF303030),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodTextColor: Colors.white,
              dialHandColor: Colors.tealAccent,
              dialTextColor: Colors.white,
              entryModeIconColor: Colors.tealAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.tealAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime == null) {
      return;
    }
    setState(() {
      _selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xCC424242), // Colors.grey[850]!.withOpacity(0.8)
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add a new task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 24),
              _buildTextField(controller: _titleController, label: 'Title'),
              const SizedBox(height: 16),
              _buildTextField(controller: _descriptionController, label: 'Description (Optional)'),
              const SizedBox(height: 24),
              _buildReminderSelector(),
              const SizedBox(height: 32),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0x4D000000), // Colors.black.withOpacity(0.3)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (_) => _submitData(),
    );
  }

  Widget _buildReminderSelector() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _selectedDate == null
                ? 'No Reminder Set'
                : 'Reminder: ${DateFormat.yMd().add_jm().format(_selectedDate!)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        TextButton.icon(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.timer_outlined, color: Colors.tealAccent, size: 22),
          label: const Text(
            'Set Reminder',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.tealAccent, fontSize: 16),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.white70, fontSize: 16)),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.tealAccent, Colors.cyanAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.tealAccent.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: _submitData,
            icon: const Icon(Icons.add, size: 20, color: Colors.black),
            label: const Text(
              'Add Task',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
