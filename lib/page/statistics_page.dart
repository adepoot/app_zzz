import 'package:app_zzz/page/assist_page.dart';
import 'package:app_zzz/page/goal_page.dart';
import 'package:app_zzz/page/save_page.dart';
import 'package:app_zzz/page/selection_page.dart';
import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Statistics')),
        drawer: const NavigationDrawerWidget(),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: const Text(
                'Selections',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SelectionPage()));
              },
            ),
            ListTile(
              title: const Text(
                'Goals',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GoalPage()));
              },
            ),
            ListTile(
              title: const Text(
                'Assists',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AssistPage()));
              },
            ),
            ListTile(
              title: const Text(
                'Saves',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SavePage()));
              },
            )
          ]).toList(),
        ));
  }
}
