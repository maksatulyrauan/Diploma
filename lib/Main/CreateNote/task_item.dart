import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {

  TaskItem({this.note, this.noteContent});

  NoteContent noteContent;
  Note note;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    CheckBox checkBox = widget.noteContent.value;
    return Row(
      children: <Widget>[
        Checkbox(
          value: checkBox.isDone,
          checkColor: Colors.white,
          activeColor: CustomColor().appBlue,
          onChanged: (newValue) {
            setState(() {
              checkBox.isDone = newValue;
            });

          },
        ),
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (newValue) {
              checkBox.text = newValue;
              setState(() {
                if(newValue == '') {
                  setState(() {
                    widget.note.content.removeLast();
                    addText();
                  });
                }
                else {
                  addTask();
                }

              });
            },
            autofocus: true,
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
          ),
        ),
      ],
    );
  }

  addTask() {
    print('1');
    NoteContent noteContent = NoteContent();
    noteContent.type = NoteContentType.checkBox;
    noteContent.value = CheckBox();
    widget.note.content.add(noteContent);
//    setState(() {
//
//      print('2');
//    });
  }

  addText() {
    setState(() {
      NoteContent noteContent = NoteContent();
      noteContent.type = NoteContentType.text;
      noteContent.value = '';
      widget.note.content.add(noteContent);
    });
  }
}
