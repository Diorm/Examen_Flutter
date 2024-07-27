import 'dart:io';
import 'package:examen_flutter/models/etudiants.dart';
import 'package:examen_flutter/screens/nouveau_etudiant.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:examen_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ListeEtudiantScreen extends StatefulWidget {
  const ListeEtudiantScreen({super.key});

  @override
  State<ListeEtudiantScreen> createState() => ListeEtudiantScreenState();
}

class ListeEtudiantScreenState extends State<ListeEtudiantScreen> {
  List<Etudiant> listeEtudiants = [];
  List<Etudiant> filteredEtudiants = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEtudiant();
  }

  getEtudiant() async {
    final result = await DatabaseHelper.instance.getEtudiants();
    setState(() {
      listeEtudiants = result;
      filteredEtudiants = listeEtudiants;
    });
  }

  void filterEtudiants(String query) {
    List<Etudiant> etudiants = listeEtudiants.where((etudiant) {
      return etudiant.nom.toLowerCase().contains(query.toLowerCase()) ||
          etudiant.prenom.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredEtudiants = etudiants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: myblueColor,
        centerTitle: true,
        title: const Text(
          "Page Étudiants",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Rechercher un étudiant',
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                filterEtudiants(query);
              },
            ),
          ),
          Expanded(
            child: filteredEtudiants.isEmpty
                ? const Center(
                    heightFactor: 10,
                    child: Text(
                      'Aucun étudiant n\'est ajouté pour l\'instant',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  )
                : buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NouveauEtudiant(),
            ),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: myblueColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildListView() {
    return ListView.separated(
      itemCount: filteredEtudiants.length,
      itemBuilder: (context, index) {
        final pers = filteredEtudiants[index];
        final item = pers.nom;
        return Container(
          key: Key(pers.id.toString()),
          child: getLisTile(index, context, item),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: myblueColor,
      ),
    );
  }

  ListTile getLisTile(int index, BuildContext context, String item) {
    Etudiant pers = filteredEtudiants[index];
    return ListTile(
      title: Text(
        pers.nom,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text("${pers.email}\n Tel.: ${pers.telephone}"),
      leading: CircleAvatar(
        // ignore: unnecessary_null_comparison
        backgroundImage: (pers != null &&
                pers.imagePath != null &&
                pers.imagePath!.isNotEmpty)
            ? FileImage(File(pers.imagePath!))
            : const AssetImage('assets/images/person.jpg') as ImageProvider,
        radius: 30,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () async {
          final id = pers.id ?? 0; // default to 0 if pers.id is null
          await DatabaseHelper.instance.deleteEtudiant(id);
          setState(() {
            filteredEtudiants.removeAt(index);
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$item a été supprimé de la liste'),
          ));
        },
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              getAlertDialogInfosPersonne(pers, context),
        );
      },
    );
  }

  AlertDialog getAlertDialogInfosPersonne(Etudiant pers, BuildContext context) {
    return AlertDialog(
      backgroundColor: myblueColor,
      title: const Text(
        "Détails des informations",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      content: getAlertDialogDetailInfos(pers),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget getAlertDialogDetailInfos(Etudiant pers) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    pers.imagePath == null || pers.imagePath!.isEmpty
                        ? const AssetImage('assets/images/person.jpg')
                        : FileImage(File(pers.imagePath!)) as ImageProvider,
                radius: 80,
              ),
              const SizedBox(height: 20),
              Text(
                "${pers.nom} ${pers.prenom}",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.blue),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              pers.email,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              pers.telephone.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Fermer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
