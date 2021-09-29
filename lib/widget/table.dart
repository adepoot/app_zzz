import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRow {
  final int amount;
  final String player;

  CustomRow({required this.amount, required this.player});
}

class CustomTable extends StatelessWidget {
  final String firstHeader;
  final String secondHeader;
  final List<CustomRow> rows;

  const CustomTable(
      {Key? key,
      required this.firstHeader,
      required this.secondHeader,
      required this.rows})
      : super(key: key);

  DataRow toDataRow(CustomRow row) {
    return DataRow(cells: [
      DataCell(Text(
        '${row.amount}',
        textAlign: TextAlign.center,
      )),
      DataCell(Text(
        row.player,
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    rows.removeWhere((a) => a.amount == 0);
    rows.sort((a, b) => b.amount.compareTo(a.amount));
    List<DataRow> data = rows.map((e) => toDataRow(e)).toList();

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
