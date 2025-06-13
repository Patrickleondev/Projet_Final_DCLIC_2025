class Note {
  int? id;
  String titre;
  String contenu;
  String dateCreation;
  int utilisateurId;

  Note({
    this.id,
    required this.titre,
    required this.contenu,
    required this.dateCreation,
    required this.utilisateurId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'contenu': contenu,
      'date_creation': dateCreation,
      'utilisateur_id': utilisateurId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      titre: map['titre'],
      contenu: map['contenu'],
      dateCreation: map['date_creation'],
      utilisateurId: map['utilisateur_id'],
    );
  }
}
