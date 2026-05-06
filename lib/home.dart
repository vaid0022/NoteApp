import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';
import 'package:noteapp/commanwidget.dart';
import 'package:noteapp/updatepage.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  var TitleController = TextEditingController();
  var decController = TextEditingController();

  List<Map<String, dynamic>> allNotes = [];
  db? database;

  void initState() {
    super.initState();
    database = db.getInstaance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await database!.getAllNote();
    print("DATA:$allNotes");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "NOTE",
            style: TextStyle(fontSize: 30, color: Colors.blue),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: allNotes.isNotEmpty
                ? ListView.builder(
                    itemCount: allNotes.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            width: 425,
                            height: 70,
                            child: ListTile(
                              leading: Text("${index + 1}"),
                              title: Text(allNotes[index][db.Title]),
                              subtitle: Text(allNotes[index][db.Description]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      TitleController.text =
                                      allNotes[index][db.Title];
                                      decController.text =
                                      allNotes[index][db.Description];
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return getBottomSheetWidget(
                                            context,
                                            isUpdate: true,
                                            sno: allNotes[index][db.S_No],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.update),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      int id = allNotes[index][db.S_No];
                                      setState(() {
                                        allNotes.remove(index);
                                      });
                                      bool chack = await database!.delete(
                                        id: id,
                                      );
                                      getNotes();
                                      if (!chack) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Error! ocured, please try again",
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Note Delete Succesfully..",
                                            ),
                                          ),
                                        );
                                        getNotes();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Notes is Not Available Now!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          roundbutton(
            callback: () async {
              TitleController.clear();
              decController.clear();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return getBottomSheetWidget(context);
                },
              );
            },
            btnicon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget getBottomSheetWidget(
    BuildContext context, {
    bool isUpdate = false,
    int sno = 0,
  }) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              isUpdate ? "Update Note" : "Add Note",
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(height: 70),
          textField(
            lname: "Enter Title",
            tcontroller: TitleController,
            borderColor: Colors.white,
            suffix: Icon(Icons.title),
          ),

          SizedBox(height: 30),

          textField(
            lname: "Enter Description",
            tcontroller: decController,
            paddingHorezontal: 20,
            paddinVertical: 40,
            borderColor: Colors.white,
            suffix: Icon(Icons.description),
          ),

          SizedBox(height: 40),

          Row(
            children: [
              Expanded(
                child: button(
                  callback: () async {
                    if (TitleController.text.isNotEmpty &&
                        decController.text.isNotEmpty) {
                      isUpdate
                          ? await database!.update(
                              uTitle: TitleController.text,
                              uDec: decController.text,
                              s_no: sno,
                            )
                          : await database!.addNote(
                              mTitle: TitleController.text,
                              mdec: decController.text,
                            );

                      Navigator.pop(context);

                      getNotes();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Fill Detail!")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  btntitle: isUpdate ? "Update" : "Add ",
                ),
              ),
              Expanded(
                child: button(
                  callback: () {
                    Navigator.pop(context);
                    TitleController.clear();
                    decController.clear();
                  },
                  btnicon: Icon(Icons.cancel, size: 20, color: Colors.white),
                  bgcolor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
