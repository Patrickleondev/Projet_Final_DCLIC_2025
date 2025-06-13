import 'package:flutter/material.dart';
import 'ecrans/connexion_ecran.dart';
import 'ecrans/inscription_ecran.dart';
import 'ecrans/liste_notes_ecran.dart';
import 'ecrans/edition_note_ecran.dart';
import 'ecrans/a_propos_ecran.dart';

void main() {
  runApp(NoteZoneApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/connexion');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 120),
            const SizedBox(height: 24),
            const Text(
              'NoteZone',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(color: Colors.purple),
          ],
        ),
      ),
    );
  }
}

class NoteZoneApp extends StatelessWidget {
  const NoteZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteZone',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/connexion': (context) => ConnexionEcran(),
        '/inscription': (context) => InscriptionEcran(),
        '/liste_notes': (context) => ListeNotesEcran(),
        '/edition_note': (context) => EditionNoteEcran(),
        '/a_propos': (context) => AProposEcran(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
    );
  }
}
