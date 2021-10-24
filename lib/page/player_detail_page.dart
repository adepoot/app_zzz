import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'goals_detail_page.dart';

class PlayerDetailPage extends StatefulWidget {
  final String playerId;
  final String playerName;

  const PlayerDetailPage(
      {Key? key, required this.playerId, required this.playerName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> {
  late Future<PlayerStats> playerStats;

  _PlayerDetailPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.playerName)),
      body: FutureBuilder<PlayerStats>(
        future: playerStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerStats stats = snapshot.data!;

            return ListView(
                padding: const EdgeInsets.all(16.0),
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                      title: const Text(
                        'Selections',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      trailing: Text('${stats.selections}')),
                  ListTile(
                    title:
                        const Text('Goals', style: TextStyle(fontSize: 18.0)),
                    trailing: Text('${stats.goals}'),
                    onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoalsDetailPage(player: stats.player)))
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Assists',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    trailing: Text('${stats.assists}'),
                  ),
                  ListTile(
                    title:
                        const Text('Saves', style: TextStyle(fontSize: 18.0)),
                    trailing: Text('${stats.saves}'),
                  )
                ]).toList());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    playerStats = Api.fetchPlayerStatsForPlayer(widget.playerId);
  }
}
