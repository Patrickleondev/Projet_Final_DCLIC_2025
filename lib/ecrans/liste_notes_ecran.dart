import 'package:flutter/material.dart';
import '../bd/aide_base_de_donnees.dart';
import '../modeles/note.dart';
import '../widgets/carte_note.dart';

class ListeNotesEcran extends StatefulWidget {
  const ListeNotesEcran({super.key});

  @override
  ListeNotesEcranState createState() => ListeNotesEcranState();
}

class ListeNotesEcranState extends State<ListeNotesEcran> {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _chargement = true;
  String _nomUtilisateur = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chargerNotes();
    _searchController.addListener(_filtrerNotes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String && args != _nomUtilisateur) {
      setState(() {
        _nomUtilisateur = args;
      });
    }
  }

  void _filtrerNotes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNotes =
          _notes
              .where(
                (note) =>
                    note.titre.toLowerCase().contains(query) ||
                    note.contenu.toLowerCase().contains(query),
              )
              .toList();
    });
  }

  Future<void> _chargerNotes() async {
    final db = await AideBaseDeDonnees.instance.database;
    final maps = await db.query('notes', orderBy: 'date_creation DESC');
    setState(() {
      _notes = maps.map((map) => Note.fromMap(map)).toList();
      _filteredNotes = _notes;
      _chargement = false;
    });
  }

  void _supprimerNote(Note note) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer cette note ?'),
          content: Text(
            'Cette action est irréversible. La note "${note.titre}" sera définitivement supprimée.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      final db = await AideBaseDeDonnees.instance.database;
      await db.delete('notes', where: 'id = ?', whereArgs: [note.id]);
      _chargerNotes(); // Recharge les notes après suppression
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mes Notes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bonjour, $_nomUtilisateur',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      tooltip: 'Déconnexion',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/connexion',
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une note...',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _chargement
                    ? Center(child: CircularProgressIndicator())
                    : _filteredNotes.isEmpty
                    ? Center(child: Text('Aucune note. Ajoutez-en une !'))
                    : ListView.builder(
                      itemCount: _filteredNotes.length,
                      itemBuilder: (context, index) {
                        final colors = [
                          Colors.yellow[100],
                          Colors.blue[50],
                          Colors.green[100],
                          Colors.purple[50],
                        ];
                        return Container(
                          color: colors[index % colors.length],
                          child: CarteNote(
                            note: _filteredNotes[index],
                            onNoteChanged: _chargerNotes,
                            onDelete:
                                () => _supprimerNote(_filteredNotes[index]),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7B2FF2),
        onPressed: () async {
          await Navigator.pushNamed(context, '/edition_note');
          _chargerNotes();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'À propos',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/a_propos');
          }
        },
      ),
    );
  }
}
