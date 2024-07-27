import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String moduleName;
  final String professorName;
  final int volumeHoraire;

  const ModuleCard({
    super.key,
    required this.moduleName,
    required this.professorName,
    required this.volumeHoraire,
  });

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
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
        children: [
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  moduleName,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  volumeHoraire.toString(),
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  professorName,
                  style: const TextStyle(fontSize: 16),
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
