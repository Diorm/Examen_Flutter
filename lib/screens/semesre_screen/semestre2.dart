import 'package:examen_flutter/widgets/entete_semestre.dart';
import 'package:flutter/material.dart';

class Semestre2 extends StatelessWidget {
  const Semestre2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 5, 20, 152),
          title: const Text(
            "Semestre 2",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ListView(children: const [
              Column(
                children: [
                  EnteteSemestre(),
                  ModuleCard(
                      moduleName: "Mathématiques Financières",
                      professorName: "Srako",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Statistiques",
                      professorName: "M.Srako",
                      volumeHoraire: 40),
                  Divider(),
                  ModuleCard(
                      moduleName: "Economie",
                      professorName: "M.Diop",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Analyse 2",
                      professorName: "M.Ndoye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Langage C",
                      professorName: "M.Youm",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Structure de Données",
                      professorName: "M.Youm",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "CCNA 1",
                      professorName: "M.Dione",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Labo/Dev mobiles",
                      professorName: "M.Ndiaye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Algorithme 2",
                      professorName: "M.Youm",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Techniques Française",
                      professorName: "M.Dione",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Anglais Technique 2",
                      professorName: "M.Faye",
                      volumeHoraire: 60),
                ],
              ),
            ])));
  }
}

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            moduleName,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            volumeHoraire.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            professorName,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
