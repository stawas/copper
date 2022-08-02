import 'dart:ffi';

import 'package:copper/data/result.dart';
import 'package:copper/models/note.dart';

abstract class NoteRepository {
  Future<Result<List<Note>>> fetchNotes();
  Future<Result<Note>> fetchNote(String id);
  Future<Result<Void>> saveNote(Note note);
  Future<Result<Void>> deleteNote(String id);
}
