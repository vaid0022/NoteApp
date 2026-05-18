import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class roundbutton extends StatelessWidget {
  final Color? bgcolor;
  final Icon? btnicon;
  final FaIcon? btnFaiconl;
  final VoidCallback? callback;
  final String? btntitle;

  roundbutton({
    this.bgcolor,
    required this.callback,
    this.btnicon,
    this.btnFaiconl,
    this.btntitle,
  });

  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: bgcolor,
      onPressed: callback,
      child: btntitle != null
          ? Text(btntitle!)
          : btnicon ?? btnFaiconl,
    );
  }
}

class button extends StatelessWidget {
  final Color bgcolor;
  final Icon? btnicon;
  final FaIcon? btnFaiconl;
  final VoidCallback? callback;
  final String? btntitle;

  button({
    this.bgcolor = Colors.blue,
    required this.callback,
    this.btnicon,
    this.btnFaiconl,
    this.btntitle,
  });

  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: bgcolor),
      onPressed: callback,
      child: btntitle != null
          ? Text(btntitle!, style: TextStyle(color: Colors.white, fontSize: 30))
          : btnicon ?? btnFaiconl,
    );
  }
}
class textField extends StatelessWidget {

  final String? lname;
  final Icon? preffix;
  final Icon? suffix;

  final Color? borderColor;
  final double? borderWidth;

  final double? paddingHorezontal;
  final double? paddinVertical;

  final TextEditingController tcontroller;

  final bool isDescription;

  textField({
    required this.tcontroller,
    required this.isDescription,

    this.borderColor,
    this.borderWidth,

    this.lname,
    this.preffix,
    this.suffix,

    this.paddingHorezontal = 20.0,
    this.paddinVertical = 10.0,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: tcontroller,

      maxLines: isDescription ? null : 1,

      expands: isDescription,

      keyboardType:
      isDescription
          ? TextInputType.multiline
          : TextInputType.text,

      textAlignVertical:
      isDescription
          ? TextAlignVertical.top
          : TextAlignVertical.center,

      decoration: InputDecoration(

        labelText: lname,

        prefixIcon: preffix,

        suffixIcon: suffix,

        contentPadding: EdgeInsets.symmetric(
          vertical: paddinVertical!,
          horizontal: paddingHorezontal!,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),

          borderSide: BorderSide(
            color: borderColor ?? Colors.black,
            width: borderWidth ?? 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(21),

          borderSide: BorderSide(
            color: borderColor ?? Colors.black,
            width: borderWidth ?? 1,
          ),
        ),
      ),
    );
  }
}