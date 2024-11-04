import '../models/habit.dart';

class HabitService {
  static final HabitService _instance = HabitService._internal();
  factory HabitService() => _instance;

  HabitService._internal();

  final List<Habit> _habits = [];

  List<Habit> getHabits() => _habits;

  void addHabit(Habit habit) {
    _habits.add(habit);
  }
}
