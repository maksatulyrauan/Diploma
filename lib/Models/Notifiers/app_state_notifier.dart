import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class AppStateNotifier with ChangeNotifier {

  AppState _appState = Constants().state;
  AppState get appState => _appState;

  set appState(AppState newValue) {
    Constants().state = newValue;
    _appState = newValue;
    notifyListeners();
  }
}