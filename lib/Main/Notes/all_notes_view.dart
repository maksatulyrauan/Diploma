import 'package:diploma_note/Main/CreateNote/create_note_view.dart';
import 'package:diploma_note/Main/Notes/note_item.dart';
import 'package:diploma_note/Models/Notifiers/main_page_notifier.dart';
import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllNotesView extends StatefulWidget {

  @override
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  TextEditingController searchController;

  List<Note> searchingNotes = [];

  @override
  void initState() {

    super.initState();
    if(DataHolder().allNotes.isEmpty) {
      getAllNotes();
    }
    searchController = new TextEditingController();
  }
  
  getAllNotes() {
    ApiManager().getAllNotes(() {

      setState(() {

      });
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  search(String text) {
    ApiManager().search(searchingNotes, text, () {
      print('');
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings().allNotes,
          style: CustomTextStyle().bold(context, FontSize.f16, Colors.white),
        ),
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
                        onChanged: (newValue) {
                          if(newValue == '') {
                            searchingNotes.clear();
                          }
                        },
                        onSubmitted: (newValue) {

                          search(newValue);
                        },
//                        controller: searchController,
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
                itemCount: searchingNotes.isEmpty ? DataHolder().allNotes.length : searchingNotes.length,
                itemBuilder: (context, position) {
                  final note = searchingNotes.isEmpty ? DataHolder().allNotes.elementAt(position) : searchingNotes.elementAt(position);
                  return NoteItem(
                    note: note,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}