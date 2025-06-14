import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../repositories/auth_repository.dart'; // Путь к вашему AuthRepository

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // AuthRepository должен быть singleton, так как он управляет состоянием Firebase Auth
    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    // LoginController создается для LoginView
    Get.lazyPut<AuthController>(() => AuthController());
  }
}