import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class NoteTextField extends StatefulWidget {

  NoteTextField({this.noteContent});

  NoteContent noteContent;

  @override
  _NoteTextFieldState createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newValue) {
        widget.noteContent.value = newValue;
      },

      autocorrect: false,
      minLines: 1,
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: Strings().noteHint,
        hintStyle: CustomTextStyle().medium(context, FontSize.f14, CustomColor().appGray),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1,color: CustomColor().appBlue.withOpacity(0)),
        ),
      ),
    );
  }
}
