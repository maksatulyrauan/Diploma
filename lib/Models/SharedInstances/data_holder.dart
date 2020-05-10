import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/Objects/notebook.dart';
import 'package:diploma_note/Utilities/enumerations.dart';

class DataHolder {
  static final DataHolder _singleton = DataHolder._internal();

  factory DataHolder() {
    return _singleton;
  }

  DataHolder._internal();

  LanguageType selectedLanguage = LanguageType.russian;
  List<Note> allNotes = [];
  List<Note> allFavouriteNotes = [];
  List<Notebook> notebooks = [];

  Note editingNote;
}