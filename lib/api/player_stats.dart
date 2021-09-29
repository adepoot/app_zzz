class PlayerStats {
  final String id;
  final String firstName;
  final String lastName;
  final int selections;
  final int goals;
  final int assists;
  final int saves;

  PlayerStats(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.selections,
      required this.goals,
      required this.assists,
      required this.saves});

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        selections: json['selections'],
        goals: json['goals'],
        assists: json['assists'],
        saves: json['saves']);
  }
}
