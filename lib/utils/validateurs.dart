class Validateurs {
  static String? validerNom(String? nom) {
    if (nom == null || nom.isEmpty) {
      return 'Le nom ne peut pas être vide';
    }
    if (nom.length < 3) {
      return 'Le nom doit contenir au moins 3 caractères';
    }
    return null;
  }

  static String? validerEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'L\'email ne peut pas être vide';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'L\'email n\'est pas valide';
    }
    return null;
  }

  static String? validerMotDePasse(String? motDePasse) {
    if (motDePasse == null || motDePasse.isEmpty) {
      return 'Le mot de passe ne peut pas être vide';
    }
    if (mot de Passe.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }
  static String? validerTitre(String? titre) {
    if (titre == null || titre.isEmpty) {
      return 'Le titre ne peut pas être vide';
    }
    if (titre.length < 3) {
      return 'Le titre doit contenir au moins 3 caractères';
    }
    return null;
  }
  static String? validerContenu(String? contenu) {
    if (contenu == null || contenu.isEmpty) {
      return 'Le contenu ne peut pas être vide';
    }
    if (contenu.length < 10) {
      return 'Le contenu doit contenir au moins 10 caractères';
    }
    return null;
  }
}
