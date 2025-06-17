import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'firebase_options.dart';
import 'bindings/login_binding.dart';
import 'screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: 'Fitnes Coach APP',
      initialRoute: userUid == '' ? '/' : '/home',
      builder: EasyLoading.init(),
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

  EasyLoading.init();
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = Colors.white
    ..backgroundColor = Color(0xff9B111E)
    ..radius = 30.0
    ..textColor = Colors.white
    ..textStyle = GoogleFonts.openSans(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
}
