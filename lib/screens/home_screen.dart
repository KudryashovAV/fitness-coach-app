import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:fitness_coach_app/widgets/add_athlete.dart';
import 'package:fitness_coach_app/widgets/athlete_card.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('athletes')
            .orderBy('name', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Спортсменов пока ещё нет. Добавьте их, нажав плюсик в правом нижнем углу экрана.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final data = user.data() as Map<String, dynamic>;

              return Center(
                  child: AthleteCard(
                athleteData: data,
                athleteId: user.id,
              ));
            },
          );
        },
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
