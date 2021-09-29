import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Matches')
      ),
      drawer: const NavigationDrawerWidget(),
      body: const Center(child: Text('Coming soon...')),
    );
  }
}