import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteCard extends StatelessWidget {
  final athleteCtrl = Get.put(AthletesController());
  AthleteCard({required this.athleteData, required this.athleteId, super.key});
  final dynamic athleteData;
  final String athleteId;

  String workoutTitle(count) {
    final countStringify = count.toString();

    switch (countStringify[countStringify.length - 1]) {
      case '1':
        return 'тренировка';
      case '2' || '3' || '4':
        return 'тренировки';
      default:
        return 'тренировок';
    }
  }

  dynamic setCardColor() {
    if (int.parse(athleteData['workouts']) <= 0) {
      return const Color.fromARGB(255, 228, 30, 12);
    }

    if (int.parse(athleteData['workouts']) > 8) {
      return const Color.fromARGB(255, 136, 235, 114);
    } else {
      if (int.parse(athleteData['workouts']) < 3) {
        return const Color.fromARGB(255, 240, 167, 103);
      } else {
        return Colors.orange;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: setCardColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              athleteData['name'] ?? 'Безымянный спортсмен',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: athleteCtrl.setCardInputsColor(athleteData),
                    ),
                    child: Text(
                      athleteData['phone'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: athleteCtrl.setCardInputsColor(athleteData),
                    ),
                    child: Text(
                      'Осталось ${athleteData['workouts']} ${workoutTitle(athleteData['workouts'])}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    title: 'Списать тренировку',
                    condition: 'decrease',
                    athleteId: athleteId,
                    athleteData: athleteData,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ActionButton(
                    title: 'Зачислить 10 тренировок',
                    condition: 'increase 10',
                    athleteId: athleteId,
                    athleteData: athleteData,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ActionButton(
                    title: 'Зачислить 1 тренировку',
                    condition: 'increase 1',
                    athleteId: athleteId,
                    athleteData: athleteData,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print('Кнопка 4 нажата');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          athleteCtrl.setCardInputsColor(athleteData),
                      padding: EdgeInsets.all(8),
                    ),
                    child: Text(
                      'Показать всё',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
