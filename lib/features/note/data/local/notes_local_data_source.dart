
import 'dart:ffi';

import '../../models/note.dart';
import '../../models/note_repository.dart';
import '../result.dart';

class NotesLocalDataSource implements NoteRepository {
  @override
  Future<Result<Void>> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Result<Note>> fetchNote(String id) {
    // TODO: implement fetchNote
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Note>>> fetchNotes() {
    // TODO: implement fetchNotes
    throw UnimplementedError();
  }

  @override
  Future<Result<Void>> saveNote(Note note) {
    // TODO: implement saveNote
    throw UnimplementedError();
  }
  

  

}