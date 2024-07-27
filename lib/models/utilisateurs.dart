class Utilisateur {
  final int id;
  final String prenom;
  final String nom;
  final String adresse;
  final String telephone;
  final String sexe;
  final String email;
  final String password;
  final DateTime date_naissance;
  late final String image_path;

  Utilisateur({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.adresse,
    required this.telephone,
    required this.sexe,
    required this.email,
    required this.password,
    required this.date_naissance,
    required this.image_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prenom': prenom,
      'nom': nom,
      'adresse': adresse,
      'telephone': telephone,
      'sexe': sexe,
      'email': email,
      'password': password,
      'date_naissance': date_naissance.toIso8601String(),
      'image_path': image_path,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      id: map['id'],
      prenom: map['prenom'],
      nom: map['nom'],
      adresse: map['adresse'],
      telephone: map['telephone'],
      sexe: map['sexe'],
      email: map['email'],
      password: map['password'],
      date_naissance: DateTime.parse(map['date_naissance']),
      image_path: map['image_path'],
    );
  }
}
