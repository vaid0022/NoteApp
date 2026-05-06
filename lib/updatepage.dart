
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteapp/commanwidget.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';


class updatepage extends StatefulWidget
{
  @override
  State<updatepage> createState()=>uState();
}

class uState extends State<updatepage>
{
  var uController=TextEditingController();
  List<Map<String,dynamic>> allNote=[];
  db? database;


  void initState() {
    super.initState();
    database = db.getInstaance;
    getNotes();
  }

  void getNotes() async {
    allNote = await database!.getAllNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions:[ IconButton(onPressed: (){

        }, icon: Icon(Icons.save)),]
      ),

      body: TextField(
        controller: uController,
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 430,
            horizontal:40,
          ),
        ),
      )

    );
  }
}