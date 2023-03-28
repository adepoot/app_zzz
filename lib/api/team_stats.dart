class TeamStats {
  final String name;
  final int position;
  final int points;
  final int gamesPlayed;
  final int goalsDifference;

  TeamStats(
      {required this.name,
      required this.position,
      required this.points,
      required this.gamesPlayed,
      required this.goalsDifference});

  factory TeamStats.fromJson(Map<String, dynamic> json) {
    return TeamStats(
        name: json['name'],
        position: json['position'],
        points: json['points'],
        gamesPlayed: json['games_played'],
        goalsDifference: json['goals_difference']);
  }
}
