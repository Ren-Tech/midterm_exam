class Habit {
  final String name;
  final String details;
  final DateTime createdAt;
  final List<DateTime> completionDates;

  Habit({
    required this.name,
    required this.details,
    required this.createdAt,
    List<DateTime>? completionDates,
  }) : completionDates = completionDates ?? [];

  bool isCompleted(DateTime date) {
    return completionDates.any((completionDate) =>
        completionDate.year == date.year &&
        completionDate.month == date.month &&
        completionDate.day == date.day);
  }

  void complete() {
    completionDates.add(DateTime.now());
  }

  void undoCompletion() {
    completionDates.removeWhere((date) =>
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day);
  }
}
