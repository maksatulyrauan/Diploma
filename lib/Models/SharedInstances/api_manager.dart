import 'dart:convert';

import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/Objects/notebook.dart';
import 'package:diploma_note/Models/SharedInstances/constants.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ErrorCallBack = void Function(ErrorCodeType);
typedef SuccessCallBack = void Function();

class ApiManager {

  static final ApiManager _singleton = ApiManager._internal();

  BuildContext context;

  factory ApiManager() {
    return _singleton;
  }

  ApiManager._internal();

  Future<void> userRegister(String email, String firstName, String lastName, String password, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {

    var header = {
      'Content-type': 'application/json'
    };
    var url = Constants().apiEndpoint + 'users/create/';
    var jsonString = {'email': email, 'first_name': firstName, 'last_name': lastName, 'password': password};

    var pop = json.encode(jsonString);
    var response = await http.post(url, body: pop, headers: header);

    Map<String, dynamic> result = jsonDecode(response.body);
    print(response.body);

    if (response.statusCode == 200) {

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> userLogin(String email, String password, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {

    var header = {
      'Content-type': 'application/json'
    };
    var url = Constants().apiEndpoint + 'users/api/token/';
    var jsonString = {'email': email, 'password': password};

    var pop = json.encode(jsonString);
    var response = await http.post(url, body: pop, headers: header);

    Map<String, dynamic> result = jsonDecode(response.body);
    print(response.body);

    if (response.statusCode == 200) {

      final accessToken = result['access'];
      Constants().token = accessToken;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', accessToken);
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> userLogOut(SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {

    Constants().token = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);

    DataHolder().allNotes.clear();
    DataHolder().notebooks.clear();

    successCallBack();
  }

  Future<void> getNotebooks(SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {

    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/notebooks';

    var response = await http.get(url, headers: header);

    List<dynamic> result = jsonDecode(response.body);

    print('Notebooks');
    print(response.body);
    if (response.statusCode == 200) {
      for(var data in result) {
        final notebook = Notebook();
        notebook.id = data['id'];
        notebook.title = data['name'];
        notebook.numberOfNotes = data['number_of_notes'];
        DataHolder().notebooks.add(notebook);
      }
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> getAllNotes(SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/all-notes/';

    var response = await http.get(url, headers: header);

    List<dynamic> result = jsonDecode(response.body);
    print('All notes');
    print(response.body);

    if (response.statusCode == 200) {
      for(var data in result) {
        final note = Note();
        note.id = data['id'];
        note.title = data['name'];


        final dateCreated = data['modified'].toString().split('T').first;

        final timeCreated = data['modified'].toString().split('T').last.toString().split('.').first;

        final hour = timeCreated.split(':').first;

        final minute = timeCreated.split(':')[1];

        final date = dateCreated.split('-');

        note.dateModified = DateFormat("dd.MM.yyyy HH:mm").parse(date.last + '.' + date[1] + '.' + date.first + ' ' + hour + ':' + minute);


        DataHolder().allNotes.add(note);
      }
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> getAllFavouritesNotes(SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/favorites/';

    var response = await http.get(url, headers: header);

    List<dynamic> result = jsonDecode(response.body);

    print('Favorites');
    print(response.body);

    if (response.statusCode == 200) {

      for(var data in result) {

        final note = Note();
        note.id = data['id'];
        note.title = data['name'];
        note.isFavourite = true;

        final dateCreated = data['modified'].toString().split('T').first;

        final timeCreated = data['modified'].toString().split('T').last.toString().split('.').first;

        final hour = timeCreated.split(':').first;

        final minute = timeCreated.split(':')[1];

        final date = dateCreated.split('-');

        note.dateModified = DateFormat("dd.MM.yyyy HH:mm").parse(date.last + '.' + date[1] + '.' + date.first + ' ' + hour + ':' + minute);


        DataHolder().allFavouriteNotes.add(note);
      }
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> getNotesOfNotebook(List<Note> notes, int id, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/notebooks/$id/notes/';

    var response = await http.get(url, headers: header);

    List<dynamic> result = jsonDecode(response.body);

    print(response.body);

    if (response.statusCode == 200) {

      for(var data in result) {

        final note = Note();
        note.id = data['id'];
        note.title = data['name'];


        final dateCreated = data['modified'].toString().split('T').first;

        final timeCreated = data['modified'].toString().split('T').last.toString().split('.').first;

        final hour = timeCreated.split(':').first;

        final minute = timeCreated.split(':')[1];

        final date = dateCreated.split('-');

        note.dateModified = DateFormat("dd.MM.yyyy HH:mm").parse(date.last + '.' + date[1] + '.' + date.first + ' ' + hour + ':' + minute);


        notes.add(note);
      }
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> createNote(Note note, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/create/';

    var content = [];
    for(var i in note.content) {

      switch(i.type) {
        case NoteContentType.checkBox:
          CheckBox checkBox = i.value;
          content.add({'type': i.type.index, 'value': {'isDone': checkBox.isDone, 'text': checkBox.text}});
          break;
        case NoteContentType.text:
          String text = i.value;
          content.add({'type': i.type.index, 'value': {'text': text}});
          break;
        case NoteContentType.image:
          ImageContent imageContent = i.value;
          final imageData = base64Encode(imageContent.image.readAsBytesSync());
//          final extension = image.path.split(".").last;
          print('Image Data: $imageData');
          print(i.type.index);
          content.add({'type': i.type.index, 'value': {'path': imageData}});
          break;
      }
    }
    var jsonString = {'name': note.title, 'content': content,
      'hash_tags': note.tags, 'notebook_id': note.notebookId,
      'color': note.color, 'is_favorite': note.isFavourite};

    var pop = json.encode(jsonString);

    var response = await http.post(url, body: pop, headers: header);

//    Map<String, dynamic> result = jsonDecode(response.body);

    print(response.body);

    if (response.statusCode == 200) {

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> createNotebook(String title, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/notebooks/create/';

    var jsonString = {'name': title};

    var pop = json.encode(jsonString);

    var response = await http.post(url, body: pop, headers: header);

    print(response.body);

    if (response.statusCode == 201) {

      print('Here');
      Notebook notebook = Notebook(title: title);

      DataHolder().notebooks.add(notebook);

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> addFavorite(int id, bool favorite, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/add/favorite/$id/';

    var jsonString = {'favorite': favorite};

    var pop = json.encode(jsonString);

    var response = await http.put(url, body: pop, headers: header);//http.post(url, body: pop, headers: header);

    print(response.body);

    if (response.statusCode == 200) {

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> getNoteDetails(Note note, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    print('Erke');
    var url = Constants().apiEndpoint + '/notes/${note.id}/';

    var response = await http.get(url, headers: header);

    Map<String, dynamic> result = jsonDecode(response.body);

    print('Dertails');
    print(response.body);

    if (response.statusCode == 200) {

      print('Here');
      final contents = result['content'];
      print(contents);
      note.title = result['name'];
      print(note.title);
      note.isFavourite = result['favorite'];
      print(note.isFavourite);
      note.color = result['color'];
      print(note.color);
      print(result['hash_tags_list']);
//      List<String> list = result['hash_tags_list'];
//      print(list);
//      note.tags = list;

      for(var contentDetail in contents) {
        final content = NoteContent();
        content.type = NoteContentType.values[contentDetail['type']];

        switch(content.type) {

          case NoteContentType.text:
            content.value = contentDetail['text'];
            break;
          case NoteContentType.checkBox:
            final checkBox = CheckBox();
            checkBox.text = contentDetail['text'];
            checkBox.isDone = contentDetail['is_done'];
            content.value = checkBox;
            break;
          case NoteContentType.image:
            final imageContent = ImageContent();
            imageContent.imageUrl = contentDetail['path'];
            content.value = imageContent;
            break;
        }
        note.content.add(content);
      }

      DataHolder().editingNote = note;
      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> addNoteToNotebook(Notebook notebook, Note note, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/notebooks/${notebook.id}/add-notes/';

    var jsonString = {'pk': note.id};

    var pop = json.encode(jsonString);

    var response = await http.post(url, body: pop, headers: header);

    Map<String, dynamic> result = jsonDecode(response.body);

    print('Add Note');
    print(response.body);

    if (response.statusCode == 200) {

      print('');

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }

  Future<void> search(List<Note> searchingNotes, String text, SuccessCallBack successCallBack, ErrorCallBack errorCallBack) async {
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${Constants().token}',
      "Accept": "application/json"
    };

    var url = Constants().apiEndpoint + '/notes/filter?word=$text';

//    var jsonString = {'word': text};
//
//    var pop = json.encode(jsonString);

    var response = await http.get(url, headers: header);

    List<dynamic> result = jsonDecode(response.body);

    print('Search');
    print(response.body);

    if (response.statusCode == 200) {

      for(var data in result) {
        final note = Note();
        note.id = data['id'];
        note.title = data['name'];


        final dateCreated = data['modified'].toString().split('T').first;

        final timeCreated = data['modified'].toString().split('T').last.toString().split('.').first;

        final hour = timeCreated.split(':').first;

        final minute = timeCreated.split(':')[1];

        final date = dateCreated.split('-');

        note.dateModified = DateFormat("dd.MM.yyyy HH:mm").parse(date.last + '.' + date[1] + '.' + date.first + ' ' + hour + ':' + minute);


        searchingNotes.add(note);
      }

      print('');

      successCallBack();
    }
    else {
//      final data = result['data'];
//      ErrorCodeType f = ErrorCodeType.values.firstWhere((e) =>
//      e
//          .toString()
//          .split('.')
//          .last == data);
//      errorCallBack(f);
    }
  }
}


