import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'firebase_options.dart';
import 'bindings/login_binding.dart';
import 'screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Используйте сгенерированный файл
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userUid = prefs.getString('current_user');

  runApp(
    GetMaterialApp(
      title: "Firebase GetX Auth Demo",
      initialRoute: userUid == '' ? '/' : '/home',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginView(),
          binding: LoginBinding(), // Привязываем контроллер к представлению
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}
