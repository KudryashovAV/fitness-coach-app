import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  String checkAndReturnEmail(String email) {
    final regex = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

    if (!regex.hasMatch(email)) {
      throw ('Электронная почта содержит ошибку');
    }

    return email.trim();
  }

  @override
  void onInit() {
    super.onInit();
    ever(_authRepository.firebaseUser, _goToHomeOrLogin);
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
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
        checkAndReturnEmail(emailController.text),
        passwordController.text.trim(),
      );

      final User? user = FirebaseAuth.instance.currentUser;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userUid = user?.uid;
      await prefs.setString('current_user', userUid ?? '');
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
        checkAndReturnEmail(emailController.text),
        passwordController.text.trim(),
      );
      Get.snackbar('Успех!', 'Аккаунт успешно создан. Можете войти.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _authRepository.signOut();
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Неизвестная ошибка выхода.';
    } finally {
      isLoading.value = false;
    }
  }
}
