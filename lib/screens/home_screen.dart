import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import 'add_habit_screen.dart';
import 'habit_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitService habitService = HabitService();

  void _toggleCompletion(Habit habit) {
    setState(() {
      if (habit.isCompleted(DateTime.now())) {
        habit.undoCompletion();
      } else {
        habit.complete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Habit Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddHabitScreen(),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: habitService.getHabits().length,
          itemBuilder: (context, index) {
            Habit habit = habitService.getHabits()[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  habit.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Created: ${DateFormat('dd/MM/yyyy hh:mm a').format(habit.createdAt)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Checkbox(
                  value: habit.isCompleted(DateTime.now()),
                  onChanged: (value) {
                    _toggleCompletion(habit);
                  },
                  activeColor: Colors.teal,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HabitDetailsScreen(habit: habit),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
