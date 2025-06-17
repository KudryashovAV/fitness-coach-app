import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/models/athlete.dart';
import 'package:fitness_coach_app/screens/athlete_screen.dart';
import 'package:fitness_coach_app/widgets/action_button.dart';
import 'package:fitness_coach_app/widgets/athlete_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteCard extends StatelessWidget {
  final athleteCtrl = Get.put(AthletesController());
  AthleteCard({required this.athleteData, required this.athleteId, super.key});
  final Athlete athleteData;
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
                  athleteCtrl.deleteAthlete(athleteId);
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

  dynamic setCardColor() {
    if (int.parse(athleteData.workouts) <= 0) {
      return const Color.fromARGB(255, 228, 30, 12);
    }

    if (int.parse(athleteData.workouts) > 8) {
      return const Color.fromARGB(255, 136, 235, 114);
    } else {
      if (int.parse(athleteData.workouts) < 3) {
        return const Color.fromARGB(255, 240, 167, 103);
      } else {
        return Colors.orange;
      }
    }
  }

  String capitalizeName(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
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
                capitalizeName(athleteData.name),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: Offset(2, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AthleteInfo(
                      withoutPadding: false,
                      athleteData: athleteData,
                      title: athleteData.phone,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: AthleteInfo(
                      withoutPadding: true,
                      athleteData: athleteData,
                      title:
                          'Осталось ${athleteData.workouts} ${workoutTitle(athleteData.workouts)}',
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
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PhysicalModel(
                      color: setCardColor(),
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: TextButton(
                        onPressed: () {
                          Get.to(
                            () => AthleteScreen(
                              athleteData: athleteData,
                              athleteId: athleteId,
                            ),
                            transition: Transition.downToUp,
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              athleteCtrl.setCardInputsColor(athleteData),
                          padding: EdgeInsets.all(16),
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
                  ),
                  SizedBox(width: 110),
                  Expanded(
                    child: PhysicalModel(
                      color: setCardColor(),
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: TextButton(
                        onPressed: () {
                          _showConfirmationDialog(
                              context, 'Хотите удалить спортсмена?');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 104, 5, 5),
                          padding: EdgeInsets.all(8),
                        ),
                        child: Text(
                          'Удалить спортсмена',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
