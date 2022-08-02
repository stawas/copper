import 'package:copper/models/note.dart';
import 'package:copper/data/result.dart';
import 'dart:ffi';

import 'package:copper/models/note_repository.dart';

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