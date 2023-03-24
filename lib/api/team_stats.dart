class TeamStats {
  final String name;
  final int position;
  final int points;
  final int gamesPlayed;

  TeamStats(
      {required this.name,
      required this.position,
      required this.points,
      required this.gamesPlayed});

  factory TeamStats.fromJson(Map<String, dynamic> json) {
    return TeamStats(
        name: json['name'],
        position: json['position'],
        points: json['points'],
        gamesPlayed: json['games_played']);
  }
}
