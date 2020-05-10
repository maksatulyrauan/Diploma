import 'package:diploma_note/Main/Notes/note_item.dart';
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
import 'package:flutter/material.dart';

class NotesOfNotebookView extends StatefulWidget {

  NotesOfNotebookView({this.notebook});

  Notebook notebook;

  @override
  _NotesOfNotebookViewState createState() => _NotesOfNotebookViewState();
}

class _NotesOfNotebookViewState extends State<NotesOfNotebookView> {
  TextEditingController searchController;

  @override
  void initState() {

    super.initState();
    if(DataHolder().allNotes.isEmpty) {
      getAllNotes();
    }
    if(widget.notebook.notes.isEmpty) {
      getNotes();
    }
    searchController = new TextEditingController();
  }

  getNotes() {
    ApiManager().getNotesOfNotebook(widget.notebook.notes, widget.notebook.id, () {

      setState(() {

      });
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  @override
  Widget build(BuildContext context) {
//    final mainPageNotifier = Provider.of<MainPageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.notebook.title,
          style: CustomTextStyle().bold(context, FontSize.f16, Colors.white),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialogView(DialogType.addToNotebook);
                },
                child: Icon(
                    Icons.add,
                ),
              )
          ),
        ],
        backgroundColor: Colors.black54,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        controller: searchController,
                        autocorrect: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: CustomTextStyle().regular(context, FontSize.f12, Colors.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10,),
                          hintText: Strings().searchNote,
                          hintStyle: CustomTextStyle().regular(context, FontSize.f12, CustomColor().appGray),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1,color: Colors.red.withOpacity(0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1,color: Colors.green.withOpacity(0)),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: CustomColor().appGray,
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                itemCount: widget.notebook.notes.length,
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {

//                      mainPageNotifier.currentPage = 1;
                    },
                    child: NoteItem(
                      note: widget.notebook.notes.elementAt(position),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAllNotes() {
    ApiManager().getAllNotes(() {

      setState(() {

      });
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  showDialogView(DialogType dialogType) {

    showDialog(
      context: context,
      builder: (BuildContext context) => showAddToNotebookDialog(),
    );
  }

  Widget showAddToNotebookDialog() {

    List<int> selectedNoteIds = [];
    List<int> noteIds = [];

    for(var i in widget.notebook.notes) {
      noteIds.add(i.id);
    }
    List<Note> notes = DataHolder().allNotes.where((element) => !noteIds.contains(element.id)).toList();

    print(notes);
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
                      itemCount: notes.length,
                      itemBuilder: (context, position) {
                        Note note = notes.elementAt(position);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedNoteIds.contains(note.id) ? selectedNoteIds.remove(note.id) : selectedNoteIds.add(note.id);
                            });

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              note.title,
                              style: CustomTextStyle().regular(context, FontSize.f12, selectedNoteIds.contains(note.id) ? CustomColor().appBlue : Colors.black),
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

                          Navigator.of(context).pop();
                          addNoteToNotebook(notes);
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

  addNoteToNotebook(List<Note> notes) {
    for(var _note in notes) {
      ApiManager().addNoteToNotebook(widget.notebook, _note, () {
        setState(() {
          widget.notebook.notes.add(_note);
        });
      }, (errorCodeType) {
        ErrorHandler().showAlert(context, errorCodeType);
      });
    }

  }
}
