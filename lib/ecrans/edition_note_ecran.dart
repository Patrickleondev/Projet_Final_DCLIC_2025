import 'package:flutter/material.dart';
import '../bd/aide_base_de_donnees.dart';
import '../modeles/note.dart';

class EditionNoteEcran extends StatefulWidget {
  const EditionNoteEcran({super.key});

  @override
  EditionNoteEcranState createState() => EditionNoteEcranState();
}

class EditionNoteEcranState extends State<EditionNoteEcran> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();
  Note? _note;
  bool _chargement = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _note = ModalRoute.of(context)?.settings.arguments as Note?;
    if (_note != null) {
      _titreController.text = _note!.titre;
      _contenuController.text = _note!.contenu;
    }
  }

  Future<void> _sauvegarder() async {
    if (_titreController.text.isEmpty || _contenuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tous les champs sont obligatoires.')),
      );
      return;
    }
    setState(() {
      _chargement = true;
    });
    final db = await AideBaseDeDonnees.instance.database;
    final now = DateTime.now().toIso8601String();
    if (_note == null) {
      await db.insert('notes', {
        'titre': _titreController.text,
        'contenu': _contenuController.text,
        'date_creation': now,
        'utilisateur_id': 1,
      });
    } else {
      await db.update(
        'notes',
        {'titre': _titreController.text, 'contenu': _contenuController.text},
        where: 'id = ?',
        whereArgs: [_note!.id],
      );
    }
    if (!mounted) return;
    setState(() {
      _chargement = false;
    });
    Navigator.pop(context);
  }

  Future<void> _supprimer() async {
    if (_note == null) return;
    setState(() {
      _chargement = true;
    });
    final db = await AideBaseDeDonnees.instance.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [_note!.id]);
    if (!mounted) return;
    setState(() {
      _chargement = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_note == null ? 'Nouvelle Note' : 'Modifier Note'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Flèche de retour corrigée
        ),
        actions: [
          if (_note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _chargement ? null : _supprimer,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titreController,
                decoration: InputDecoration(labelText: 'Titre'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contenuController,
                decoration: InputDecoration(labelText: 'Contenu'),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              _chargement
                  ? CircularProgressIndicator()
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _sauvegarder,
                        child: Text('Sauvegarder'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Annuler'),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
