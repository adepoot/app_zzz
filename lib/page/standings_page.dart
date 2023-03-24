import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/team_stats.dart';
import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  late Future<List<TeamStats>> standings;

  InteractiveViewer standingsTable(List<TeamStats> standings) {
    standings.sort((a, b) => a.position.compareTo(b.position));

    return InteractiveViewer(
        constrained: false,
        child: DataTable(
          headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            columns: const <DataColumn>[
              DataColumn(label: Text("Team")),
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Pts")),
              DataColumn(label: Text("MP")),
            ],
            rows: List<DataRow>.generate(
                standings.length,
                (index) => DataRow(cells: <DataCell>[
                      DataCell(Text(standings[index].name)),
                      DataCell(Text("${standings[index].position}")),
                      DataCell(Text("${standings[index].points}")),
                      DataCell(Text("${standings[index].gamesPlayed}")),
                    ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Standings')),
      drawer: const NavigationDrawerWidget(),
      body: FutureBuilder<List<TeamStats>>(
        future: standings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return standingsTable(snapshot.data!);
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
    standings = Api.fetchCurrentStandings();
  }
}
