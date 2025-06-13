class Utilisateur {
  int? id;
  String nomUtilisateur;
  String motDePasse;

  Utilisateur({
    this.id,
    required this.nomUtilisateur,
    required this.motDePasse,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom_utilisateur': nomUtilisateur,
      'mot_de_passe': motDePasse,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      id: map['id'],
      nomUtilisateur: map['nom_utilisateur'],
      motDePasse: map['mot_de_passe'],
    );
  }
}
