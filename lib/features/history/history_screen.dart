import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../data/models/day_summary.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<DaySummary>('summaries');
    final days = box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: days.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, i) {
                final d = days[i];
                return ListTile(
                  title: Text(
                    '${d.date.year}-${d.date.month}-${d.date.day}',
                  ),
                  subtitle: Text(d.status.name),
                );
              },
            ),
    );
  }
}
