import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:app_zzz/widget/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  late Future<List<PlayerStats>> playerStats;

  CustomRow toRow(PlayerStats playerStats) {
    return CustomRow(amount: playerStats.goals, player: playerStats.firstName + ' ' + playerStats.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: FutureBuilder<List<PlayerStats>>(
        future: playerStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomTable(
                firstHeader: 'Goals',
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
