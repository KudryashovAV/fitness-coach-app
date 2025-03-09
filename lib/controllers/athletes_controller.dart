import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_coach_app/models/athlete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthletesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var name = ''.obs;
  var phone = ''.obs;
  var ownerId = ''.obs;
  var workouts = '0'.obs;
  var athletes = <Athlete>[].obs;
  final editCtrl = TextEditingController();

  dynamic setCardInputsColor(data) {
    if (int.parse(data['workouts']) <= 0) {
      return const Color.fromARGB(255, 246, 110, 98);
    }

    if (int.parse(data['workouts']) > 8) {
      return const Color.fromARGB(255, 48, 247, 3);
    } else {
      if (int.parse(data['workouts']) < 3) {
        return const Color.fromARGB(255, 239, 132, 38);
      } else {
        return Colors.orange[300];
      }
    }
  }

  void addAthlete() async {
    try {
      await _firestore.collection('athletes').add({
        'name': name.toString(),
        'phone': phone.toString(),
        'workouts': workouts.toString().replaceAll(RegExp(r'\D'), ''),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'ownerId': ownerId.toString(),
      });
      Get.snackbar('Успех', 'Спортсмен успешно создан!');
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось отправить данные: $e');
    }
  }

  void updateAthletePhone(String id) async {
    try {
      await _firestore.collection('athletes').doc(id).update({
        'phone': phone.toString(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Успех', 'Номер успешно обновлён!');
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось отправить данные: $e');
    }
  }

  void updateAthleteWorkouts(
    String id,
    String athleteName,
    String athletePhone,
    String workouts,
    String type,
  ) async {
    String count = '';
    String title = '';

    switch (type) {
      case 'decrease':
        count = (int.parse(workouts) - 1).toString();
      case 'increase 10':
        count = (int.parse(workouts) + 10).toString();
      case 'increase 1':
        count = (int.parse(workouts) + 1).toString();
      default:
        count = (int.parse(workouts) - 1).toString();
    }

    switch (type) {
      case 'decrease':
        title = '-1 тренировка. Было: $workouts, стало: $count тренировок.';
      case 'increase 10':
        title = '+10 тренировок. Было: $workouts, стало: $count тренировок.';
      case 'increase 1':
        title = '+1 тренировка. Было: $workouts, стало: $count тренировок.';
      default:
        title = '-1 тренировка. Было: $workouts, стало: $count тренировок.';
    }

    try {
      await _firestore.runTransaction((transaction) async {
        DocumentReference userRef = _firestore.collection('athletes').doc(id);
        transaction.update(userRef, {
          'workouts': count,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        DocumentReference logRef =
            _firestore.collection('workoutHistories').doc();
        transaction.set(logRef, {
          'title': title,
          'athleteId': id,
          'athleteName': athleteName,
          'athletePhone': athletePhone,
          'ownerId': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      });
      Get.snackbar('Успех',
          'Тренировка ${type == 'increase' ? 'добавлена' : 'списана'}');
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось списать тренировку: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutHistory(
      String athleteId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('workoutHistories')
        .where('athleteId', isEqualTo: athleteId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
