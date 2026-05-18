import 'package:flutter/cupertino.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';
import 'package:noteapp/DATA/LOCAL/datamanagement.dart';

class databaseprovier extends ChangeNotifier
{
  db database=db.getIstance;

  List<Map<String,dynamic>> allnotes=[];

 Future<void> addNotes({required String Title,required String Description})async
  {

   await database.addNote(
        addModel(Title: Title, Description: Description)
    );
     notifyListeners();
  }

  Future<void> getAllData()async
  {
    allnotes=await database.getAllNotes();
    notifyListeners();
  }

  Future<void> updateNotes({required int noteId,required String Title,required String Description})async
  {
    await database.updateNote(
        updateModel(Note_no: noteId, Note_title: Title, note_description: Description)
    );
    notifyListeners();
  }

  Future<void> Delete({required int noteId})async
  {
    await database.DeleteNote(
        DeleteModel(Note_no: noteId)
    );
    allnotes =await database.getAllNotes();
    notifyListeners();
  }
}


class themeProvider extends ChangeNotifier
{
  bool _isDark=false;
bool getThemeMode()=>_isDark;
  void updateTheme({required bool value})
  {
    _isDark=value;
    notifyListeners();
  }
}