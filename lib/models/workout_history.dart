class WorkoutHistory {
  final String id;
  final String title;
  final String athleteId;
  final String athleteName;
  final String athletePhone;
  final String ownerId;
  final DateTime createdAt;

  WorkoutHistory({
    required this.id,
    required this.title,
    required this.athleteId,
    required this.athleteName,
    required this.athletePhone,
    required this.ownerId,
    required this.createdAt,
  });
}
