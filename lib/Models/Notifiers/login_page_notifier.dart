import 'package:flutter/material.dart';

class LoginPageNotifier with ChangeNotifier {

  int _currentPage = 0;
  int get currentPage => _currentPage;

  set currentPage(int newValue) {
    _currentPage = newValue;
    notifyListeners();
  }
}