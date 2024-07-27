import 'dart:io';

import 'package:examen_flutter/models/utilisateurs.dart';
import 'package:examen_flutter/screens/Liste_etudiants.dart';
import 'package:examen_flutter/screens/home_screen.dart';
import 'package:examen_flutter/screens/profil_screen.dart';
import 'package:examen_flutter/screens/semesre_screen/semestre_list.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  Utilisateur? utilisateur;
  File? _image;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    utilisateur = await DatabaseHelper.instance.getUser();
    if (utilisateur != null) {
      setState(() {
        _image = File(utilisateur!.image_path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [myblueColor, myredColor],
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _image == null
                  ? const AssetImage("assets/images/profil.png")
                  : FileImage(_image!) as ImageProvider,
              radius: 40,
            ),
            accountName: Text(
              utilisateur == null
                  ? 'Utilisateur'
                  : '${utilisateur!.prenom} ${utilisateur!.nom}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              utilisateur == null ? '' : utilisateur!.email,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  text: 'Accueil',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.group_add_rounded,
                  text: 'Liste Etudiants',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListeEtudiantScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.book,
                  text: 'Liste Semestres',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SemestreList()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.manage_accounts,
                  text: 'Profil',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.call,
                  text: 'Service Client',
                  onTap: () {
                    _AppellerMoi();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.exit_to_app,
                  text: 'Quitter',
                  onTap: () {
                    exit(0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: myblueColor),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  void _AppellerMoi() async {
    const numeroServiceClient = "221 77 7016652";
    await launch("tel:$numeroServiceClient");
  }
}
