import 'package:diploma_note/Models/Objects/note.dart';
import 'package:flutter/material.dart';

class NoteContentImage extends StatefulWidget {

  NoteContentImage({this.noteContent});
  NoteContent noteContent;

  @override
  _NoteContentImageState createState() => _NoteContentImageState();
}

class _NoteContentImageState extends State<NoteContentImage> {
  @override
  Widget build(BuildContext context) {

    ImageContent imageContent = widget.noteContent.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        child: imageContent.imageUrl == null ?
        Image.file(
          imageContent.image,
          fit: BoxFit.fill,
        ) : Image.network(
          imageContent.imageUrl,
        ),
      ),
    );
  }
}
