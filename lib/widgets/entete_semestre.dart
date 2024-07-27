import 'package:flutter/material.dart';

class EnteteSemestre extends StatelessWidget {
  const EnteteSemestre({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(2),
        },
        border: TableBorder(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
        children: [
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "MODULES",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "VHT",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "PROFS",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
