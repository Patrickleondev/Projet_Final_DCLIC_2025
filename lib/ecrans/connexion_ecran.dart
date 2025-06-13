import 'package:flutter/material.dart';
import '../bd/aide_base_de_donnees.dart';

class ConnexionEcran extends StatefulWidget {
  const ConnexionEcran({super.key});

  @override
  ConnexionEcranState createState() => ConnexionEcranState();
}

class ConnexionEcranState extends State<ConnexionEcran> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomUtilisateurController =
      TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  String? _erreur;
  bool _chargement = false;

  Future<void> _connecter() async {
    setState(() {
      _erreur = null;
      _chargement = true;
    });
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
      where: 'nom_utilisateur = ? AND mot_de_passe = ?',
      whereArgs: [_nomUtilisateurController.text, _motDePasseController.text],
    );
    if (!mounted) return;

    if (utilisateurs.isEmpty) {
      setState(() {
        _erreur = 'Nom d\'utilisateur ou mot de passe incorrect.';
        _chargement = false;
      });
      return;
    }
    setState(() {
      _chargement = false;
    });
    Navigator.pushReplacementNamed(
      context,
      '/liste_notes',
      arguments: _nomUtilisateurController.text,
    );
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
                    'Connexion',
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
                      decoration: InputDecoration(labelText: 'Mot de passe'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    if (_erreur != null)
                      Text(_erreur!, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 16),
                    _chargement
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: _connecter,
                          child: Text('Se connecter'),
                        ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacementNamed(
                            context,
                            '/inscription',
                          ),
                      child: Text('Pas encore de compte ? S\'inscrire'),
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
