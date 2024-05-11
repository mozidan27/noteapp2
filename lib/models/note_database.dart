import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note2/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  // isar instance
  static late Isar isar;

  // initialize _database
  static Future<void> initialize() async {
    // open isar
    final dir = await getApplicationDocumentsDirectory();
    // open isar
    isar = await Isar.open([NoteSchema], directory: dir.path);
    // create a note
  }

  // list of notes
  final List<Note> currentNotes = [];

  // create - a note and save to db
  Future<void> addNote(String textFromUser) async {
    // create a new note object
    final newNote = Note()..text = textFromUser;
    // save to db
    await isar.writeTxn(
      () => isar.notes.put(newNote),
      // re-read from db
    );
    fetchNotes();
  }

  // read - notes from db
  Future<void> fetchNotes() async {
    // read from db
    List<Note> fechedNotes = await isar.notes.where().findAll();
    // update currentNotes
    currentNotes.clear();
    // add all notes to currentNotes
    currentNotes.addAll(fechedNotes);
    notifyListeners();
  }

  // update - note in db
  Future<void> updateNote(int id, String newText) async {
    // get existing note
    final existingNote = await isar.notes.get(id);
    // update note
    if (existingNote != null) {
      // update text
      existingNote.text = newText;
      // save to db
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // re-read from db
      await fetchNotes();
    }
  }

  // delete - note from db
  Future<void> deleteNote(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.notes.delete(id));
    // re-read from db
    await fetchNotes();
  }
}
