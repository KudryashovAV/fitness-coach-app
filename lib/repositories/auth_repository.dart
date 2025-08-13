import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Для удобства обработки ошибок
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthRepository extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_firebaseAuth.authStateChanges());
  }

  // Вход по Email и Паролю
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Пользователь с таким email не найден.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Неверный пароль.');
      }
      throw AuthException(e.message ?? 'Произошла ошибка при входе.');
    } catch (e) {
      throw AuthException('Неизвестная ошибка: $e');
    }
  }

  // Регистрация по Email и Паролю
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Пароль слишком слабый.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Пользователь с таким email уже существует.');
      }
      throw AuthException(e.message ?? 'Произошла ошибка при регистрации.');
    } catch (e) {
      throw AuthException('Неизвестная ошибка: $e');
    }
  }

  // Выход
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
