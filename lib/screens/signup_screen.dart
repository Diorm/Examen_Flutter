import 'package:examen_flutter/models/utilisateurs.dart';
import 'package:examen_flutter/screens/login_screen.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordInVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _adresseController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateNaissanceController = TextEditingController();

  DateTime? _selectedDate;
  File? _image;
  final picker = ImagePicker();

  Future getImage(bool fromCamera) async {
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Aucune Image insérée");
      }
    });
  }

  final List<String> _genderItems = ['Masculin', 'Féminin'];
  String? _selectedGender;

  bool isEmail(String input) =>
      RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(input);

  bool isPhone(String input) => RegExp(r'^[0-9]{9}$').hasMatch(input);

  @override
  void dispose() {
    _adresseController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateNaissanceController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        print("Tentative de création de l'utilisateur dans Firebase");
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        print(
            "Utilisateur créé dans Firebase avec succès : ${userCredential.user?.uid}");

        Utilisateur user = Utilisateur(
          id: DateTime.now().millisecondsSinceEpoch,
          prenom: _prenomController.text.trim(),
          nom: _nomController.text.trim(),
          adresse: _adresseController.text.trim(),
          telephone: _telephoneController.text.trim(),
          sexe: _selectedGender!,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          date_naissance: _selectedDate!,
          image_path: _image?.path ?? '',
        );

        print(
            "Tentative d'insertion de l'utilisateur dans la base de données SQLite");
        int insertedId = await DatabaseHelper.instance.insertUser(user);

        if (insertedId != 0) {
          print(
              "Utilisateur inséré dans la base de données SQLite avec succès");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inscription réussie!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          throw Exception(
              "Échec de l'insertion dans la base de données SQLite");
        }
      } catch (e) {
        print("Échec de l'inscription : $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'inscription: $e')),
        );
      }
    } else {
      print("Le formulaire n'est pas valide");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: myblueColor,
        title: const Text(
          "Nouveau Utilisateur",
          style: TextStyle(
              fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildImagePicker(),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                        controller: _prenomController, label: 'Prénom'),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                        controller: _nomController, label: 'Nom'),
                    const SizedBox(height: 20.0),
                    _buildTextFormField(
                        controller: _adresseController, label: 'Adresse'),
                    const SizedBox(height: 20),
                    _buildDropdownFormField(),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _telephoneController,
                      label: 'Numéro téléphone',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Le champ ne doit pas être vide";
                        }
                        if (!isPhone(value)) {
                          return "Numéro de téléphone invalide";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildDateField(context),
                    const SizedBox(height: 20.0),
                    _buildTextFormField(
                      controller: _emailController,
                      label: 'E-mail',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Le champ ne doit pas être vide";
                        }
                        if (!isEmail(value)) return "E-mail invalide";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    _buildPasswordField(),
                    const SizedBox(height: 20.0),
                    _buildSubmitButton(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSignInText(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        InkWell(
          onTap: () => _showImagePickerOptions(),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: _image != null
                ? Image.file(
                    _image!.absolute,
                    fit: BoxFit.cover,
                  )
                : Center(child: Image.asset("assets/images/person.jpg")),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
              onPressed: () => _showImagePickerOptions(),
              child: const Text(
                "Choisir une image",
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () {
                  getImage(false);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Caméra'),
                onTap: () {
                  getImage(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator ??
          (value) => value!.isEmpty ? "Le champ ne doit pas être vide" : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDropdownFormField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: _genderItems.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
      validator: (value) => value == null || value.isEmpty
          ? "Veuillez sélectionner un sexe"
          : null,
      decoration: InputDecoration(
        labelText: 'Sexe',
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: _passwordInVisible,
      validator: (value) {
        if (value!.isEmpty) {
          return "Le champ ne doit pas être vide";
        }
        if (value.length < 6) {
          return "Le mot de passe doit contenir au moins 6 caractères";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
              _passwordInVisible ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _passwordInVisible = !_passwordInVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dateNaissanceController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date de naissance',
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      validator: (value) =>
          value!.isEmpty ? "Le champ ne doit pas être vide" : null,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateNaissanceController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: myblueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _signUp,
        child: const Center(
          child: Text(
            "Enregistrer",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: Text(
        "Déjà utilisateur? Connectez-vous",
        style: TextStyle(color: myredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
