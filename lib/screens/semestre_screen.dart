/* import 'package:examen_flutter/widgets/ajout_semestre.dart';
import 'package:examen_flutter/widgets/semester_card.dart';
import 'package:flutter/material.dart';

class SemestreScreen extends StatefulWidget {
  const SemestreScreen({super.key});

  @override
  _SemestreScreenState createState() => _SemestreScreenState();
}

class _SemestreScreenState extends State<SemestreScreen> {
  final List<MySemesterCard> _semesters = [];

  void _addSemester(int numero, int volumeHoraire, int nombreModules) {
    setState(() {
      _semesters.add(
        MySemesterCard(
Color: ,
          numeroSemestre: numero,
          volumeHoraireTotale: volumeHoraire,
          nombreTotalModules: nombreModules,
        ),
      );
    });
  }

  void _openAddSemesterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSemesterDialog(onAdd: _addSemester);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Liste des Semestres",
          style: TextStyle(fontSize: 20),
        ),
      ),
     
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: _semesters,
      ),
    );
  }
}
 */