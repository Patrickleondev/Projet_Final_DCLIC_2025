import 'package:flutter/material.dart';
import '../modeles/note.dart';

class CarteNote extends StatelessWidget {
  final Note note;
  final VoidCallback? onNoteChanged;
  final VoidCallback? onDelete;

  const CarteNote({
    super.key,
    required this.note,
    this.onNoteChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(note.titre),
        subtitle: Text(note.contenu),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(getTempsRelatif(note.dateCreation)),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete, // Appelle la méthode de suppression
            ),
          ],
        ),
        onTap: () async {
          await Navigator.pushNamed(context, '/edition_note', arguments: note);
          if (onNoteChanged != null) onNoteChanged!();
        },
      ),
    );
  }

  String getTempsRelatif(String dateCreation) {
    final date = DateTime.tryParse(dateCreation);
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inSeconds < 60) {
      return "à l'instant";
    } else if (difference.inMinutes < 60) {
      return 'il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'il y a ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return 'il y a ${difference.inDays} jours';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }
}
