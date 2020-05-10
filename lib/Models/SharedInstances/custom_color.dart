import 'dart:ui';

class CustomColor {
  static final CustomColor _singleton = CustomColor._internal();

  factory CustomColor() {
    return _singleton;
  }

  CustomColor._internal();

  Color appBlue = Color(0xff7987FF);
  Color appGray = Color(0xff868686);
  Color appGreen = Color(0xff40b509);
  Color appRed = Color(0xffFF7979);
  Color appYellow = Color(0xffFFC107);
  Color appBlueLight = Color(0xffDCE0FF);
}