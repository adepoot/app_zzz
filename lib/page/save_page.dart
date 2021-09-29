import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:app_zzz/widget/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  late Future<List<PlayerStats>> playerStats;

  CustomRow toRow(PlayerStats playerStats) {
    return CustomRow(amount: playerStats.saves, player: playerStats.firstName + ' ' + playerStats.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saves')),
      body: FutureBuilder<List<PlayerStats>>(
        future: playerStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomTable(
                firstHeader: 'Saves',
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
