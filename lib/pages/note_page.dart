import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note2/models/note.dart';
import 'package:note2/models/note_database.dart';
import 'package:note2/widgets/drawer.dart';
import 'package:note2/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //create a text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // on app startup, fetch existing notes
    readNotes();
  }

  //create a note
  void createNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          decoration: const InputDecoration(hintText: 'Enter your note'),
          controller: textController,
        ),
        actions: [
          // create  button
          MaterialButton(
            onPressed: () {
              // add to db
              context.read<NoteDatabase>().addNote(textController.text);
              //clear the text field
              textController.clear();
              //close the dialog
              Navigator.pop(context);
            },
            child: const Text('create'),
          ),
        ],
      ),
    );
  }
  // read notes

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Note'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //update the note
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              //close the dialog
              Navigator.pop(context);
              //clear the text field
              textController.clear();
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  // delete a note

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //get the database
    final noteDatabase = context.watch<NoteDatabase>();
    //get the current notes
    List<Note> currentNotess = noteDatabase.currentNotes;
    return Consumer(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          onPressed: () => createNote(context),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
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
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentNotess.length,
                itemBuilder: (context, index) {
                  //get the individual note
                  final note = currentNotess[index];
                  return currentNotess.isEmpty
                      ? const Center(
                          child: Text(
                            'No Notes',
                            style: TextStyle(color: Colors.brown),
                          ),
                        )
                      : NoteTile(
                          text: note.text,
                          onDeletePressed: (p0) => deleteNote(note.id),
                          onEditPressed: (p0) => updateNote(note),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
