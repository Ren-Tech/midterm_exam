import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  HabitCard({required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(habit.name),
        subtitle: Text(habit.completionDates.toString()),
        trailing: Checkbox(
          value: habit.isCompleted(DateTime.now()),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
