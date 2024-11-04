import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';

class HabitDetailsScreen extends StatelessWidget {
  final Habit habit;

  const HabitDetailsScreen({Key? key, required this.habit}) : super(key: key);

  String _getStreakText() {
    if (habit.completionDates.isEmpty) return 'No streak yet';

    final now = DateTime.now();
    final lastCompletion = habit.completionDates.last;
    final difference = now.difference(lastCompletion).inDays;

    if (difference == 0) return 'Completed today!';
    if (difference == 1) return 'Last completed yesterday';
    return 'Last completed $difference days ago';
  }

  Color _getStreakColor() {
    if (habit.completionDates.isEmpty) return Colors.grey;

    final now = DateTime.now();
    final lastCompletion = habit.completionDates.last;
    final difference = now.difference(lastCompletion).inDays;

    if (difference == 0) return Colors.green;
    if (difference == 1) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStreakColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStreakText(),
                            style: TextStyle(
                              color: _getStreakColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      habit.details,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Created on ${DateFormat('MMMM d, yyyy').format(habit.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Completion History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final date = habit.completionDates[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      DateFormat('EEEE, MMMM d, yyyy').format(date),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      DateFormat('jm').format(date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
              childCount: habit.completionDates.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }
}
