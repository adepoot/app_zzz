import 'dart:convert';

import 'package:app_zzz/api/player.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUri = 'https://ms-zzz.herokuapp.com/api';

  static Future<List<Player>> fetchPlayers() async {
    final response = await http.get(Uri.parse(_baseUri + '/players'));

    if (response.statusCode == 200) {
      return (json.decode(const Utf8Decoder().convert(response.body.codeUnits))
              as List)
          .map((e) => Player.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load the players');
  }

  static Future<List<PlayerStats>> fetchPlayerStats() async {
    final response = await http.get(Uri.parse(_baseUri + '/stats/players'));

    if (response.statusCode == 200) {
      return (json.decode(const Utf8Decoder().convert(response.body.codeUnits))
              as List)
          .map((e) => PlayerStats.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load the statistics of the players');
  }

  static Future<PlayerStats> fetchPlayerStatsForPlayer(final String id) async {
    final response = await http.get(Uri.parse(_baseUri + '/players/$id/stats'));

    if (response.statusCode == 200) {
      return PlayerStats.fromJson(
          json.decode(const Utf8Decoder().convert(response.body.codeUnits)));
    }
    throw Exception('Failed to load the statistics of player with id [$id]');
  }
}