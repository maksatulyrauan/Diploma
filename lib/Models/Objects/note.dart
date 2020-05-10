import 'dart:io';

import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

class Note {
  int id;
  int notebookId;
  String title;
  DateTime dateModified;
  List<NoteContent> content = [];
  int color;
  bool isFavourite = false;
  List<String> tags = [];
}

class NoteContent {
  NoteContentType type;
  dynamic value;

//  NoteContent(this.type, this.value);

}

class CheckBox {
  bool isDone = false;
  String text;
}

class ImageContent {
  File image;
  String imageUrl;

}