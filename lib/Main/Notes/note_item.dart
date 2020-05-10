import 'package:diploma_note/Models/Notifiers/main_page_notifier.dart';
import 'package:diploma_note/Models/Objects/note.dart';
import 'package:diploma_note/Models/SharedInstances/api_manager.dart';
import 'package:diploma_note/Models/SharedInstances/custom_color.dart';
import 'package:diploma_note/Models/SharedInstances/custom_text_style.dart';
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Models/SharedInstances/error_handler.dart';
import 'package:diploma_note/Utilities/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatefulWidget {

  NoteItem({this.note});

  Note note;

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    final mainPageNotifier = Provider.of<MainPageNotifier>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          ApiManager().getNoteDetails(widget.note, () {
            DataHolder().editingNote = widget.note;
            mainPageNotifier.currentPage = 1;
          }, (errorCodeType) {
            ErrorHandler().showAlert(context, errorCodeType);
          });

        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: widget.note.color != null ? Color(widget.note.color) : Colors.white,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.note.title,
                    style: CustomTextStyle().bold(context, FontSize.f16, Colors.black),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        final isFavorite = widget.note.isFavourite;
                        ApiManager().addFavorite(widget.note.id, !isFavorite, () {
                          if(isFavorite) {
                            DataHolder().allFavouriteNotes.add(widget.note);
                          }
                          else {
                            for(var _note in DataHolder().allFavouriteNotes) {
                              if(_note.id == widget.note.id) {
                                final index = DataHolder().allFavouriteNotes.indexOf(_note);
                                DataHolder().allFavouriteNotes.removeAt(index);
                                break;
                              }
                            }
                          }
                          setState(() {
                            widget.note.isFavourite = !isFavorite;
                          });
                        }, (errorCodeType) {
                          ErrorHandler().showAlert(context, errorCodeType);
                        });
                      },
                      child: Icon(
                        widget.note.isFavourite ? Icons.star : Icons.star_border,
                        color: Colors.amberAccent,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      dateTime(widget.note.dateModified),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: CustomTextStyle().semibold(context, FontSize.f14, CustomColor().appGray),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String dateTime(DateTime date) {
  var timeString = 'Только что';
  if(date == null) {
    date = DateTime.now();
  }

  final day = DateTime.now().difference(date).inDays;
  final hour = DateTime.now().difference(date).inHours;
  final minute = DateTime.now().difference(date).inMinutes;
  final second = DateTime.now().difference(date).inSeconds;

  if(day != 0) {
    if(day > 31) {
      final month = day % 31;
      if(month > 12) {
        final year = month % 12;
        if(year > 4 && year < 21) {
          timeString = '$year лет назад';
        }
        else if(year % 10 == 1) {
          timeString = '$year год назад';
        }
        else if(year % 10 < 5) {
          timeString = '$year года назад';
        }
        else {
          timeString = '$year лет назад';
        }
      }
      else if(month > 4 && month < 21) {
        timeString = '$month месяцев назад';
      }
      else if(month % 10 == 1) {
        timeString = '$month месяц назад';
      }
      else if(day % 10 < 5) {
        timeString = '$month месяца назад';
      }
      else {
        timeString = '$month месяцев назад';
      }
    }
    else if(day > 4 && day < 21) {
      timeString = '$day дней назад';
    }
    else if(day % 10 == 1) {
      timeString = '$day день назад';
    }
    else if(day % 10 < 5) {
      timeString = '$day дня назад';
    }
    else {
      timeString = '$day дней назад';
    }
  }
  else if(hour != 0) {
    if(hour > 4 && hour < 21) {
      timeString = '$hour часов назад';
    }
    else if(hour % 10 == 1) {
      timeString = '$hour час назад';
    }
    else if(hour % 10 < 5) {
      timeString = '$hour часа назад';
    }
    else {
      timeString = '$hour часов назад';
    }
  }
  else if(minute != 0) {
    if(minute > 4 && minute < 21) {
      timeString = '$minute минут назад';
    }
    else if(minute % 10 == 1) {
      timeString = '$minute минуту назад';
    }
    else if(minute % 10 < 5) {
      timeString = '$minute минуты назад';
    }
    else {
      timeString = '$minute минут назад';
    }
  }
  else if(second != 0) {
    if(second > 4 && second < 21) {
      timeString = '$second секунд назад';
    }
    else if(second % 10 == 1) {
      timeString = '$second секунду назад';
    }
    else if(second % 10 < 5) {
      timeString = '$second секунды назад';
    }
    else {
      timeString = '$second секунд назад';
    }
  }
  return timeString;
}