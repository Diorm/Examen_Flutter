import 'dart:io';
import 'package:examen_flutter/models/etudiants.dart';
import 'package:examen_flutter/screens/Liste_etudiants.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NouveauEtudiant extends StatefulWidget {
  const NouveauEtudiant({super.key});

  @override
  State<NouveauEtudiant> createState() => _NouveauEtudiantState();
}

class _NouveauEtudiantState extends State<NouveauEtudiant> {
  List<Etudiant> listeEtudiants = [];

  final _formkey = GlobalKey<FormState>();
  final _nomEditController = TextEditingController();
  final _prenomEditController = TextEditingController();
  final _adresseEditController = TextEditingController();
  final _emailEditController = TextEditingController();
  final _telephoneEditController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String imagePath = 'assets/images/profil.png';
  String? _selectedSexe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: myblueColor,
        centerTitle: true,
        title: const Text(
          "Nouveau Etudiant",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showSelectionDialog();
                      },
                      child: Container(
                        child: ClipOval(
                          child: _image == null
                              ? Image.asset(
                                  "assets/images/profil.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {
                          _showSelectionDialog();
                        },
                        elevation: 2.0,
                        fillColor: const Color(0xFFF5F6F9),
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt_outlined,
                            color: Colors.blueGrey),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nomEditController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Le champs ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        hintText: "Nom ",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _prenomEditController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Le champs ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        hintText: "Prénom",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _adresseEditController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Le champs ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on),
                        filled: true,
                        hintText: "Adresse",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailEditController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Le champs ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        hintText: "Email",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _telephoneEditController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Le champs ne doit pas être vide";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        filled: true,
                        hintText: "Téléphone",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedSexe,
                      items:
                          <String>['Masculin', 'Féminin'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSexe = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        hintText: "Sexe",
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => value == null
                          ? 'Le champs ne doit pas être vide'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ElevatedButton(
                        onPressed: () {
                          _handleSubmit(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myblueColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        child: const Text(
                          "Enregistrer",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Sélectionner votre photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('Galerie'),
              onPressed: () async {
                await selectOrTakePhoto(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            SimpleDialogOption(
              child: const Text('Appareil photo'),
              onPressed: () async {
                await selectOrTakePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagePath = pickedFile.path;
      } else {
        print('No photo was selected or taken');
      }
    });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      if (_formkey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              title: Text("Enregistrement en cours..."),
            );
          },
        );

        final etudiant = Etudiant(
          id: null, // Let the database generate an auto-incrementing ID
          nom: _nomEditController.text,
          prenom: _prenomEditController.text,
          adresse: _adresseEditController.text,
          email: _emailEditController.text,
          telephone: int.parse(_telephoneEditController.text),
          imagePath: imagePath,
          sexe: _selectedSexe!,
        );

        print('Données à insérer: ${etudiant.toMap()}');

        int result = await DatabaseHelper.instance.insertEtudiant(etudiant);

        Navigator.pop(context); // Fermer le dialogue

        if (result != -1) {
          _showSuccessMessage(context);
        } else {
          _showErrorMessage(context);
        }
      }
    } catch (e) {
      print("Erreur lors de l'ajout de l'étudiant: $e");
      Navigator.pop(context); // Fermer le dialogue en cas d'erreur
      _showErrorMessage(context);
    }
  }

  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Etudiant enregistré avec succès!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListeEtudiantScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "Une erreur s'est produite lors de l'enregistrement de l'étudiant."),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
