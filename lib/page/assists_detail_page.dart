import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player.dart';
import 'package:app_zzz/api/stats_detail.dart';
import 'package:app_zzz/widget/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistsDetailPage extends StatefulWidget {
  final Player player;

  const AssistsDetailPage({Key? key, required this.player}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AssistsDetailPageState();
}

class _AssistsDetailPageState extends State<AssistsDetailPage> {
  late Future<List<StatsDetail>> statsDetails;

  StatsRow toRow(StatsDetail statsDetail) {
    return StatsRow(amount: statsDetail.amount, player: statsDetail.player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Assists ' +
              widget.player.firstName +
              ' ' +
              widget.player.lastName)),
      body: FutureBuilder<List<StatsDetail>>(
        future: statsDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StatsTable(
                firstHeader: '#',
                secondHeader: 'Goal(s) from',
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
    statsDetails = Api.fetchAssistStatsForPlayer(widget.player.id);
  }
}
