import 'dart:async';

import 'package:diploma_note/Main/Notes/note_item.dart';
import 'package:diploma_note/Models/Objects/note.dart';
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

class FavouritesView extends StatefulWidget {
  @override
  _FavouritesViewState createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {

  @override
  void initState() {

    super.initState();


    if(DataHolder().allFavouriteNotes.isEmpty) {

      getAllFavouriteNotes();
    }

  }

  getAllFavouriteNotes() {
    ApiManager().getAllFavouritesNotes(() {

      setState(() {
      });
    }, (errorCodeType) {
      ErrorHandler().showAlert(context, errorCodeType);
    });
  }


  @override
  Widget build(BuildContext context) {



    return Column(
      children: <Widget>[
        Container(
          width: Constants().width,
          height: Constants().statusBarHeight + 10,
          color: Colors.black54,
        ),
        Container(
          width: Constants().width,
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                Strings().favourite,
                style: CustomTextStyle().bold(context, FontSize.f14, Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              DataHolder().allFavouriteNotes.isEmpty ? Center(
                child: Text(
                  Strings().favouritesEmpty,
                  style: CustomTextStyle().regular(context, FontSize.f14, CustomColor().appGray),
                ),
              ) : Text(''),
              RefreshIndicator(
                color: CustomColor().appBlue,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  itemCount: DataHolder().allFavouriteNotes.length,
                  itemBuilder: (context, position) {
                    return NoteItem(
                      note: DataHolder().allFavouriteNotes.elementAt(position),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    DataHolder().allFavouriteNotes.clear();

    getAllFavouriteNotes();

    completer.complete();

    return completer.future;
  }

}
