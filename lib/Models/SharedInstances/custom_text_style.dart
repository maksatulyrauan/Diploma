import 'package:diploma_note/Models/SharedInstances/custom_padding.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  TextStyle bold(BuildContext context, FontSize fontSize, Color color) {
    double size;
    switch(fontSize) {
      case FontSize.f10:
        size = CustomPadding().f10();
        break;
      case FontSize.f12:
        size = CustomPadding().f12();
        break;
      case FontSize.f13:
        size = CustomPadding().f13();
        break;
      case FontSize.f14:
        size = CustomPadding().f14();
        break;
      case FontSize.f15:
        size = CustomPadding().f15();
        break;
      case FontSize.f16:
        size = CustomPadding().f16();
        break;
      case FontSize.f18:
        size = CustomPadding().f18();
        break;
      case FontSize.f20:
        size = CustomPadding().f20();
        break;
      case FontSize.f21:
        size = CustomPadding().f21();
        break;
      case FontSize.f34:
        size = CustomPadding().f34();
        break;
    }

    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
  TextStyle light(BuildContext context, FontSize fontSize, Color color) {

    double size;
    switch(fontSize) {
      case FontSize.f10:
        size = CustomPadding().f10();
        break;
      case FontSize.f12:
        size = CustomPadding().f12();
        break;
      case FontSize.f13:
        size = CustomPadding().f13();
        break;
      case FontSize.f14:
        size = CustomPadding().f14();
        break;
      case FontSize.f15:
        size = CustomPadding().f15();
        break;
      case FontSize.f16:
        size = CustomPadding().f16();
        break;
      case FontSize.f18:
        size = CustomPadding().f18();
        break;
      case FontSize.f20:
        size = CustomPadding().f20();
        break;
      case FontSize.f21:
        size = CustomPadding().f21();
        break;
      case FontSize.f34:
        size = CustomPadding().f34();
        break;
    }

    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w300,
      color: color,
    );
  }
  TextStyle medium(BuildContext context, FontSize fontSize, Color color, {bool underlined = false}) {

    double size;
    switch(fontSize) {
      case FontSize.f10:
        size = CustomPadding().f10();
        break;
      case FontSize.f12:
        size = CustomPadding().f12();
        break;
      case FontSize.f13:
        size = CustomPadding().f13();
        break;
      case FontSize.f14:
        size = CustomPadding().f14();
        break;
      case FontSize.f15:
        size = CustomPadding().f15();
        break;
      case FontSize.f16:
        size = CustomPadding().f16();
        break;
      case FontSize.f18:
        size = CustomPadding().f18();
        break;
      case FontSize.f20:
        size = CustomPadding().f20();
        break;
      case FontSize.f21:
        size = CustomPadding().f21();
        break;
      case FontSize.f34:
        size = CustomPadding().f34();
        break;
    }

    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: underlined ? TextDecoration.underline : null,
    );
  }
  TextStyle regular(BuildContext context, FontSize fontSize, Color color, {bool underlined = false}) {

    double size;
    switch(fontSize) {
      case FontSize.f10:
        size = CustomPadding().f10();
        break;
      case FontSize.f12:
        size = CustomPadding().f12();
        break;
      case FontSize.f13:
        size = CustomPadding().f13();
        break;
      case FontSize.f14:
        size = CustomPadding().f14();
        break;
      case FontSize.f15:
        size = CustomPadding().f15();
        break;
      case FontSize.f16:
        size = CustomPadding().f16();
        break;
      case FontSize.f18:
        size = CustomPadding().f18();
        break;
      case FontSize.f20:
        size = CustomPadding().f20();
        break;
      case FontSize.f21:
        size = CustomPadding().f21();
        break;
      case FontSize.f34:
        size = CustomPadding().f34();
        break;
    }

    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
      decoration: underlined ? TextDecoration.underline : null,
    );
  }
  TextStyle semibold(BuildContext context, FontSize fontSize, Color color) {

    double size;
    switch(fontSize) {
      case FontSize.f10:
        size = CustomPadding().f10();
        break;
      case FontSize.f12:
        size = CustomPadding().f12();
        break;
      case FontSize.f13:
        size = CustomPadding().f13();
        break;
      case FontSize.f14:
        size = CustomPadding().f14();
        break;
      case FontSize.f15:
        size = CustomPadding().f15();
        break;
      case FontSize.f16:
        size = CustomPadding().f16();
        break;
      case FontSize.f18:
        size = CustomPadding().f18();
        break;
      case FontSize.f20:
        size = CustomPadding().f20();
        break;
      case FontSize.f21:
        size = CustomPadding().f21();
        break;
      case FontSize.f34:
        size = CustomPadding().f34();
        break;
    }

    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

}