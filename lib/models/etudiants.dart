class Etudiant {
  int? id; // Make id nullable
  String nom;
  String prenom;
  String adresse;
  String email;
  int telephone;
  String? imagePath;
  String sexe;

  Etudiant({
    this.id, // Make id nullable
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.email,
    required this.telephone,
    this.imagePath,
    required this.sexe,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'email': email,
      'telephone': telephone,
      'image_path': imagePath,
      'sexe': sexe,
    };
  }

  factory Etudiant.fromMap(Map<String, dynamic> map) {
    return Etudiant(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      adresse: map['adresse'],
      email: map['email'],
      telephone: map['telephone'],
      imagePath: map['image_path'],
      sexe: map['sexe'],
    );
  }
}
