import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class NoteTitleTextField extends StatefulWidget {

  NoteTitleTextField({this.note});
  Note note;

  @override
  _NoteTitleTextFieldState createState() => _NoteTitleTextFieldState();
}

class _NoteTitleTextFieldState extends State<NoteTitleTextField> {

  TextEditingController titleController;

  void initState() {
    super.initState();
    titleController = new TextEditingController(
      text: widget.note.title == null ? '' : widget.note.title,
    );

  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newValue) {
        widget.note.title = newValue;
      },
      controller: titleController,
      autocorrect: false,
      minLines: 1,
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      style: CustomTextStyle().bold(context, FontSize.f14, Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: Strings().title,
        hintStyle: CustomTextStyle().regular(context, FontSize.f14, CustomColor().appGray),
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
