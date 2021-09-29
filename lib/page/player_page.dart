import 'package:app_zzz/api/api.dart';
import 'package:app_zzz/api/player.dart';
import 'package:app_zzz/page/player_detail_page.dart';
import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late Future<List<Player>> players;

  ListView playersListView(List<Player> players) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];

        return ListTile(
          title: Text(
            '${player.firstName} ${player.lastName}',
            style: const TextStyle(fontSize: 18.0),
          ),
          trailing: Text(
            '${player.number}',
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayerDetailPage(
                    playerId: player.id,
                    playerName: player.firstName + ' ' + player.lastName)));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      drawer: const NavigationDrawerWidget(),
      body: FutureBuilder<List<Player>>(
        future: players,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return playersListView(snapshot.data!);
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
    players = Api.fetchPlayers();
  }
}
