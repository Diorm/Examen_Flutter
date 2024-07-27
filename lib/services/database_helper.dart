import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:examen_flutter/models/etudiants.dart';
import 'package:examen_flutter/models/utilisateurs.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE utilisateurs(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      prenom TEXT NOT NULL,
      nom TEXT NOT NULL,
      adresse TEXT NOT NULL,
      telephone TEXT NOT NULL,
      sexe TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      date_naissance TEXT NOT NULL,
      image_path TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE etudiants(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        prenom TEXT,
        adresse TEXT,
        email TEXT,
        telephone INTEGER,
        image_path TEXT,
        sexe TEXT
      )
    ''');
  }

  Future<int> insertEtudiant(Etudiant etudiant) async {
    Database db = await instance.database;
    try {
      return await db.insert(
        'etudiants',
        etudiant.toMap(),
      );
    } catch (e) {
      print("Erreur lors de l'insertion de l'étudiant: $e");
      return -1; // Retourner une valeur indiquant une erreur
    }
  }

  Future<Utilisateur?> checkUserLogin(String email, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'utilisateurs',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return Utilisateur.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> insertUser(Utilisateur user) async {
    final db = await instance.database;
    try {
      return await db.insert('utilisateurs', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Erreur lors de l'insertion de l'utilisateur: $e");
      return -1; // Retourner une valeur indiquant une erreur
    }
  }

  Future<int> deleteEtudiant(int id) async {
    final db = await instance.database;
    try {
      return await db.delete(
        'etudiants',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Erreur lors de la suppression de l'étudiant: $e");
      return -1; // Retourner une valeur indiquant une erreur
    }
  }

  Future<List<Etudiant>> getEtudiants() async {
    Database db = await instance.database;
    try {
      List<Map<String, dynamic>> maps = await db.query('etudiants');
      return List.generate(maps.length, (i) {
        return Etudiant.fromMap(maps[i]);
      });
    } catch (e) {
      print("Erreur lors de la récupération des étudiants: $e");
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<int> updateUserImagePath(int userId, String path) async {
    final db = await instance.database;
    try {
      return await db.update(
        'utilisateurs',
        {'image_path': path},
        where: 'id = ?',
        whereArgs: [userId],
      );
    } catch (e) {
      print("Erreur lors de la mise à jour de l'image utilisateur: $e");
      return -1; // Retourner une valeur indiquant une erreur
    }
  }

  Future<String?> getUserImagePath(int userId) async {
    final db = await instance.database;
    try {
      final result = await db.query(
        'utilisateurs',
        columns: ['image_path'],
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (result.isNotEmpty) {
        return result.first['image_path'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print(
          "Erreur lors de la récupération du chemin de l'image utilisateur: $e");
      return null; // Retourner null en cas d'erreur
    }
  }

  Future<Utilisateur?> getUser() async {
    final db = await instance.database;
    try {
      final result = await db.query(
        'utilisateurs',
        limit: 1,
      );
      if (result.isNotEmpty) {
        return Utilisateur.fromMap(result.first);
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération de l'utilisateur: $e");
      return null; // Retourner null en cas d'erreur
    }
  }
}
