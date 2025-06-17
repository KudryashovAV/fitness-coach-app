import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository =
      Get.find<AuthRepository>(); // Находим AuthRepository

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs; // Отслеживаем состояние загрузки
  RxString errorMessage = ''.obs; // Сообщение об ошибке

  @override
  void onInit() {
    super.onInit();
    // Привязываем слушатель к состоянию пользователя
    ever(_authRepository.firebaseUser, _goToHomeOrLogin);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _goToHomeOrLogin(User? user) {
    if (user == null) {
      // Пользователь не вошел или вышел, остаемся на логин-странице
      if (Get.currentRoute != '/') {
        // Избегаем бесконечных циклов
        Get.offAllNamed('/');
      }
    } else {
      // Пользователь вошел, переходим на домашнюю страницу
      Get.offAllNamed('/home');
    }
  }

  Future<void> signIn() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _authRepository.signInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final User? user = FirebaseAuth.instance.currentUser;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userUid = user?.uid;
      await prefs.setString('current_user', userUid ?? '');
      // Если дошли сюда, значит пользователь успешно вошел,
      // _goToHomeOrLogin будет вызван автоматически через слушателя firebaseUser
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Неизвестная ошибка входа.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _authRepository.signUpWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // Аналогично, _goToHomeOrLogin будет вызван
      Get.snackbar('Успех!', 'Аккаунт успешно создан. Можете войти.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Неизвестная ошибка регистрации.';
    } finally {
      isLoading.value = false;
    }
  }
}
