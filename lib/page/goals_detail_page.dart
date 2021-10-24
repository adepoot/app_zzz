import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player.dart';
import 'package:app_zzz/api/stats_detail.dart';
import 'package:app_zzz/widget/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoalsDetailPage extends StatefulWidget {
  final Player player;

  const GoalsDetailPage({Key? key, required this.player}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoalsDetailPageState();
}

class _GoalsDetailPageState extends State<GoalsDetailPage> {
  late Future<List<StatsDetail>> statsDetails;

  StatsRow toRow(StatsDetail statsDetail) {
    return StatsRow(amount: statsDetail.amount, player: statsDetail.player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Goals ' +
              widget.player.firstName +
              ' ' +
              widget.player.lastName)),
      body: FutureBuilder<List<StatsDetail>>(
        future: statsDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StatsTable(
                firstHeader: '#',
                secondHeader: 'Assist(s) from',
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
    statsDetails = Api.fetchGoalStatsForPlayer(widget.player.id);
  }
}
