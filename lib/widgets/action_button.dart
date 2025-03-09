import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButton extends StatelessWidget {
  final athleteCtrl = Get.put(AthletesController());
  final String athleteId;
  final String title;
  final String condition;
  final dynamic athleteData;

  ActionButton(
      {required this.title,
      required this.condition,
      required this.athleteId,
      required this.athleteData,
      super.key});

  void _showConfirmationDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Вы уверены?'),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                athleteCtrl.updateAthleteWorkouts(
                  athleteId,
                  athleteData['name'],
                  athleteData['phone'],
                  athleteData['workouts'],
                  condition,
                );
              },
              child: Text('Да'),
            ),
          ],
        );
      },
    );
  }

  String setTitle(type) {
    switch (type) {
      case 'decrease':
        return 'Вы уверены, что хотите списать тренировку?';
      case 'increase 10':
        return 'Вы уверены, что хотите добавить тренировку?';
      case 'increase 1':
        return 'Вы уверены, что хотите добавить тренировку?';
      default:
        return 'Вы уверены, что хотите списать тренировку?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showConfirmationDialog(context, setTitle(condition));
      },
      style: TextButton.styleFrom(
        backgroundColor: athleteCtrl.setCardInputsColor(athleteData),
        padding: EdgeInsets.all(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
