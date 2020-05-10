import 'package:diploma_note/Models/SharedInstances/constants.dart';

class CustomPadding {
  static final CustomPadding _singleton = CustomPadding._internal();

  factory CustomPadding() {
    return _singleton;
  }

  CustomPadding._internal();

  double f10() {
    return Constants().width / 37.5;
  }
  double f12() {
    return Constants().width / 31.25;
  }
  double f13() {
    return Constants().width / 28.85;
  }
  double f14() {
    return Constants().width / 26.79;
  }
  double f15() {
    return Constants().width / 25;
  }
  double f16() {
    return Constants().width / 23.44;
  }
  double f18() {
    return Constants().width / 20.83;
  }
  double f20() {
    return Constants().width / 18.75;
  }
  double f21() {
    return Constants().width / 17.86;
  }
  double f34() {
    return Constants().width / 11.03;
  }
  double h40() {
    return Constants().width / 8;
  }
}