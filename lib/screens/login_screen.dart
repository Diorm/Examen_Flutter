import 'package:examen_flutter/models/utilisateurs.dart';
import 'package:examen_flutter/screens/home_screen.dart';
import 'package:examen_flutter/screens/signup_screen.dart';
import 'package:examen_flutter/services/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:examen_flutter/theme/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordInVisible = true;
  final _formkeyLocal = GlobalKey<FormState>();
  final _formkeyFirebase = GlobalKey<FormState>();

  final _emailEditControllerLocal = TextEditingController();
  final _passwordEditControllerLocal = TextEditingController();
  final _emailEditControllerFirebase = TextEditingController();
  final _passwordEditControllerFirebase = TextEditingController();
  final _auth = auth.FirebaseAuth.instance;

  @override
  void dispose() {
    _emailEditControllerLocal.dispose();
    _passwordEditControllerLocal.dispose();
    _emailEditControllerFirebase.dispose();
    _passwordEditControllerFirebase.dispose();
    super.dispose();
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
          'Connectez-vous pour continuer ',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                tabs: const [
                  Tab(text: 'Local'),
                  Tab(text: 'Firebase'),
                ],
                indicatorColor: myblueColor,
                labelColor: myblueColor,
                unselectedLabelColor: Colors.black,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildLocalLogin(context),
                    _buildFirebaseLogin(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocalLogin(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 25),
                  child: Image.asset(
                    "assets/images/ucao.png",
                    height: 140,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      color: myredColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                )
              ],
            ),
            const SizedBox(height: 10),
            Form(
              key: _formkeyLocal,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: _emailEditControllerLocal,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "le champs ne doit pas etre vide";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: _passwordEditControllerLocal,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "le champs ne doit pas etre vide";
                        }
                        return null;
                      },
                      obscureText: _passwordInVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordInVisible = !_passwordInVisible;
                            });
                          },
                          icon: Icon(
                            _passwordInVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
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
                          _handleSubmitLocal(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: myblueColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        child: const Text(
                          "Connexion",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nouveau membre ? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text(
                          'Inscrivez-vous',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myredColor,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirebaseLogin(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 25),
                  child: Image.asset(
                    "assets/images/ucao.png",
                    height: 150,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      color: myredColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                )
              ],
            ),
            Form(
              key: _formkeyFirebase,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: _emailEditControllerFirebase,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "le champs ne doit pas etre vide";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: _passwordEditControllerFirebase,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "le champs ne doit pas etre vide";
                        }
                        return null;
                      },
                      obscureText: _passwordInVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordInVisible = !_passwordInVisible;
                            });
                          },
                          icon: Icon(
                            _passwordInVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
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
                          _authentificationToFirebase(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: myblueColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        child: const Text(
                          "Connexion au Firebase",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nouveau membre ? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text(
                          'Inscrivez-vous',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myredColor,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitLocal(BuildContext context) async {
    if (_formkeyLocal.currentState!.validate()) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              backgroundColor: myredColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Authentification en cours...",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Montserrat-Bold',
                  color: myredColor,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      var email = _emailEditControllerLocal.text.trim();
      var password = _passwordEditControllerLocal.text.trim();

      try {
        Utilisateur? user =
            await DatabaseHelper.instance.checkUserLogin(email, password);
        Navigator.of(context).pop();
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Authentification réussie',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text('Email ou mot de passe incorrect'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: myredColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Erreur: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: myredColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _authentificationToFirebase(BuildContext context) async {
    if (_formkeyFirebase.currentState!.validate()) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              backgroundColor: myredColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Authentification en cours...",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Montserrat-Bold',
                  color: myredColor,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      var email = _emailEditControllerFirebase.text.trim();
      var password = _passwordEditControllerFirebase.text.trim();

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Authentification réussie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Erreur: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: myredColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        print(e);
      }
    }
  }
}
