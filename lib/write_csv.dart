import 'dart:io';

import 'package:csv/csv.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WriteCsv extends StatefulWidget {
  const WriteCsv({Key? key}) : super(key: key);

  @override
  _WriteCsvState createState() => _WriteCsvState();
}

class _WriteCsvState extends State<WriteCsv> {
  void _generateCsvFile() async {
    Map<Permission, PermissionStatus> status =
        await [Permission.storage].request();
    List<dynamic> csvList = [
      {"name": "Rishi", "phone": "987654321"},
      {"name": "Rekha", "phone": "123456789"},
      {"name": "Mansi", "phone": "234789610"},
      {"name": "Sagar Mal", "phone": "0129387465"},
    ];
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("Name");
    row.add("Phone");
    rows.add(row);
    for (int i = 0; i < csvList.length; i++) {
      List<dynamic> row = [];
      row.add(csvList[i]["name"]);
      row.add(csvList[i]["phone"]);
      rows.add(row);
      String csv = const ListToCsvConverter().convert(rows);
      String dir = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      String fileName = dir;
      File file = File(fileName + "/filename.csv");
      file.writeAsString(csv);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () {
            _generateCsvFile();
          },
          child: const Text("CSV FILE")),
    );
  }
}
