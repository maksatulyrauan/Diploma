import 'dart:convert';
//import 'dart:io';
import 'dart:io' as io;

import 'package:audio_recorder/audio_recorder.dart';
import 'package:date_format/date_format.dart';
import 'package:diploma_note/Main/CreateNote/note_content_image.dart';
import 'package:diploma_note/Main/CreateNote/note_text_field.dart';
import 'package:diploma_note/Main/CreateNote/note_title_text_field.dart';
import 'package:diploma_note/Main/CreateNote/task_item.dart';
import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/Objects/notebook.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreateNoteView extends StatefulWidget {
  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {

  TextEditingController tagController;

  LocalFileSystem localFileSystem = LocalFileSystem();
  Note note;

  @override
  void initState() {
    super.initState();
    tagController = new TextEditingController();

    note = Note();
    NoteContent noteContent = NoteContent();
    noteContent.type = NoteContentType.text;
    noteContent.value = '';
    note.content.add(noteContent);
  }

  Future getImage(bool camera) async {
    var image = await ImagePicker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery);

    NoteContent noteContent = NoteContent();
    noteContent.type = NoteContentType.image;
    ImageContent imageContent = ImageContent();
    imageContent.image = image;
    noteContent.value = imageContent;

    note.content.add(noteContent);

    NoteContent _noteContent = NoteContent();
    _noteContent.type = NoteContentType.text;
    _noteContent.value = '';
    note.content.add(_noteContent);


    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {

    print(note.content.length);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialogView(DialogType.photo);
                      },
                      child: Icon(
                        Icons.photo_camera,
                        color: CustomColor().appGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialogView(DialogType.alarm);

                      },
                      child: Icon(
                        Icons.alarm,
                        color: CustomColor().appGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialogView(DialogType.tag);
                      },
                      child: Icon(
                        Icons.error_outline,
                        color: CustomColor().appGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialogView(DialogType.feature);
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: CustomColor().appGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        createNote();
                        Navigator.pop(context);
                      },
                      child: Text(
                        Strings().done,
                        style: CustomTextStyle().bold(context, FontSize.f18, CustomColor().appGreen),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: pickerColor,
                  )
                ),
                child: ListView.builder(
                  itemCount: note.content.length + 1,
                  itemBuilder: (context, position) {
                    switch(position) {
                      case 0:
                        return NoteTitleTextField(note: note);
                      default:
                        final noteContent = note.content.elementAt(position - 1);
                        switch(noteContent.type) {
                          case NoteContentType.text:
                            return NoteTextField(noteContent: noteContent);
                          case NoteContentType.checkBox:
                            return TaskItem(note: note,noteContent: noteContent);
                          case NoteContentType.image:
                            return NoteContentImage(noteContent: noteContent);
                        }
                        return Text('');
                    }
                  },
                ),
              ),
            ),
