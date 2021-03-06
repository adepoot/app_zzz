import 'package:app_zzz/api/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsRow {
  final int amount;
  final Player? player;

  StatsRow({required this.amount, required this.player});
}

class StatsTable extends StatelessWidget {
  final String firstHeader;
  final String secondHeader;
  final List<StatsRow> rows;

  const StatsTable(
      {Key? key,
      required this.firstHeader,
      required this.secondHeader,
      required this.rows})
      : super(key: key);

  DataRow toDataRow(BuildContext context, StatsRow row) {
    String name = row.player != null
        ? row.player!.firstName + ' ' + row.player!.lastName
        : '/';

    return DataRow(cells: [
      DataCell(Text(
        '${row.amount}',
        textAlign: TextAlign.center,
      )),
      DataCell(Text(name)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    rows.removeWhere((a) => a.amount == 0);
    rows.sort((a, b) => b.amount.compareTo(a.amount));
    List<DataRow> data = rows.map((e) => toDataRow(context, e)).toList();

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: DataTable(
        headingTextStyle: const TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
        dataTextStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
        columns: [
          DataColumn(label: Text(firstHeader)),
          DataColumn(label: Text(secondHeader))
        ],
        rows: data,
        sortColumnIndex: 0,
        sortAscending: false,
      ),
    )));
  }
}
