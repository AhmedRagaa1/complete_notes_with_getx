import 'package:complete_notes_with_getx/helper/database_services/database_helper.dart';
import 'package:complete_notes_with_getx/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

class noteController extends GetxController
{
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  var notes=<Note>[];
  int contentWordCount=0;
  int contentCharCount=0;

  @override
  void onInit()
  {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty()
  {
    // ignore: prefer_is_empty
    if( notes.length == 0)
      return true;
    else
     return false;
  }

  void addNoteToDatabase() async
  {
    var title=titleController.text;
    var content=contentController.text;
    if(title.isBlank)
    {
      title="بدون عنوان";
    }
    Note note = Note(
      title: title,
      content: content,
      dateTimeCreated: DateFormat("MMM dd yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeEdited: DateFormat("MMM dd yyyy  HH:mm:ss").format(DateTime.now()),
    );

    await DatabaseHelper.instance.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text="";
    contentController.text="";
    getAllNotes();
    Get.back();
    update();

  }

  void deleteNote(int id)async
  {
    Note note = Note(
      id: id,
    );

    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
    update();

  }

  void deleteAllNote()async
  {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
    update();
  }

  void updateNote(int id , String dtCreated)async
  {
    var title=titleController.text;
    var content=contentController.text;
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeCreated:dtCreated,
      dateTimeEdited: DateFormat("MMM dd yyyy  HH:mm:ss").format(DateTime.now()),
    );

    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text="";
    contentController.text="";
    getAllNotes();
    Get.back();
    update();

  }



  void getAllNotes()async
  {


   notes =  await DatabaseHelper.instance.getNoteList();

    update();
  }

  void shareNote(String title , String content)
  {
    Share.share("""$title
    $content
    created by Ahmed Ragaa """);


  }
}