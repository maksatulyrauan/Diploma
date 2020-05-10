import 'package:diploma_note/Models/Objects/note.dart';

class Notebook {
  int id;
  String title;
  int numberOfNotes = 0;
  DateTime dateModified;
  List<Note> notes = [];

  Notebook({this.title});
}