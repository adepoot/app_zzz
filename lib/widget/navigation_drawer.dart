import 'package:app_zzz/page/matches_page.dart';
import 'package:app_zzz/page/players_page.dart';
import 'package:app_zzz/page/statistics_page.dart';
import 'package:flutter/material.dart';

import '../page/standings_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Image(image: AssetImage('assets/banner_500.png'))),
        ListTile(
          leading: const Icon(Icons.leaderboard),
          title: const Text('Standings'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StandingsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.event),
          title: const Text('Matches'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MatchesPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Players'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PlayersPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.query_stats),
          title: const Text('Statistics'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StatisticsPage()));
          },
        )
      ],
    ));
  }
}