//            bottomNavbar(),
          ],
        ),
      ),
    );
  }

  createNote() {
    for(var i in note.content) {
      print(i.type);
      print(i.value);
    }
    ApiManager().createNote(note, () {
      DataHolder().allNotes.add(note);
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  Future<Null> _selectDate(BuildContext context) async {

    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(DateTime.now().year + 100),
      currentTime: selectedDate,
      onChanged: (date) {

      },
      onConfirm: (date) {
        setState(() {
          selectedDate = date;
          selectedDateString = formatDate(date, [dd, '.', mm, '.', yyyy]);
        });
      },
      locale: DataHolder().selectedLanguage == LanguageType.russian ? LocaleType.ru :
      DataHolder().selectedLanguage == LanguageType.english ? LocaleType.en : LocaleType.kk,
    );
  }

  Widget bottomNavbar() {
    return Container(
      height: 60 + Constants().safeAreaBottomHeight,
      width: Constants().width,
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.only(bottom: Constants().safeAreaBottomHeight, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showDialogView(DialogType.photo);
              },
              child: Icon(
                Icons.camera,
                color: CustomColor().appGreen,
              ),
            ),
            GestureDetector(
              onTap: () {
                _start();
              },
              child: Icon(
                Icons.keyboard_voice,
                color: CustomColor().appGreen,
              ),
            ),
            Icon(
              Icons.edit,
              color: CustomColor().appGreen,
            ),
            GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.attach_file,
                color: CustomColor().appGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Recording _recording = new Recording();
  bool _isRecording = false;

  TextEditingController _controller = new TextEditingController();

  _start() async {
    try {
      if (await AudioRecorder.hasPermissions) {
        if (_controller.text != null && _controller.text != "") {
          String path = _controller.text;
          if (!_controller.text.contains('/')) {
            io.Directory appDocDirectory =
            await getApplicationDocumentsDirectory();
            path = appDocDirectory.path + '/' + _controller.text;
          }
          print("Start recording: $path");
          await AudioRecorder.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          await AudioRecorder.start();
        }
        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          _recording = new Recording(duration: new Duration(), path: "");
          _isRecording = isRecording;
        });
      } else {
//        Scaffold.of(context).showSnackBar(
//            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    _controller.text = recording.path;
  }

  Widget _showPhotoChoose() {
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
              Strings().choose,
              textAlign: TextAlign.center,
              style: CustomTextStyle().regular(
                  context, FontSize.f14, CustomColor().appGray),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: CustomColor().appBlue,
                ),
                child: FlatButton(
                  onPressed: () {
                    getImage(true);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Strings().camera,
                    style: CustomTextStyle().bold(
                        context, FontSize.f12, CustomColor().appBlueLight),
                  ),
                ),
              ),
              Container(
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
                    getImage(false);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Strings().gallery,
                    style: CustomTextStyle().bold(context, FontSize.f12, CustomColor().appBlueLight),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }




  //Share

  void showDialogView(DialogType dialogType) {
    showDialog(
      context: context,
      builder: (BuildContext context) => dialogType == DialogType.addToNotebook ? showAddToNotebookDialog() :
      dialogType == DialogType.alarm ? showAlarmDialog() :
      dialogType == DialogType.photo ? _showPhotoChoose() :
      dialogType == DialogType.feature ? showFeatureChoose() : showTagDialog(),
    );
  }

  Widget showAddToNotebookDialog() {

    int selectedNotebookId;

    return StatefulBuilder(
      builder: (context, setState)
      {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    Strings().addToNotebook,
                    style: CustomTextStyle().regular(
                        context, FontSize.f14, CustomColor().appGray),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: Constants().width,
                    height: 200,
                    child: ListView.builder(
                      itemCount: DataHolder().notebooks.length,
                      itemBuilder: (context, position) {
                        Notebook notebook = DataHolder().notebooks.elementAt(position);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedNotebookId = notebook.id;
                            });

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              notebook.title,
                              style: CustomTextStyle().regular(context, FontSize.f12, selectedNotebookId == notebook.id ? CustomColor().appBlue : Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: CustomColor().appBlue,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());


                        },
                        child: Text(
                          Strings().done,
                          style: CustomTextStyle().bold(
                              context, FontSize.f12, Colors.white),
                        ),
                      ),
                    ),
                    Container(
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          Strings().cancel,
                          style: CustomTextStyle().bold(
                              context, FontSize.f12,
                              CustomColor().appBlueLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showAlarmDialog() {

    return StatefulBuilder(
      builder: (context, setState)
      {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: GestureDetector(
            onTap: () {
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Strings().reminder,
                  style: CustomTextStyle().regular(
                      context, FontSize.f14, CustomColor().appGray),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CustomColor().appBlue,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _selectDate(context);
                    },
                    child: Text(
                      Strings().set,
                      style: CustomTextStyle().bold(
                          context, FontSize.f12, Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CustomColor().appBlue,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      selectedDate = DateTime.now();
                    },
                    child: Text(
                      Strings().remove,
                      style: CustomTextStyle().bold(
                          context, FontSize.f12, Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showTagDialog() {

    return StatefulBuilder(
      builder: (context, setState)
      {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    Strings().addTag,
                    style: CustomTextStyle().regular(
                        context, FontSize.f14, CustomColor().appGray),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: tagController,

                  autocorrect: false,
                  minLines: 1,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: Strings().tagHint,
                    hintStyle: CustomTextStyle().medium(context, FontSize.f14, CustomColor().appGray.withOpacity(0.5)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1,color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1,color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: CustomColor().appBlue,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                        },
                        child: Text(
                          Strings().done,
                          style: CustomTextStyle().bold(
                              context, FontSize.f12, Colors.white),
                        ),
                      ),
                    ),
                    Container(
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          Strings().cancel,
                          style: CustomTextStyle().bold(
                              context, FontSize.f12,
                              CustomColor().appBlueLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showFeatureChoose() {

    return StatefulBuilder(
      builder: (context, setState)
      {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: GestureDetector(
            onTap: () {
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Strings().features,
                  style: CustomTextStyle().regular(
                      context, FontSize.f14, CustomColor().appGray),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CustomColor().appBlue,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickColor();
                    },
                    child: Text(
                      Strings().addColor,
                      style: CustomTextStyle().bold(
                          context, FontSize.f12, Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CustomColor().appBlue,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      note.isFavourite = note.isFavourite ? false : true;
                    },
                    child: Text(
                      note.isFavourite ? Strings().removeFromFavourites : Strings().addToFavourites,
                      style: CustomTextStyle().bold(
                          context, FontSize.f12, Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: CustomColor().appBlue,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      addTask();
                    },
                    child: Text(
                      Strings().addTasks,
                      style: CustomTextStyle().bold(
                          context, FontSize.f12, Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color pickerColor = Color(0xffffffff);

  addTask() {
    setState(() {
      final noteContent = NoteContent();
      noteContent.type = NoteContentType.checkBox;
      noteContent.value = CheckBox();
      note.content.add(noteContent);
    });
  }

  pickColor() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(Strings().addColor),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings().done),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

}