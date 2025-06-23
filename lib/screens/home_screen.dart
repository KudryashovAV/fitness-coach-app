import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_coach_app/controllers/auth_controller.dart';
import 'package:fitness_coach_app/widgets/add_athlete.dart';
import 'package:fitness_coach_app/widgets/athletes_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final athleteCtrl = Get.put(AthletesController());
  // final authCtrl = Get.put(AuthController());
  // final User? user = FirebaseAuth.instance.currentUser;

  String? getUsernameFromEmail(String? email) {
    if (email == null || !email.contains('@')) {
      return null;
    }

    int atIndex = email.indexOf('@');

    return email.substring(0, atIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Text(
                'Комана тренера', // ${getUsernameFromEmail(user?.email ?? '')}',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    // authCtrl.signOut();
                  },
                  tooltip: 'Добавить',
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 800,
        child: Column(
          children: [
            Expanded(child: AthletesSearch()),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => AddAthlete(),
              transition: Transition.downToUp,
            );
          },
          backgroundColor: const Color.fromARGB(255, 28, 158, 244),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
