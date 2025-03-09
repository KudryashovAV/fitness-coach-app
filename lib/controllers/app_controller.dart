import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var name = ''.obs;
  var phone = ''.obs;
  var workouts = 0.obs;

  void addUser() async {
    try {
      await _firestore.collection('users').add({
        'name': name.toString(),
        'phone': phone.toString(),
        'workouts': workouts.toString(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Успех', 'Спортсмен успешно создан!');
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось отправить данные: $e');
    }
  }
}
