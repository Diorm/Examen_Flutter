import 'dart:io';

import 'package:examen_flutter/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:examen_flutter/models/utilisateurs.dart';
import 'package:examen_flutter/screens/login_screen.dart';
import 'package:examen_flutter/services/database_helper.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Utilisateur? _utilisateur;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _utilisateur = await DatabaseHelper.instance.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Ajouter la logique de déconnexion ici
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginScreen();
                  },
                ),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _utilisateur?.image_path != null
                        ? Center(
                            child: ClipOval(
                              child: Image.file(
                                File(
                                  _utilisateur!.image_path!,
                                ),
                                height: 200,
                                width: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : const Icon(Icons.person, size: 64),
                    SizedBox(height: 25),
                    Text(
                      'Nom: ${_utilisateur?.nom ?? ''}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: myblueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Prénom: ${_utilisateur?.prenom ?? ''}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: myblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: ${_utilisateur?.email ?? ''}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: myblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Adresse: ${_utilisateur?.adresse ?? ''}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: myblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginScreen();
                    },
                  ),
                  (_) => false,
                );
              },
              child: Text(
                'Déconnexion',
                style: TextStyle(
                    color: myredColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
