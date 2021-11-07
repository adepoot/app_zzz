import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/match.dart';
import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  Map months = {
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
  };

  late Future<List<Match>> matches;

  List<Widget> getMatchesViewFor(String monthAsNumber, List<Match> matches) {
    List<Widget> tiles = [];

    for (var match in matches) {
      if (match.date.split("-")[1] == monthAsNumber) {
        tiles.add(ListTile(
          leading: SizedBox(
            child: Text(
              match.homeTeam,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: match.homeTeam == "De Zwarte Zeverzwijnen"
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
            width: MediaQuery.of(context).size.width / 3.5,
          ),
          title: Text(
            "${match.homeScore} - ${match.awayScore}",
            textAlign: TextAlign.center,
          ),
          trailing: SizedBox(
            child: Text(
              match.awayTeam,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: match.awayTeam == "De Zwarte Zeverzwijnen"
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
            width: MediaQuery.of(context).size.width / 3.5,
          ),
        ));
        tiles.add(const Divider());
      }
    }

    return tiles;
  }

  Widget getViewFor(String monthAsNumber, List<Match> matches) {
    return Column(children: [
      Text(
        "${months[monthAsNumber]}",
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      Column(
        children: getMatchesViewFor(monthAsNumber, matches),
      ),
    ]);
  }

  ListView matchesListView(List<Match> matches) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: months.length,
      itemBuilder: (context, index) {
        return getViewFor(months.keys.elementAt(index), matches);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matches')),
      drawer: const NavigationDrawerWidget(),
      body: FutureBuilder<List<Match>>(
        future: matches,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return matchesListView(snapshot.data!);
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
    matches = Api.fetchMatches();
  }
}
