import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AProposEcran extends StatelessWidget {
  const AProposEcran({super.key});

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'gkpl0010@mail.com');
    await launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    final String mentionsLegales = '''
Mentions légales

Nom de l'application : NoteZone

Éditeur : Équipe NoteZone

Contact : gkpl0010@mail.com

Hébergement : Données stockées localement sur l'appareil de l'utilisateur.

Propriété intellectuelle :
L'ensemble des éléments de l'application (textes, images, logo, code source) sont la propriété exclusive de l'équipe NoteZone, sauf mention contraire. Toute reproduction, représentation, modification, publication, adaptation de tout ou partie des éléments de l'application, quel que soit le moyen ou le procédé utilisé, est interdite, sauf autorisation écrite préalable.

Données personnelles :
NoteZone ne collecte ni ne transmet aucune donnée personnelle à des tiers. Toutes les notes et informations saisies par l'utilisateur sont stockées localement sur son appareil.

Responsabilité :
L'équipe NoteZone ne saurait être tenue responsable des dommages directs ou indirects causés à l'appareil de l'utilisateur lors de l'utilisation de l'application.

Licence :
Cette application est distribuée sous licence MIT.

Pour toute question, contactez-nous à : gkpl0010@mail.com
''';

    return Scaffold(
      appBar: AppBar(
        title: Text('À propos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:
              () => Navigator.pushNamed(
                context,
                '/liste_notes',
              ), // Flèche de retour
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 16),
              Text(
                'NoteZone',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "NotesApp est une application moderne et intuitive pour organiser vos idées, pensées et tâches quotidiennes. Conçue pour être simple et efficace.",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Développeur',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  Text('Équipe NoteZone'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Licence',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  Text('MIT License'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Support',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: _launchEmail,
                    child: Text(
                      'gkpl0010@mail.com',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('Mentions légales'),
                          content: SingleChildScrollView(
                            child: Text(mentionsLegales),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Fermer'),
                            ),
                          ],
                        ),
                  );
                },
                child: Text('Mentions légales'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
