import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/note.dart';
import 'package:noteapp/providers.dart';
import 'package:provider/provider.dart';

class noteview extends StatefulWidget {
  final Map<String, dynamic> noteno;
  noteview({required this.noteno});

  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteView"),

        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    modifyNote(isUpdate: true, noteno: widget.noteno),
              ),
            );
          }, icon: Icon(Icons.edit)),
          IconButton(
            onPressed: () {
                  Provider.of<databaseprovier>(context,listen: false).Delete(noteId:widget.noteno['noteno']);
                  Navigator.pop(context);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Provider.of<themeProvider>(context).getThemeMode()
                  ? AssetImage('assets/theme_images/noteViewDark.jpg')
                  : AssetImage('assets/theme_images/noteView.jpg'),
          fit: BoxFit.cover
          )
        ),
        child: Consumer<databaseprovier>(
          builder: (ctx, provider, _) {
            var note = provider.allnotes;

            return Padding(
              padding: EdgeInsets.all(20),

              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Title : ",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color:Provider.of<themeProvider>(context).getThemeMode() ? Colors.white :Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${widget.noteno['titlenote']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Provider.of<themeProvider>(context).getThemeMode() ? Colors.white :Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Card(
                          shadowColor: Colors.black,
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Note : ",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Provider.of<themeProvider>(context).getThemeMode() ? Colors.white :Colors.black,

                                    ),
                                  ),
                                  TextSpan(
                                    text: "${widget.noteno['noteDescription']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Provider.of<themeProvider>(context).getThemeMode() ? Colors.white70 :Colors.black,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
