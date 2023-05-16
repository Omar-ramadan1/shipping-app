import 'package:flutter/material.dart';

class AppDecor {
  static BoxDecoration tableDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
        bottomLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ));
      
      
DropdownMenuItem<String> buildmenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Padding(
      padding: const EdgeInsets.only(left: 38),
      child: Text(
        "   ${item}",
        style: TextStyle(fontSize: 15),
      ),
    ));

}


