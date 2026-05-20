import 'package:flutter/material.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/providers.dart';
import 'package:noteapp/splashScreen.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>databaseprovier(),),
          ChangeNotifierProvider(create: (_)=>themeProvider())
        ],
          child:_materialApp()
      ),);
}

class _materialApp extends  StatefulWidget
{
  @override
  State<_materialApp> createState()=> _materialState();
}

class _materialState extends State<_materialApp>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

      themeMode: Provider.of<themeProvider>(context).getThemeMode()?ThemeMode.dark:ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black)
          )
        ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home:home()
      //SplashScreen(),
    );
  }
}