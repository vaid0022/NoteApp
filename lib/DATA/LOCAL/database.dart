import 'dart:io';

import 'package:noteapp/DATA/LOCAL/datamanagement.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class db{
  db._();
  static db getIstance=db._();

  String TableNote="tablenote";
  String Note_No="noteno";
  String Note_Title="titlenote";
  String Note_Descreption="noteDescription";

  Database? mydb;

  Future<Database> getdb()async
  {
    if(mydb!=null)
      {
        return mydb!;
      }
    else
      {
        mydb =await opendb();
        return  mydb!;
      }
  }

  Future<Database> opendb() async
  {
    Directory Dir=await getApplicationDocumentsDirectory();

    String dbpath=join(Dir.path,"Note.db");

    return await openDatabase(
      dbpath,
    onCreate: (db,version)async{
        await db.execute(""" 
        create table $TableNote(
        $Note_No integer primary key autoincrement,
        $Note_Title text,
        $Note_Descreption text
       );
        """);
    },version: 1,
    );
  }
  Future<List<Map<String,dynamic>>> getAllNotes()async
  {
    var db=await getdb();
   List<Map<String,dynamic>> mydata=await db.query(TableNote);
    return  mydata;
  }
  Future<void> addNote(addModel note)async{
    var db=await getdb();
    await db.insert(TableNote,note.map(),
     );
  }

  Future<void> updateNote(updateModel note)
  async{
    var db= await getdb();

    db.update(TableNote,note.map(),where: "$Note_No=?",whereArgs:[note.Note_no] );
  }

  Future<void> DeleteNote(DeleteModel note) async{

    var db=await getdb();
    db.delete(TableNote,where: "$Note_No=?",whereArgs: [note.Note_no]);
  }
}