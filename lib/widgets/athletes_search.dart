import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/widgets/athlete_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthletesSearch extends StatelessWidget {
  AthletesSearch({super.key});

  final athletesCtrl = Get.put(AthletesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск по имени...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  athletesCtrl.baseAthletesSearch();
                } else {
                  athletesCtrl.searchValue.value = value;
                  athletesCtrl.searchAthletes(value);
                }
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              var collection = [];
              if (athletesCtrl.searchValue.trim().isEmpty &&
                  athletesCtrl.athletes.isEmpty) {
                athletesCtrl.baseAthletesSearch();
                collection = athletesCtrl.allAthletes;
              } else {
                collection = athletesCtrl.athletes;
              }
              return ListView.builder(
                itemCount: collection.length,
                itemBuilder: (context, index) {
                  final athlete = collection[index];
                  return AthleteCard(
                    athleteData: athlete,
                    athleteId: athlete.id,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
