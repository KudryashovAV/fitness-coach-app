import 'package:fitness_coach_app/bindings/app_binding.dart';
import 'package:fitness_coach_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
