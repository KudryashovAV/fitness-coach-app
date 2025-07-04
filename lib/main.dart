import 'package:fitness_coach_app/bindings/app_binding.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'package:fitness_coach_app/bindings/app_binding.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: const Color(0xffF4F4F4),
      title: 'Coach App',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      builder: EasyLoading.init(),
      home: HomeScreen(),
    );
  }
}
