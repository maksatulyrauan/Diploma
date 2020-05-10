import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class ErrorHandler {

  static final ErrorHandler _singleton = ErrorHandler._internal();

  BuildContext context;

  factory ErrorHandler() {
    return _singleton;
  }

  ErrorHandler._internal();

  void showAlert(BuildContext context, ErrorCodeType errorCodeType) {
    showDialog(
      context: context,
      builder: (BuildContext context) => showConfirmation(context, errorCodeType),
    );
  }

  Widget showConfirmation(BuildContext context, ErrorCodeType errorCodeType) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              errorText(errorCodeType),
              textAlign: TextAlign.center,
              style: CustomTextStyle().regular(
                  context, FontSize.f14, CustomColor().appGray),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: CustomColor().appBlue,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ОК',
                  style: CustomTextStyle().bold(
                      context, FontSize.f12, CustomColor().appBlue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String errorText(ErrorCodeType errorCodeType) {
//    switch(errorCodeType) {
//      case ErrorCodeType.wrong_date_format:
//        switch(selectedLanguageType) {
//          case LanguageType.russian:
//            return 'Некорректный формат даты';
//          case LanguageType.kazakh:
//            return 'Дата форматы бұрыс';
//          case LanguageType.english:
//            return 'Wrong date format';
//        }
//        return '';
//
//    }
  }
}
