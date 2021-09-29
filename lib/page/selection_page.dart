import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player_stats.dart';
import 'package:app_zzz/widget/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late Future<List<PlayerStats>> playerStats;

  CustomRow toRow(PlayerStats playerStats) {
    return CustomRow(amount: playerStats.selections, player: playerStats.firstName + ' ' + playerStats.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selections')),
      body: FutureBuilder<List<PlayerStats>>(
        future: playerStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomTable(
                firstHeader: 'Selections',
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
