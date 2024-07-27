import 'package:examen_flutter/models/etudiants.dart';
import 'package:examen_flutter/screens/Liste_etudiants.dart';
import 'package:examen_flutter/screens/semesre_screen/semestre_list.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:examen_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Etudiant> listeEtudiants = [];

  @override
  void initState() {
    super.initState();
    getEtudiant();
  }

  void getEtudiant() async {
    final result = await DatabaseHelper.instance.getEtudiants();
    setState(() {
      listeEtudiants = result;
    });
  }

  int countMaleStudents() {
    return listeEtudiants
        .where((etudiant) => etudiant.sexe == 'Masculin')
        .length;
  }

  int countFemaleStudents() {
    return listeEtudiants
        .where((etudiant) => etudiant.sexe == 'Féminin')
        .length;
  }

  int totalStudents() {
    return listeEtudiants.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: myblueColor,
        centerTitle: true,
        title: const Text(
          "ACCUEIL",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Affichage des elements
              //1 Diaframme
              //2 Tableau de bord (Dasboard)
              _buildPieChart(),
              const SizedBox(height: 20),
              _buildOverviewCard(
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListeEtudiantScreen(),
                      ));
                },
                "Etudiants",
                "assets/images/group.png",
                countMaleStudents(),
                countFemaleStudents(),
                totalStudents(),
                "Hommes",
                "Femmes",
                myblueColor,
              ),
              const SizedBox(height: 20),
              _buildOverviewCard(
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SemestreList(),
                      ));
                },
                "Semestres",
                "assets/images/books.png",
                252,
                3600,
                6,
                "Modules",
                "VHT",
                Colors.orange.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget pour le diagramme pour la repartition des etudiant selon leurs sexe
  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Répartition par sexe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: countMaleStudents().toDouble(),
                        title: 'Hommes',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.pink,
                        value: countFemaleStudents().toDouble(),
                        title: 'Femmes',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
    void Function()? onTap,
    String element,
    String iconPath,
    int countMale,
    int countFemale,
    int total,
    String type1,
    String type2,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    iconPath,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    element,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(
                    countMale.toString(),
                    type1,
                    Colors.blueAccent,
                  ),
                  _buildStatCard(
                    countFemale.toString(),
                    type2,
                    Colors.pinkAccent,
                  ),
                  _buildStatCard(
                    total.toString(),
                    "Total",
                    color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
