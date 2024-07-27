import 'package:examen_flutter/screens/semesre_screen/semestre2.dart';
import 'package:examen_flutter/widgets/entete_semestre.dart';
import 'package:flutter/material.dart';

class Semestre1 extends StatelessWidget {
  const Semestre1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 5, 20, 152),
        title: const Text(
          "Semestre 1",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListView(
          children: const [
            EnteteSemestre(),
            ModuleCard(
              moduleName: "Architecture de Ordinateurs",
              professorName: "M.Dione",
              volumeHoraire: 50,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Composants du micro ordinateur",
              professorName: "M.Dione",
              volumeHoraire: 40,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Logique Combbinatoire",
              professorName: "M.Youm",
              volumeHoraire: 30,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Ms Windows-Word",
              professorName: "M.Faye",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Ms Excel",
              professorName: "M.Faye",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Comptabilité gestion",
              professorName: "M.Srako",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Analyse 1",
              professorName: "M.Ndoye",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Algorhitme 1",
              professorName: "M.Youm",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Algorithme 2",
              professorName: "M.Youm",
              volumeHoraire: 60,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Techniques Française",
              professorName: "M.Dione",
              volumeHoraire: 50,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Anglais Technique 1",
              professorName: "M.Faye",
              volumeHoraire: 50,
            ),
            Divider(),
            ModuleCard(
              moduleName: "Education aux valeurs",
              professorName: "M.Dione",
              volumeHoraire: 50,
            ),
          ],
        ),
      ),
    );
  }
}
