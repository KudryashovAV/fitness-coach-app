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
          backgroundColor: Color.fromARGB(255, 239, 214, 22),
          title: Column(
            children: [
              Text(
                'Вы уверены?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Divider(
                color: Colors.red,
                thickness: 2,
              )
            ],
          ),
          content: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: [
            PhysicalModel(
              color: Color.fromARGB(255, 245, 124, 43),
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Нет',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            PhysicalModel(
              color: Color.fromARGB(255, 52, 252, 2),
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              child: TextButton(
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
                child: Text(
                  'Да',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
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
    return PhysicalModel(
      color: athleteCtrl.setCardInputsColor(athleteData),
      elevation: 15,
      borderRadius: BorderRadius.circular(30),
      child: TextButton(
        onPressed: () {
          _showConfirmationDialog(context, setTitle(condition));
        },
        style: TextButton.styleFrom(
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
      ),
    );
  }
}
