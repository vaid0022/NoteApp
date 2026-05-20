import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/commanwidget.dart';
import 'package:noteapp/providers.dart';
import 'package:provider/provider.dart';

class modifyNote extends StatefulWidget {
  bool isUpdate = false;
  Map<String,dynamic>?noteno;

  modifyNote({required this.isUpdate,this.noteno});


  @override
  State<modifyNote> createState() => modifyState();
}

class modifyState extends State<modifyNote> {
  var noteTitle = TextEditingController();
  var noteDescription = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(widget.isUpdate == true && widget.noteno != null)
      {
        noteTitle.text=widget.noteno!['titlenote'];
        noteDescription.text=widget.noteno!['noteDescription'];
      }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.isUpdate ? Text("Update Note") : Text("Add Note"),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 700,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:Provider.of<themeProvider>(context).getThemeMode()
                ? AssetImage('assets/theme_images/notesdark.jpg')
                : AssetImage('assets/theme_images/noteslight.jpg'),
            ),
            border: Border.all(width: 4),
            borderRadius: BorderRadius.circular(25),
            color:Provider.of<themeProvider>(context,listen: false).getThemeMode() ? Colors.white24 :Colors.cyan,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    child: SizedBox(
                      height:50 ,
                      width:300 ,
                      child: Center(
                        child: Text(
                          widget.isUpdate ? "Update Note" : "Add Note",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  textField(isDescription: false,
                    tcontroller: noteTitle,
                    borderColor: Colors.blue,
                    borderWidth: 3,
                    lname: widget.isUpdate ? "Update Title" : "Add Title",
                    suffix: Icon(Icons.title),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 250,
                    child: textField(isDescription: true,
                      tcontroller: noteDescription,
                      borderColor: Colors.blue,
                      borderWidth: 3,
                      lname: widget.isUpdate
                          ? "Update Description"
                          : "Add Description",
                      suffix: Icon(Icons.description),
                      paddinVertical: 50,
                    ),
                  ),
                  SizedBox(height: 60),
              
                  Row(
                    children: [
                      Expanded(
                        child: button(
                          callback: () {
                           if(noteTitle.text.isNotEmpty && noteDescription.text.isNotEmpty)
                             {
                               if(widget.isUpdate)
                                 {
                                   Provider.of<databaseprovier>(
                                     context,
                                     listen: false,
                                   ).updateNotes(noteId: widget.noteno?['noteno'], Title: noteTitle.text, Description:noteDescription.text);
                                 }else{
                                 Provider.of<databaseprovier>(
                                   context,
                                   listen: false,
                                 ).addNotes(
                                   Title: noteTitle.text,
                                   Description: noteDescription.text,
                                 );
                               }
                             }
                           Provider.of<databaseprovier>(context,listen: false).getAllData();
                           Navigator.pop(context);
              
                          },
                          btntitle: widget.isUpdate ? "Update" : "Add",
                        ),
                      ),
                      Expanded(
                        child: button(
                          callback: () {
                            Navigator.pop(context);
                          },
                          btnicon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.white,
                          ),
                          bgcolor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
