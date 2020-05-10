import 'dart:async';

import 'package:diploma_note/Main/Notes/all_notes_view.dart';
import 'package:diploma_note/Main/Notes/notes_of_notebook_view.dart';
import 'package:diploma_note/Models/Objects/notebook.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_padding.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class NotebooksView extends StatefulWidget {
  @override
  _NotebooksViewState createState() => _NotebooksViewState();
}

class _NotebooksViewState extends State<NotebooksView> {

  TextEditingController messageController;
  TextEditingController notebookNameController;

  @override
  void initState() {

    super.initState();
    
    if(DataHolder().notebooks.isEmpty) {
      getNoteBooks();
    }

    messageController = new TextEditingController();
    notebookNameController = new TextEditingController();
  }

  getNoteBooks() {
    ApiManager().getNotebooks(() {
      setState(() {

      });
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: <Widget>[
          Container(
            width: Constants().width,
            height: Constants().statusBarHeight + 10,
            color: Colors.black54,
          ),
//          Container(
//            color: Colors.black,
//            child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: TextField(
//                      minLines: 1,
//                      onChanged: (newValue) {
//
//                      },
//                      maxLines: 1,
//                      controller: messageController,
//                      autocorrect: false,
//                      textAlignVertical: TextAlignVertical.center,
//                      style: CustomTextStyle().regular(context, FontSize.f12, Colors.white),
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10,),
//                        hintText: Strings().searchNotebook,
//                        hintStyle: CustomTextStyle().regular(context, FontSize.f12, CustomColor().appGray),
//                        focusedBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(10)),
//                          borderSide: BorderSide(width: 1,color: Colors.red.withOpacity(0)),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(10)),
//                          borderSide: BorderSide(width: 1,color: Colors.green.withOpacity(0)),
//                        ),
//                        prefixIcon: Icon(
//                          Icons.search,
//                          color: CustomColor().appGray,
//                        ),
//                      ),
//                    ),
//                  ),
//                ]
//            ),
//          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                color: CustomColor().appBlue,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10.0, top: 10),
                  itemCount: 3 + DataHolder().notebooks.length,
                  itemBuilder: (context, position) {
                    switch(position) {
                      case 0:
                        return allNotes();
                      case 1:
                        return allNotifications();
                      case 2:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              Strings().notebooks,
                              style: CustomTextStyle().bold(context, FontSize.f18, Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialogView();
                              },
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        );
                      default:
                        return notebook(DataHolder().notebooks.elementAt(position - 3));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    DataHolder().notebooks.clear();

    getNoteBooks();

    setState(() {

    });

    completer.complete();

    return completer.future;
  }

  createNotebook() {
    var title = notebookNameController.text;

    if(title != null && title != '') {
      ApiManager().createNotebook(title, () {
        setState(() {

          print(DataHolder().notebooks.length);
        });
      }, (errorCodeType) {
        ErrorHandler().showAlert(context, errorCodeType);
      });
    }

  }

  Widget allNotes() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotesView()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.note,
              size: CustomPadding().f16(),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              Strings().allNotes,
              style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget allNotifications() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.notifications,
            size: CustomPadding().f16(),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Strings().reminders,
            style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
          )
        ],
      ),
    );
  }

  Widget notebook(Notebook notebook) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesOfNotebookView(notebook: notebook,)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.note,
              size: CustomPadding().f16(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                notebook.title,
                style: CustomTextStyle().regular(context, FontSize.f16, Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                notebook.numberOfNotes.toString(),
                style: CustomTextStyle().regular(context, FontSize.f12, Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDialogView() {
    showDialog(
      context: context,
      builder: (BuildContext context) => showNotebookCreateDialog(),
    );
  }

  Widget showNotebookCreateDialog() {

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
                    Strings().createNotebook,
                    style: CustomTextStyle().regular(
                        context, FontSize.f14, CustomColor().appGray),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: notebookNameController,

                  autocorrect: false,
                  minLines: 1,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  style: CustomTextStyle().regular(context, FontSize.f14, Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: Strings().notebookTitleHint,
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
                          Navigator.of(context).pop();
                          createNotebook();
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
}