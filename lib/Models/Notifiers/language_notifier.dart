
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class LanguageNotfier with ChangeNotifier {

  String _language = '';
  String get language => _language;

  set language(String newValue) {
    _language = newValue;
    notifyListeners();
  }

  languageChosen(int i) {
    DataHolder().selectedLanguage = LanguageType.values[i];
    switch(i) {
      case 0:
        language = 'Русский';
        break;
      case 1:
        language = 'Қазақ';
        break;
      case 2:
        language = 'English';
        break;
    }
  }
}