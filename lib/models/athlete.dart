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
}
