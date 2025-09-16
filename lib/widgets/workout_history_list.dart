import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryList extends StatelessWidget {
  final athletesCtrl = Get.put(AthletesController());
  final dynamic athleteId;
  WorkoutHistoryList({required this.athleteId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: athletesCtrl.fetchWorkoutHistory(athleteId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Списаний и начислений не обнаружено'));
        }

        final transactions = snapshot.data!;
        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              title: Text(transaction['title']),
              subtitle: Text(DateFormat('dd.MM.yyyy HH:mm:ss')
                  .format(transaction['createdAt'].toDate())),
            );
          },
        );
      },
    );
  }
}
