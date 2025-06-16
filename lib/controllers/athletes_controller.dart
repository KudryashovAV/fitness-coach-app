import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_coach_app/models/athlete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AthletesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var name = ''.obs;
  var phone = ''.obs;
  var ownerId = ''.obs;
  var workouts = '0'.obs;
  var athletes = <Athlete>[].obs;
  var allAthletes = <Athlete>[].obs;
  var searchValue = ''.obs;
  final editCtrl = TextEditingController();
  var isLoading = false.obs;
  final User? user = FirebaseAuth.instance.currentUser;

  dynamic setCardInputsColor(data) {
    if (int.parse(data.workouts) <= 0) {
      return const Color.fromARGB(255, 246, 110, 98);
    }

    if (int.parse(data.workouts) > 8) {
      return const Color.fromARGB(255, 48, 247, 3);
    } else {
      if (int.parse(data.workouts) < 3) {
        return const Color.fromARGB(255, 239, 132, 38);
      } else {
        return Colors.orange[300];
      }
    }
  }

  Future<List<Athlete>> fetchAthletes(String query) async {
    QuerySnapshot snapshot = await _firestore
        .collection('athletes')
        .where('ownerId', isEqualTo: user?.uid)
        .orderBy('updatedAt', descending: true)
        .get();

    List<DocumentSnapshot> results = snapshot.docs.where((doc) {
      String text = doc['name'];
      return text.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return results
        .map((result) => Athlete(
            id: result.id,
            name: result['name'],
            phone: result['phone'],
            workouts: result['workouts'],
            ownerId: result['ownerId'],
            createdAt: result['createdAt'].toDate(),
            updatedAt: result['updatedAt'].toDate()))
        .toList();
  }

  Future<void> baseAthletesSearch() async {
    final result = await _firestore
        .collection('athletes')
        .where('ownerId', isEqualTo: user?.uid)
        .orderBy('updatedAt', descending: true)
        .get();

    athletes.assignAll(
        result.docs.map((doc) => Athlete.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> searchAthletes(String query) async {
    isLoading(true);
    try {
      final result = await fetchAthletes(query);
      athletes.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void addAthlete() async {
    try {
      await _firestore.collection('athletes').add({
        'name': name.toString().toLowerCase(),
        'phone': phone.toString(),
        'workouts': workouts.toString().replaceAll(RegExp(r'\D'), ''),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'ownerId': user?.uid,
      });

      baseAthletesSearch();
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
      baseAthletesSearch();
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
          'ownerId': user?.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      });

      baseAthletesSearch();

      Get.snackbar('Успех',
          'Тренировка ${type.contains('increase') ? 'добавлена' : 'списана'}');
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
