class Match {
  final String id;
  final String date;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  Match(
      {required this.id,
      required this.date,
      required this.homeTeam,
      required this.awayTeam,
      required this.homeScore,
      required this.awayScore});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
        id: json['id'],
        date: json['date'],
        homeTeam: json['home_team'],
        awayTeam: json['away_team'],
        homeScore: json['home_score'],
        awayScore: json['away_score']);
  }
}
