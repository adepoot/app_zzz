import 'package:app_zzz/api/player.dart';

class StatsDetail {
  final Player? player;
  final int amount;

  StatsDetail({required this.player, required this.amount});

  factory StatsDetail.fromJson(Map<String, dynamic> json) {
    Player? player =
        json['player'] != null ? Player.fromJson(json['player']) : null;

    return StatsDetail(player: player, amount: json['amount']);
  }
}
