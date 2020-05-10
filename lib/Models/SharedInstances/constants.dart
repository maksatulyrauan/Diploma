import 'package:diploma_note/Models/SharedInstances/custom_padding.dart';
import 'package:diploma_note/Utilities/enumerations.dart';

class Constants {
  static final Constants _singleton = Constants._internal();

  factory Constants() {
    return _singleton;
  }

  Constants._internal();

  String apiEndpoint = 'http://192.168.0.43:8000/';//'http://3.15.142.134/';
  String token;
  AppState state;
  double width;
  double statusBarHeight;
  double safeAreaBottomHeight;
  CustomPadding customPadding;
}