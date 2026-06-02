import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';
import 'package:noteapp/DATA/LOCAL/datamanagement.dart';
import 'package:noteapp/note.dart';
import 'package:noteapp/providers.dart';
import 'package:noteapp/setting.dart';
import 'package:noteapp/viewnote.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<databaseprovier>(context, listen: false).getAllData();
    });
    getvalue();
  }

  @override
  Widget build(BuildContext context) {
    var provoder = Provider.of<databaseprovier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Note")),

      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Provider.of<themeProvider>(context).getThemeMode()
                    ? AssetImage('assets/theme_images/dark2.jpg')
                    : AssetImage('assets/theme_images/white.jpg'),
            fit: BoxFit.cover
            )
          ),
          child:
              Column(
                children: [
              DrawerHeader(child: Card(
                  elevation:1,
                  child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings,size: 30,),
                  Text(" Setting Menu",style: TextStyle(fontSize: 25),),
                ],
              )))),
              ListTile(
                title: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Home",style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => setting()),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Setting",style: TextStyle(fontSize:18),),
                    ),
                  ),
                ),
              ),
                  ]
              )

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Provider.of<themeProvider>(context).getThemeMode()
                ? AssetImage('assets/theme_images/dark.jpg')
                : AssetImage('assets/theme_images/white2.jpg') ,
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          itemCount: provoder.allnotes.length,
          itemBuilder: (context, index) {

            Map<String, dynamic> id = provoder.allnotes[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => noteview(noteno: id)),
                );
              },

              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(30),
                child:
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .4),
                          borderRadius: BorderRadius.circular(21),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Stack(
                            children: [

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 40),
                                    Text(
                                      provoder.allnotes[index]['titlenote'],
                                        maxLines:2 ,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Text(
                                      provoder
                                          .allnotes[index]['noteDescription'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 12,
                                    ),
                                  ],
                                ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 35,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => modifyNote(
                                                isUpdate: true,
                                                noteno:
                                                    provoder.allnotes[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 35,
                                      child: IconButton(
                                        onPressed: () {
                                          int noteid = int.parse(
                                            id['noteno'].toString(),
                                          );
                                          provoder.Delete(noteId: noteid);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) ??
                      Text("NOTE is Empty"),
                ),

            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 22,
            mainAxisSpacing:22 ,
            mainAxisExtent: 350
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Provider.of<themeProvider>(context, listen: false).getThemeMode()
            ? Colors.blue
            : Colors.tealAccent,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => modifyNote(isUpdate: false),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );

  }

  void getvalue() async {
    var prefs = await SharedPreferences.getInstance();
    bool? ThemeMode = prefs.getBool("mode");
    var Modevalue = ThemeMode != null ? "ThemeMode" : "NO vlaue";
    print(Modevalue);

    if (ThemeMode != null) {
      Provider.of<themeProvider>(
        context,
        listen: false,
      ).updateTheme(value: ThemeMode);
    }
  }
}
