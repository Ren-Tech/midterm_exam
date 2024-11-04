import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_habit_screen.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_habit': (context) => AddHabitScreen(),
      },
    );
  }
}
