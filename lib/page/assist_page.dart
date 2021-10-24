import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:app_zzz/widget/assist_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistPage extends StatefulWidget {
  const AssistPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AssistPageState();
}

class _AssistPageState extends State<AssistPage> {
  late Future<List<PlayerStats>> playerStats;

  AssistRow toRow(PlayerStats playerStats) {
    return AssistRow(amount: playerStats.assists, player: playerStats.player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assists')),
      body: FutureBuilder<List<PlayerStats>>(
        future: playerStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AssistTable(
                firstHeader: 'Assists',
                secondHeader: 'Player',
                rows: snapshot.data!.map((e) => toRow(e)).toList());
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
    playerStats = Api.fetchPlayerStats();
  }
}
