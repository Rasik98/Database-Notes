import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_databas/Model/note_database.dart';
import 'package:isar_databas/components/drawer.dart';
import 'package:isar_databas/components/note_tile.dart';
import 'package:provider/provider.dart';

import '../Model/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller to access what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readNote();
  }

  // create anote
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteData>().addNote(textController.text);

              textController.clear();

              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // read notes
  void readNote() {
    context.read<NoteData>().fetchNote();
  }

  // update a note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Updata Note'),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteData>().updateNote(note.id, textController.text);

              textController.clear();

              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteData>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final notedata = context.watch<NoteData>();

    // current notes
    List<Note> currentNotes = notedata.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: createNote,
          child: Icon(Icons.add, 
          color: Theme.of(context).colorScheme.inversePrimary,)),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];

                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
