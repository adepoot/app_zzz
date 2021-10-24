import 'package:app_zzz/api/player.dart';
import 'package:app_zzz/page/assists_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistRow {
  final int amount;
  final Player player;

  AssistRow({required this.amount, required this.player});
}

class AssistTable extends StatelessWidget {
  final String firstHeader;
  final String secondHeader;
  final List<AssistRow> rows;

  const AssistTable(
      {Key? key,
      required this.firstHeader,
      required this.secondHeader,
      required this.rows})
      : super(key: key);

  DataRow toDataRow(BuildContext context, AssistRow row) {
    return DataRow(cells: [
      DataCell(
          Text(
            '${row.amount}',
            textAlign: TextAlign.center,
          ), onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AssistsDetailPage(player: row.player)));
      }),
      DataCell(Text(row.player.firstName + ' ' + row.player.lastName),
          onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AssistsDetailPage(player: row.player)));
      }),
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
