import 'package:flutter/material.dart';
import '../bd/aide_base_de_donnees.dart';
import '../modeles/utilisateur.dart';

class InscriptionEcran extends StatefulWidget {
  const InscriptionEcran({super.key});

  @override
  InscriptionEcranState createState() => InscriptionEcranState();
}

class InscriptionEcranState extends State<InscriptionEcran> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomUtilisateurController =
      TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();
  String? _erreur;
  bool _chargement = false;
  bool _motDePasseVisible = false; // Ajout de la variable pour la visibilité

  Future<void> _inscrire() async {
    setState(() {
      _erreur = null;
      _chargement = true;
    });
    if (_motDePasseController.text != _confirmationController.text) {
      setState(() {
        _erreur = 'Les mots de passe ne correspondent pas.';
        _chargement = false;
      });
      return;
    }
    if (_nomUtilisateurController.text.isEmpty ||
        _motDePasseController.text.isEmpty) {
      setState(() {
        _erreur = 'Tous les champs sont obligatoires.';
        _chargement = false;
      });
      return;
    }
    final db = await AideBaseDeDonnees.instance.database;
    final utilisateurs = await db.query(
      'utilisateurs',
      where: 'nom_utilisateur = ?',
      whereArgs: [_nomUtilisateurController.text],
    );
    if (utilisateurs.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        _erreur = 'Nom d\'utilisateur déjà pris.';
        _chargement = false;
      });
      return;
    }
    await db.insert(
      'utilisateurs',
      Utilisateur(
        nomUtilisateur: _nomUtilisateurController.text,
        motDePasse: _motDePasseController.text,
      ).toMap(),
    );
    if (!mounted) return;
    setState(() {
      _chargement = false;
    });
    Navigator.pushReplacementNamed(context, '/connexion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B2FF2), Color(0xFF1A82FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.only(
                top: 48,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Inscription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Image.asset('assets/logo.png', height: 120),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nomUtilisateurController,
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _motDePasseController,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _motDePasseVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _motDePasseVisible = !_motDePasseVisible;
                            });
                          },
                        ),
                      ),
                      obscureText:
                          !_motDePasseVisible, // Basculer la visibilité
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmationController,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _motDePasseVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _motDePasseVisible = !_motDePasseVisible;
                            });
                          },
                        ),
                      ),
                      obscureText:
                          !_motDePasseVisible, // Basculer la visibilité
                    ),
                    SizedBox(height: 16),
                    if (_erreur != null)
                      Text(_erreur!, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 16),
                    _chargement
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: _inscrire,
                          child: Text('S\'inscrire'),
                        ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacementNamed(
                            context,
                            '/connexion',
                          ),
                      child: Text('Déjà un compte ? Se connecter'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
