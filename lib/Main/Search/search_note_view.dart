import 'package:diploma_note/Main/Notes/note_item.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/strings.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class SearchNoteView extends StatefulWidget {
  @override
  _SearchNoteViewState createState() => _SearchNoteViewState();
}

class _SearchNoteViewState extends State<SearchNoteView> {

  TextEditingController searchController;

  @override
  void initState() {

    super.initState();

    searchController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10.0),
                  itemCount: DataHolder().allNotes.length,
                  itemBuilder: (context, position) {
                    return NoteItem(
                      note: DataHolder().allNotes.elementAt(position),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.only(left: 10, right: 10, top: Constants().statusBarHeight + 10),
//          child: Column(
//            children: <Widget>[
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.black,
//                  borderRadius: BorderRadius.all(Radius.circular(10)),
//
//                ),
//                child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: TextField(
//                          minLines: 1,
//                          onChanged: (newValue) {
//
//                          },
//                          maxLines: 1,
//                          controller: messageController,
//                          autocorrect: false,
//                          textAlignVertical: TextAlignVertical.center,
//                          style: CustomTextStyle().regular(context, FontSize.f12, Colors.white),
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10,),
//                            hintText: Strings().searchNote,
//                            hintStyle: CustomTextStyle().regular(context, FontSize.f12, CustomColor().appGray),
//                            focusedBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.all(Radius.circular(10)),
//                              borderSide: BorderSide(width: 1,color: Colors.red.withOpacity(0)),
//                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.all(Radius.circular(10)),
//                              borderSide: BorderSide(width: 1,color: Colors.green.withOpacity(0)),
//                            ),
//                            prefixIcon: Icon(
//                              Icons.search,
//                              color: CustomColor().appGray,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ]
//                ),
//              ),
//              Expanded(
//                child: ListView.builder(
//                  itemCount: 5,
//                  itemBuilder: (context, position) {
//                    return Text('dfsg');
//                  },
//                ),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
  }
}
