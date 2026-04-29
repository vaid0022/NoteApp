import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class db {
  //Singlonton -for createing only one instance(object)
  db._(); //constructor privataisazion
  static final String TableNote = "note";
  static final String S_No = "sno";
  static final String Title = "title";
  static final String Description = "discription";

  static final db getInstaance = db
      ._(); //static is use at compile time, Now you can call only this Fun and cant create clone of same function

  Database? mydb;

  //db open -(pat->if exists than open else create
  Future<Database> getdb() async {
    if (mydb != null) {
      return mydb!;
    } else {
      mydb = await opendb();
      return await mydb!;
    }
  }

  Future<Database> opendb() async {
    Directory dir = await getApplicationCacheDirectory();

    String dbpath = join(dir.path, "notedb.db");
    return await openDatabase(
      dbpath,
      onCreate: (db, version) {
        //create Tables
        db.execute('''
        create $TableNote (
         $S_No integer primary key autoincrement,
         $Title text,
         $Description text
        ''');
      },
      version: 1,
    ); //version is use for change schema
  }

  //all queries
  //insertaion
  Future<bool> addNote({required String mTitle, required String mdec}) async {
    var db = await getdb();
    int roweffected = await db.insert(TableNote, {
      Title: mTitle,
      Description: mdec,
    });
    return roweffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNote() async {
    var db = await getdb();
    List<Map<String, dynamic>> mdata = await db.query(TableNote);
    return mdata;
  }

  Future<bool> update({required String uTitle, required String uDec}) async {
    var db = await getdb();
    int rowupdated = await db.update(TableNote, {
      Title: uTitle,
      Description: uDec,
    });
    return rowupdated > 0;
  }
}
