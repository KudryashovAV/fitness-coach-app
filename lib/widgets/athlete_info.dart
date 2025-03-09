import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteInfo extends StatelessWidget {
  final athleteCtrl = Get.put(AthletesController());
  final dynamic athleteData;
  final dynamic title;
  final bool withoutPadding;
  AthleteInfo(
      {required this.athleteData,
      required this.title,
      required this.withoutPadding,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: withoutPadding
          ? EdgeInsets.symmetric(vertical: 8)
          : EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: athleteCtrl.setCardInputsColor(athleteData),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
