import 'package:app_zzz/api/player.dart';

class PlayerStats {
  final Player player;
  final int selections;
  final int goals;
  final int assists;
  final int saves;

  PlayerStats(
      {required this.player,
      required this.selections,
      required this.goals,
      required this.assists,
      required this.saves});

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
        player: Player.fromJson(json['player']),
        selections: json['selections'],
        goals: json['goals'],
        assists: json['assists'],
        saves: json['saves']);
  }
}
