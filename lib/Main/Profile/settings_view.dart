import 'dart:convert';

import 'package:diploma_note/Models/Notifiers/language_notifier.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  var selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Constants().statusBarHeight),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: 1,
              itemBuilder: (context, position) {
                return buildRow();
              },
            ),
          ),
        ],
      ),
    );
  }

    Widget buildRow() {
      switch(DataHolder().selectedLanguage.index) {
        case 0:
          selectedLanguage = Strings().russian;
          break;
        case 1:
          selectedLanguage = Strings().kazkh;
          break;
        case 2:
          selectedLanguage = Strings().english;
          break;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[

            Consumer<LanguageNotfier>(
              builder: (context, languageNotifier, _) => GestureDetector(
                onTap: () {
                  showPickerArray(languageNotifier);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings().appLanguage,
                      style: CustomTextStyle().semibold(context, FontSize.f16, CustomColor().appBlue),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              languageNotifier.language == '' ? selectedLanguage : languageNotifier.language,
                              style: CustomTextStyle().medium(context, FontSize.f14, Colors.black),
                            ),
                            Icon(
                                Icons.arrow_drop_down
                            )
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Something',
                  style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
                ),
                Icon(
                  Icons.arrow_right,
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Something',
                  style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
                ),
                Icon(
                  Icons.arrow_right,
                )
              ],
            ),
          ],
        ),
      );
    }

  showPickerArray(LanguageNotfier languageNotfier) {

    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(languages), isArray: true),
        hideHeader: true,
        selecteds: [DataHolder().selectedLanguage.index],
        title: new Text(Strings().appLanguageHint),
        onConfirm: (Picker picker, List value) {
          languageNotfier.languageChosen(value[0]);
          setState(() {

          });
        }
    ).showDialog(context);
  }

  final languages = '''[["Русский","Қазақ","English"]]''';
}
