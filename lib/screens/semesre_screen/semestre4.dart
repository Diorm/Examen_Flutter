import 'package:examen_flutter/widgets/entete_semestre.dart';
import 'package:flutter/material.dart';

class Semestre4 extends StatelessWidget {
  const Semestre4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 5, 20, 152),
          title: const Text(
            "Semestre 4",
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
                      moduleName: "Aspects légaux",
                      professorName: "Kantoussan",
                      volumeHoraire: 40),
                  Divider(),
                  ModuleCard(
                      moduleName: "Technologie de l'information",
                      professorName: "M.Dione",
                      volumeHoraire: 40),
                  Divider(),
                  ModuleCard(
                      moduleName: "Algébre",
                      professorName: "M.Ndoye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Recherche Opérationnelle",
                      professorName: "M.Ndoye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Power AMC",
                      professorName: "M.Ciss",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Ado.Net",
                      professorName: "M.Cisse",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Dev mobile",
                      professorName: "M.Ndiaye",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Labo BIG DATE",
                      professorName: "M.Cisse",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Sécurité reseaux Informatiques",
                      professorName: "M.Dione",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: "Communication Internes",
                      professorName: "M.Kantoussan",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: " Dot.Net",
                      professorName: "M.Diaw",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: " Visites d'entreprises",
                      professorName: "M.Dione",
                      volumeHoraire: 60),
                  Divider(),
                  ModuleCard(
                      moduleName: " Anglais Technique 4",
                      professorName: "M.Dasilvera",
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
