import 'package:cloud_firestore/cloud_firestore.dart';

class Athlete {
  final String id;
  final String name;
  final String phone;
  final String workouts;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Athlete({
    required this.id,
    required this.name,
    required this.phone,
    required this.workouts,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Athlete.fromMap(Map<String, dynamic> data, String id) {
    return Athlete(
      id: id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      workouts: data['workouts'] ?? '',
      ownerId: data['ownerId'] ?? '',
      createdAt: data['createdAt'].toDate() ?? FieldValue.serverTimestamp(),
      updatedAt: data['updatedAt'].toDate() ?? FieldValue.serverTimestamp(),
    );
  }
}
