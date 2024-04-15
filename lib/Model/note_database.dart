import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:isar_databas/Model/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteData extends ChangeNotifier {
  static late Isar isar;

  // I N I T I A L I Z E - D A T A B A S E _________________
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path);
  }
  // List of Note
  final List<Note> currentNotes = [];

  // C R E A T E - a note and save to db ___________________
  Future<void> addNote(String textFromUser) async {
     // create a new Note object
    final newNote = Note()..text = textFromUser;
     // sace to db
     await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from db
    fetchNote();
  }

  // R E A D - notr from db ________________________________
  Future<void> fetchNote() async {
    List<Note> fetchNote = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNote);
    notifyListeners();
  }

  // U P D A T E - a note in db ____________________________
  Future<void> updateNote(int id, String newtext) async {
    final existingNote = await isar.notes.get(id);
    if(existingNote != null) {
      existingNote.text = newtext;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNote();
    } 
  }
  
  // D E L E T E  - a note from the db _____________________
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNote();
  }
}