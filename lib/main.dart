import 'package:flutter/material.dart';
import 'package:noteapp/DATA/LOCAL/database.dart';
import 'package:noteapp/home.dart';
void main(){
  runApp(_materialApp());
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
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}