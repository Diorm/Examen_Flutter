import 'package:examen_flutter/screens/semesre_screen/semestr1.dart';
import 'package:examen_flutter/screens/semesre_screen/semestre2.dart';
import 'package:examen_flutter/screens/semesre_screen/semestre3.dart';
import 'package:examen_flutter/screens/semesre_screen/semestre4.dart';
import 'package:examen_flutter/widgets/semester_card.dart';
import 'package:flutter/material.dart';

class SemestreList extends StatefulWidget {
  const SemestreList({super.key});

  @override
  _SemestreListState createState() => _SemestreListState();
}

class _SemestreListState extends State<SemestreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "Liste des Semestres",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            MySemesterCard(
              numeroSemestre: 1,
              volumeHoraireTotale: 600,
              nombreTotalModules: 12,
              color: Colors.orange.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre1(),
                  ),
                );
              },
            ),
            MySemesterCard(
              numeroSemestre: 2,
              volumeHoraireTotale: 600,
              nombreTotalModules: 12,
              color: Colors.pink.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre2(),
                  ),
                );
              },
            ),
            MySemesterCard(
              numeroSemestre: 3,
              volumeHoraireTotale: 600,
              nombreTotalModules: 11,
              color: Colors.blue.shade800,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre3(),
                  ),
                );
              },
            ),
            MySemesterCard(
              numeroSemestre: 4,
              volumeHoraireTotale: 600,
              nombreTotalModules: 13,
              color: Colors.brown.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre4(),
                  ),
                );
              },
            ),
            MySemesterCard(
              numeroSemestre: 5,
              volumeHoraireTotale: 600,
              nombreTotalModules: 13,
              color: Colors.red.shade400,
              onTap: () {
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre5(),
                  ),
                ); */
              },
            ),
            MySemesterCard(
              numeroSemestre: 6,
              volumeHoraireTotale: 600,
              nombreTotalModules: 15,
              color: Colors.green.shade700,
              onTap: () {
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Semestre4(),
                  ),
                ); */
              },
            ),
          ],
        ),
      ),
    );
  }
}
