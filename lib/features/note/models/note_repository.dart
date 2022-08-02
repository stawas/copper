import 'dart:ffi';

import 'note.dart';
import '../data/result.dart';


abstract class NoteRepository {
  Future<Result<List<Note>>> fetchNotes();
  Future<Result<Note>> fetchNote(String id);
  Future<Result<Void>> saveNote(Note note);
  Future<Result<Void>> deleteNote(String id);
}
