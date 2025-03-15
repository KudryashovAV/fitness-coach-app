import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/widgets/add_athlete.dart';
import 'package:fitness_coach_app/widgets/athletes_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final athleteCtrl = Get.put(AthletesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Команда тренера'),
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
