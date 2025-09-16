import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/models/athlete.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'package:fitness_coach_app/widgets/workout_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AthleteScreen extends StatelessWidget {
  AthleteScreen(
      {required this.athleteData, required this.athleteId, super.key});

  final Athlete athleteData;
  final String athleteId;
  final athletesCtrl = Get.find<AthletesController>();

  String capitalizeName(String name) {
    if (name.isEmpty) return name;

    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalizeName(athleteData.name)}. Полная информация.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Базовая информация',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Имя',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromARGB(255, 72, 83, 240),
                  ),
                ),
                Text(
                  capitalizeName(athleteData.name),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[800],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: athleteData.phone,
                    decoration: InputDecoration(
                      labelText: 'Номер телефона',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 72, 83, 240),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => athletesCtrl.phone.value = value,
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => {
                    if (athletesCtrl.phone.value.isEmpty)
                      {
                        EasyLoading.showError(
                            'Укажите номер телефона спортсмена')
                      }
                    else
                      {
                        athletesCtrl.updateAthletePhone(athleteId),
                        Get.to(
                          () => HomeScreen(),
                          transition: Transition.downToUp,
                        ),
                      },
                  },
                  child: Text('Изменить'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Количество тренировок',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromARGB(255, 72, 83, 240),
                  ),
                ),
                Text(
                  athleteData.workouts,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[800],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Списание и начисление тренировок',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: WorkoutHistoryList(athleteId: athleteId),
            )
          ],
        ),
      ),
    );
  }
}
