import 'package:examen_flutter/widgets/entete_semestre.dart';
import 'package:flutter/material.dart';

class Semestre3 extends StatelessWidget {
  const Semestre3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 5, 20, 152),
          title: const Text(
            "Semestre 3",
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
                      moduleName: "Comptabilité",
                      professorName: "Srako",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Séminaire/Outils d'aide",
                      professorName: "M.Ndiaye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Mérise",
                      professorName: "M.Ciss",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Visual Basic",
                      professorName: "M.Ciss",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Ms Access",
                      professorName: "M.Ciss",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "SGBD/Oracle",
                      professorName: "M.Cisse",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Education à la dignité",
                      professorName: "M.Kantoussan",
                      volumeHoraire: 40),
                  Divider(),
                  ModuleCard(
                      moduleName: "Réseaux ",
                      professorName: "M.Dione",
                      volumeHoraire: 50),
                  Divider(),
                  ModuleCard(
                      moduleName: "Anglais Technique 3",
                      professorName: "M.Faye",
                      volumeHoraire: 30),
                  Divider(),
                  ModuleCard(
                      moduleName: "CCNA 2",
                      professorName: "M.Dione",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "SQL Server",
                      professorName: "M.Diaw",
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
